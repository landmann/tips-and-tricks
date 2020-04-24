
# Databricks

We use databricks for parallel computing. The tutorials are really simple and easy to follow, but I'm extracting the key components to easily replicate what one's done before.


## Set up the server
Steps well documented here: https://docs.databricks.com/dev-tools/db-connect.html.

TL;DR:
0. `pip uninstall pyspark`
1. `pip install -U databricks-connect==5.1.*`  or 5.2.*, etc. to match your cluster version
2. `databricks-connect configure`.<br>
  2.1. **URL**: A URL of the form https://{account}.cloud.databricks.com.<br>
  2.2. **User token**: A user [token](https://docs.databricks.com/dev-tools/api/latest/authentication.html#token-management).<br>
  2.3. **Cluster ID**: The ID of the cluster you created. You can obtain the cluster ID from the URL when selecting a cluster on the Databricks interface. It is right after `clusters/`. A cluster ID looks like 0304-201045-xxxxxxxx.<br>
  2.4. **Port**: 15001.<br>
3. `databricks-connect test`

Oftentimes, the prompt will complain about a missing Java package. If this is the case, install java with `apt install default-jre` [link](https://www.digitalocean.com/community/tutorials/how-to-install-java-with-apt-on-ubuntu-18-04).

If your cluster is not turned on, running step 4 will turn it on slowly but surely.

## Set up the Databricks CLI (Command line interface)

Databricks CLI instructions can be found here: https://docs.databricks.com/dev-tools/databricks-cli.html#set-up-the-cli.

TL;DR:
0. `pip install databricks-cli`
1. `databricks configure --token`

Test with `databricks workspace ls --profile`.

## In a Notebook
Finally, to test whether you've correctly set up the interface, type the following:

```python
from pyspark.sql import SparkSession
spark = SparkSession.builder.getOrCreate()
df = spark.read.load({YOUR_DATABRICKS_DATAFRAME})
display(df.limit(5).toPandas())
```
