# The K8s Instruct Dataset

Dataset used for building substratus-k8s-instruct an LLM that takes
a prompt expressing your desired K8s resources and generates valid K8s
YAML file.

Dataset contains 2 fields:
| Field       | Description |
| ----------- | ----------- |
| Prompt      | The natural language needed to generate a K8s YAML file |
| YAML        | A valid K8s YAML file that would account |
