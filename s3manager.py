import boto3
import pandas as pd
import pickle
import os
import s3fs
import pyarrow as pa
import pyarrow.parquet as pq
import tables


class S3Manager:

    def __init__(self, bucket_name, region_name='us-west-2', aws_access_key_id=None, aws_secret_access_key=None):
        self.bucket_name = bucket_name
        self.s3 = boto3.setup_default_session(region_name=region_name)

        if aws_access_key_id and aws_secret_access_key:
            self.client = boto3.client('s3',
                                       aws_access_key_id=aws_access_key_id,
                                       aws_secret_access_key=aws_secret_access_key)
        else:
            self.client = boto3.client('s3')

        self.resource = boto3.resource('s3')
        self.bucket = self.resource.Bucket(self.bucket_name)
        self.s3fs = s3fs.S3FileSystem()

    def list_files(self, prefix, suffix=None):
        """ Lists full path of files with given prefix and suffix."""
        files = [x.key for x in self.bucket.objects.filter(Prefix=prefix).all()]
        if suffix:
            return [x for x in files if x.endswith(suffix)]
        return files

    def list_folders(self, prefix):
        if not prefix.endswith('/'): prefix += '/'
        files = self.list_files(prefix)
        pos = prefix.count('/')
        folders = list(set([f.split('/')[pos] for f in files]))
        return [f for f in folders if '.' not in f] # check for file with file extension.

    def write_object(self, filename, local_filename):
        self.resource.Object(self.bucket_name, filename).upload_file(local_filename)

    #### CSV Parsing ####
    def read_csv(self, filename, **pd_kwargs):
        """
            :param filename: full path of file in s3.
            :param pd_kwargs: parameters to initialize pd.read_csv().
        """
        obj = self.client.get_object(Bucket=self.bucket_name, Key=filename)
        return pd.read_csv(obj['Body'], **pd_kwargs)

    def write_csv(self, df, filename, remove_local=True):
        if '.' not in filename: filename += '.csv'
        local_filename = filename.split('/')[-1]
        df.to_csv(local_filename)
        self.write_object(filename, local_filename)
        if remove_local: os.remove(local_filename)

    #### Pickle Parsing ####
    def read_pickle(self, filename):
        return pickle.loads(self.bucket
                            .Object(filename)
                            .get()['Body'].read())

    def write_pickle(self, data, filename, remove_local=True):
        if '.' not in filename: filename += '.pckl'
        local_filename = filename.split('/')[-1]
        pickle.dump(data, open(local_filename, 'wb'))
        self.write_object(filename, local_filename)
        if remove_local: os.remove(local_filename)

    #### Parquet Parsing ####
    def read_parquet(self, filename, to_df=True, **pq_kwargs):
        prqt_name = 's3://{bucket}/{filename}'.format(bucket=self.bucket_name, filename=filename)
        prqt = pq.ParquetDataset(prqt_name, filesystem=self.s3fs)
        return prqt.read_pandas(**pq_kwargs).to_pandas() if to_df else prqt

    def write_parquet(self, df, filename, remove_local=True):
        if '.' not in filename: filename += '.pq'
        local_filename = filename.split('/')[-1]
        table = pa.Table.from_pandas(df)
        pq.write_table(table, local_filename)
        self.write_object(filename, local_filename)
        if remove_local: os.remove(local_filename)

    #### HDF Parsing ####
    def read_hdf(self, filename, remove_local=True):
        local_filename = filename.split('/')[-1]
        self.client.download_file(Bucket=self.bucket_name,
                                  Key=filename,
                                  Filename=local_filename)
        out = pd.HDFStore(local_filename, 'r')
        if remove_local: os.remove(local_filename)
        return out

    def write_hdf(self, dfs, keys, filename, remove_local=True):
        if '.' not in filename: filename += '.h5'
        local_filename = filename.split('/')[-1]
        dfs = [dfs] if type(dfs) != list else dfs
        keys = [keys] if type(keys) != list else keys
        self.write_to_local_hdf(dfs, keys, local_filename)
        self.write_object(filename, local_filename)
        if remove_local: os.remove(local_filename)
        self.close_hdf()

    def write_to_local_hdf(self, dfs, keys, filename, overwrite=False):
        if '.' not in filename: filename += '.h5'
        if overwrite: os.remove(filename)
        hdf = pd.HDFStore(filename)
        for df, key in zip(dfs, keys):
            hdf.put(key, df)
        self.close_hdf()

    def close_hdf(self):
        tables.file._open_files.close_all()
