Trino Plugin
============

[![Build Status](https://github.com/sidhant-sundial/mode-trino-plugin/actions/workflows/release.yaml/badge.svg)](https://github.com/sidhant-sundial/mode-trino-plugin/actions/workflows/release.yaml)

This is a [Trino](http://trino.io/) plugin that provides a connector.

# Quick Start

To run a Docker container with the connector, run the following:
```bash
docker run \
  -d \
  --name mode-aggregate-function \
  -p 8080:8080 \
  sidhant-sundial/mode-trino-plugin:0.1
```

Then use your favourite SQL client to connect to Trino running at http://localhost:8080

## Usage

Download one of the ZIP packages, unzip it and copy the `mode-aggregate-function-0.1` directory to the plugin directory on every node in your Trino cluster.
Create a `s3.properties` file in your Trino catalog directory and set all the required properties.

```
connector.name=s3
```

After reloading Trino, you should be able to connect to the `s3` catalog.

## Build

Run all the unit tests:
```bash
mvn test
```

Creates a deployable zip file:
```bash
mvn clean package
```

Unzip the archive from the target directory to use the connector in your Trino cluster.
```bash
unzip target/*.zip -d ${PLUGIN_DIRECTORY}/
mv ${PLUGIN_DIRECTORY}/mode-aggregate-function-* ${PLUGIN_DIRECTORY}/mode-aggregate-function
```

## Debug

To test and debug the connector locally, run the `modeQueryRunner` class located in tests:
```bash
mvn test-compile exec:java -Dexec.mainClass="com.github.modeQueryRunner" -Dexec.classpathScope=test
```

And then run the Trino CLI using `trino --server localhost:8080 --no-progress` and query it:
```
trino> show catalogs;
 Catalog
---------
 s3
 system
(2 rows)

trino> show tables from s3.default;
   Table
------------
 single_row
(1 row)

trino> select * from s3.default.single_row;
 id |     type      |  name
----+---------------+---------
 x  | default-value | my-name
(1 row)
```
