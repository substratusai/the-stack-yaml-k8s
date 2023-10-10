FROM substratusai/base:latest
COPY requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt
COPY k8s-instruct-dataset-v1.ipynb .
