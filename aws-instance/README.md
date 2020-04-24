

# AWS Instance

First things first, to tunnel into your aws instance, type this:

```bash
ssh -i "PEM.pem" -L {YOUR_PORT_NUMBER}:localhost:{EC2_PORT_NUMBER} ubuntu@ec2-YOUR-EC2-ROUTE-.amazonaws.com
```

If you'd like to mount an efs on your aws:
1. install awscli: `pip install awscli --upgrade --user`
2. Change the config file with `awscli configure`.
3. Change the security group of your ec2 instance to add the efs following the instructions in the efs page.


### Working with Keys

Set environment variables in the `~/.bash_profile` by typing `export {variable}='{definition}'` and then do `source ~/.bash_profile` to update the source.

### Boto3 and S3 Readings
Refer to the `s3manager.py` file for a simple way to read and write to s3.

#### To write a file:
You first need to establish your credentials in `~/.aws/credentials`:

```bash
[default]
aws_access_key_id = YOUR_ACCESS_KEY_ID
aws_secret_access_key = YOUR_SECRET_ACCESS_KEY
```

and in `~/.aws/config` add:

```bash
[default]
region = YOUR_PREFERRED_REGION
```

where you can find the regions [here](https://docs.aws.amazon.com/general/latest/gr/rande.html#s3_region).


If you want to add the credentials to your local notebook, add

```python
s3 = boto3.client('s3', 
                  aws_access_key_id= "YOUR_ACCESS_KEY_ID",
                  aws_secret_access_key = "YOUR_SECRET_ACCESS_KEY")
```


Finally, to upload, type:
```python

bucketName = "Your S3 BucketName"
Key = "Original Name and type of the file you want to upload into s3"
outPutname = "Output file name(The name you want to give to the file after we upload to s3)"

import pickle
pickle.dump(data, open("tmp.pckl", 'wb'))

s3 = boto3.client('s3')
s3.upload_file("tmp.pckl", bucketName, outPutname)

!rm tmp.pckl
```



#### To load a file:

```python
import boto3
BUCKET_NAME='{BUCKETNAME}'

client = boto3.client('s3') #low-level functional API
resource = boto3.resource('s3') #high-level object-oriented API
bucket = resource.Bucket(BUCKET_NAME) #subsitute this for your s3 bucket name. 

for x in bucket.objects.filter(Prefix='{DATAPATH_OF_FILE}').all():
    files.append(x)
    
file = [x.key for x in files if x.key.endswith('.csv')][0] ## Read the csv file only.
obj = client.get_object(Bucket=BUCKET_NAME, Key=file)
df_raw = pd.read_csv(obj['Body'])
```
Or to download a file:
```python
BUCKET_NAME='{BUCKETNAME}'


s3_resource.Object(BUCKET_NAME, first_file_name).download_file(
    f'/tmp/{first_file_name}') # Python 3.6+
```


# Distribution Wheels

This is a guide to create a wheel and install it locally. For PyPI distributions, see [here](https://packaging.python.org/tutorials/packaging-projects/).

Make sure the appropriate folders to be included to the distribution wheel all contain an `__init__.py` file, which can be empty.

To do this, you'll need to install the `setuptools wheel` package from `pip`:

```bash
python3 -m pip install --user --upgrade setuptools wheel
```

### setup.py file

First, add a `setup.py` file in the root folder, which should look something like this:

```python
import setuptools

setuptools.setup(
    name="example-pkg-your-username",
    version="0.0.1",
    author="Example Author",
    author_email="author@example.com",
    description="A small example package",
    long_description=long_description,
    long_description_content_type="text/markdown",
    url="https://github.com/pypa/sampleproject",
    packages=setuptools.find_packages(),
    classifiers=[
        "Programming Language :: Python :: 3",
        "License :: OSI Approved :: MIT License",
        "Operating System :: OS Independent",
    ],
)
```

### Generating the wheel

Run this command:
```bash
python3 setup.py sdist bdist_wheel
```

and make sure that the dist folder looks as follows:
```bash
dist/
  example_pkg_your_username-0.0.1-py3-none-any.whl
  example_pkg_your_username-0.0.1.tar.gz
```

Now install the package to your local env.
```bash
# If already installed, make sure to uninstall so package can be updated.
pip uninstall dist/example_pkg_your_username-0.0.1-py3.none.any.whl
pip install dist/example_pkg_your_username-0.0.1-py3.none.any.whl
```
