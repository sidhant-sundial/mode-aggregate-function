ARG TRINO_VERSION
FROM nineinchnick/trino-core:$TRINO_VERSION

ARG VERSION

ADD target/mode-aggregate-function-$VERSION/ /usr/lib/trino/plugin/s3/
ADD catalog/s3.properties /etc/trino/catalog/s3.properties
