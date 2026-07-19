FROM jupyter/pyspark-notebook:spark-3.5.0

USER root

RUN pip install --no-cache-dir \
    delta-spark==3.2.0 \
    faker \
    pandas \
    pyarrow \
    boto3

USER ${NB_UID}