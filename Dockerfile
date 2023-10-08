FROM substratusai/base:latest
RUN pip3 install --no-cache-dir ipywidgets datasets
COPY k8s-instruct-dataset-v1.ipynb .
