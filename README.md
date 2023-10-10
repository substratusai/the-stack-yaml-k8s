# the-stack-yaml-k8s Dataset

This dataset is a subset of The Stack dataset data/yaml. The YAML files were
parsed and filtered out all valid K8s YAML files which is what this data is about.

The dataset contains 276520 valid K8s YAML files. The dataset was created by using
the `the-stack-k8s-yaml.ipynb` Notebook that was run on [substratus.ai](https://substratus.ai)

## How to use the dataset
```python
from  datasets  import  load_dataset
ds = load_dataset("substratusai/the-stack-yaml-k8s", split="train")
ds[0]["content"]
```

## How to reproduce?
Run the notebook `the-stack-k8s-yaml.ipynb` available in this repo.
You can run the notebook on K8s by using Substratus.ai:
```bash
git clone https://github.com/substratusai/the-stack-yaml-k8s
cd the-stack-yaml-k8s
sub notebook .
```

## Original The Stack Dataset Description

- **Homepage:** https://www.bigcode-project.org/
- **Repository:** https://github.com/bigcode-project
- **Paper:** https://arxiv.org/abs/2211.15533
- **Leaderboard:** N/A


## Dataset Structure
### Data Instances
Each data instance corresponds to one file. The content of the file is in the `content` feature, and other features (`repository_name`, `licenses`, etc.) provide some metadata. Note that a given file can appear in several different repositories that satisfy our safe-license criterion. If that is the case, only the first – in alphabetical order -- of these repositories is shown for simplicity.

### Data Fields
- `content` (string): the content of the file.
- `size` (integer): size of the uncompressed file.
- `lang` (string): the programming language. 
- `ext` (string): file extension
- `avg_line_length` (float): the average line-length of the file.
- `max_line_length` (integer): the maximum line-length of the file.
- `alphanum_fraction` (float): the fraction of characters in the file that are alphabetical or numerical characters.
- `hexsha` (string): unique git hash of file
- `max_{stars|forks|issues}_repo_path` (string): path to file in repo containing this file with maximum number of `{stars|forks|issues}`
- `max_{stars|forks|issues}_repo_name` (string): name of repo containing this file with maximum number of `{stars|forks|issues}`
- `max_{stars|forks|issues}_repo_head_hexsha` (string): hexsha of repository head
- `max_{stars|forks|issues}_repo_licenses` (string): licenses in repository 
- `max_{stars|forks|issues}_count` (integer): number of `{stars|forks|issues}` in repository
- `max_{stars|forks|issues}_repo_{stars|forks|issues}_min_datetime` (string): first timestamp of a `{stars|forks|issues}` event
- `max_{stars|forks|issues}_repo_{stars|forks|issues}_max_datetime` (string): last timestamp of a `{stars|forks|issues}` event

### Data Splits

The dataset has no splits and all data is loaded as train split by default. If you want to setup a custom train-test split beware that dataset contains a lot of near-duplicates which can cause leakage into the test split.

## Dataset Creation

### Curation Rationale
One of the challenges faced by researchers working on code LLMs is the lack of openness and transparency around the development of these systems. Most prior works described the high-level data collection process but did not release the training data. It is therefore difficult for other researchers to fully reproduce these models and understand what kind of pre-training data leads to high-performing code LLMs. By releasing an open large-scale code dataset we hope to make training of code LLMs more reproducible. 

### Source Data
#### Initial Data Collection and Normalization
220.92M active GitHub repository names were collected from the event archives published between January 1st, 2015 and March 31st, 2022 on [GHArchive](https://gharchive.org/). Only 137.36M of these repositories were public and accessible on GitHub – others were not accessible as they had been deleted by their owners. 51.76B files were downloaded from the public repositories on GitHub between November 2021 and June 2022. 5.28B files were unique. The uncompressed size of all stored files is 92.36TB. 

The list of programming language extensions is taken from this [list](https://gist.github.com/ppisarczyk/43962d06686722d26d176fad46879d41) (also provided in Appendix C of the paper).

Near-deduplication was implemented in the pre-processing pipeline on top of exact deduplication. To find near-duplicates, MinHash with 256 permutations of all documents was computed in linear time. Locality Sensitive Hashing was used to find the clusters of duplicates. Jaccard Similarities were computed inside these clusters to remove any false positives and with a similarity threshold of 0.85. Roughly 40% of permissively licensed files were (near-)duplicates. See section 3 of the paper for further details.

The following are not stored:
- Files that cannot contribute to training code: binary, empty, could not be decoded
- Files larger than 1MB 
- The excluded file extensions are listed in Appendix B of the paper.

##### License detection 
Permissive licenses have minimal restrictions on how the software can be copied, modified, and redistributed. The full list of licenses can be found [here](https://huggingface.co/datasets/bigcode/the-stack-dedup/blob/main/licenses.json).

GHArchive contained the license information for approximately 12% of the collected repositories. For the remaining repositories, [go-license-detector](https://github.com/src-d/go-license-detector) was run to detect the most likely SPDX license identifier. The detector did not detect a license for ~81% of the repositories, in which case the repository was excluded from the dataset. 

A file was included in the safe license dataset if at least one of the repositories containing the file had a permissive license. 

#### Who are the source language producers?

The source (code) language producers are users of GitHub that created unique repository names between January 1st, 2015, and March 31st, 2022.

### Personal and Sensitive Information
The released dataset may contain sensitive information such as emails, IP addresses, and API/ssh keys that have previously been published to public repositories on GitHub. Deduplication has helped to reduce the amount of sensitive data that may exist. In the event that the dataset contains personal information, researchers should only use public, non-personal information in support of conducting and publishing their [open-access](https://en.wikipedia.org/wiki/Open_access) research. Personal information should not be used for spamming purposes, including sending unsolicited emails or selling of personal information. Complaints, removal requests, and "do not contact" requests can be sent to contact@bigcode-project.org.

The PII pipeline for this dataset is still a work in progress (see this [issue](https://github.com/bigcode-project/admin/issues/9) for updates). Researchers that wish to contribute to the anonymization pipeline of the project can apply to join [here](https://www.bigcode-project.org/docs/about/join/). Developers with source code in the dataset can request to have it removed [here](https://www.bigcode-project.org/docs/about/ip/) (proof of code contribution is required). 

### Opting out of The Stack

We are giving developers the ability to have their code removed from the dataset upon request. The process for submitting and enacting removal requests will keep evolving throughout the project as we receive feedback and build up more data governance tools.

You can check if your code is in The Stack with the following ["Am I In The Stack?" Space](https://huggingface.co/spaces/bigcode/in-the-stack). If you'd like to have your data removed from the dataset follow the [instructions on GitHub](https://github.com/bigcode-project/opt-out-v2).

## Considerations for Using the Data

### Social Impact of Dataset

The Stack is an output of the BigCode Project. BigCode aims to be responsible by design and by default. The project is conducted in the spirit of Open Science, focused on the responsible development of LLMs for code.

With the release of The Stack, we aim to increase access, reproducibility, and transparency of code LLMs in the research community. Work to de-risk and improve on the implementation of ethical best practices of code LLMs is conducted in various BigCode working groups. The Legal, Ethics, and Governance working group has explored topics such as licensing (including copyleft and the intended use of permissively licensed code), attribution of generated code to original code, rights to restrict processing, the inclusion of Personally Identifiable Information (PII), and risks of malicious code, among other topics. This work is ongoing as of October 25th, 2022.

We expect code LLMs to enable people from diverse backgrounds to write higher quality code and develop low-code applications. Mission-critical software could become easier to maintain as professional developers are guided by code-generating systems on how to write more robust and efficient code. While the social impact is intended to be positive, the increased accessibility of code LLMs comes with certain risks such as over-reliance on the generated code and long-term effects on the software development job market.

A broader impact analysis relating to Code LLMs can be found in section 7 of this [paper](https://arxiv.org/abs/2107.03374). An in-depth risk assessments for Code LLMs can be found in section 4 of this [paper](https://arxiv.org/abs/2207.14157).

### Discussion of Biases
The code collected from GitHub does not contain demographic information or proxy information about the demographics. However, it is not without risks,
as the comments within the code may contain harmful or offensive language, which could be learned by the models. 

Widely adopted programming languages like C and Javascript are overrepresented compared to niche programming languages like Julia and Scala. Some programming languages such as SQL, Batchfile, TypeScript are less likely to be permissively licensed (4% vs the average 10%). This may result in a biased representation of those languages. Permissively licensed files also tend to be longer.

Roughly 40 natural languages are present in docstrings and comments with English being the most prevalent. In python files, it makes up ~96% of the dataset.

For further information on data analysis of the Stack, see this [repo](https://github.com/bigcode-project/bigcode-analysis).

### Other Known Limitations

One of the current limitations of The Stack is that scraped HTML for websites may not be compliant with Web Content Accessibility Guidelines ([WCAG](https://www.w3.org/WAI/standards-guidelines/wcag/)). This could have an impact on HTML-generated code that may introduce web accessibility issues.

The training dataset could contain malicious code and/or the model could be used to generate malware or ransomware. 

To the best of our knowledge, all files contained in the dataset are licensed with one of the permissive licenses (see list in [Licensing information](#licensing-information)). The accuracy of license attribution is limited by the accuracy of GHArchive and go-license-detector. Any mistakes should be reported to BigCode Project for review and follow-up as needed. 

## Additional Information

### Dataset Curators
1. Harm de Vries, ServiceNow Research, harm.devries@servicenow.com
2. Leandro von Werra, Hugging Face, leandro@huggingface.co

### Licensing Information
The Stack is a collection of source code from repositories with various licenses. Any use of all or part of the code gathered in The Stack must abide by the terms of the original licenses, including attribution clauses when relevant. We facilitate this by providing provenance information for each data point.

The list of [SPDX license identifiers](https://spdx.org/licenses/) included in the dataset can be found [here](https://huggingface.co/datasets/bigcode/the-stack/blob/main/licenses.json).

### Citation Information
```
@article{Kocetkov2022TheStack,
  title={The Stack: 3 TB of permissively licensed source code},
  author={Kocetkov, Denis and Li, Raymond and Ben Allal, Loubna and Li, Jia and Mou,Chenghao and Muñoz Ferrandis, Carlos and Jernite, Yacine and Mitchell, Margaret and Hughes, Sean and Wolf, Thomas and Bahdanau, Dzmitry and von Werra, Leandro and de Vries, Harm},
  journal={Preprint},
  year={2022}
}
```

## Terms of Use for The Stack

  The Stack dataset is a collection of source code in over 300 programming languages. We ask that you read and acknowledge the following points before using the dataset:
  1. The Stack is a collection of source code from repositories with various licenses. Any use of all or part of the code gathered in The Stack must abide by the terms of the original licenses, including attribution clauses when relevant. We facilitate this by providing provenance information for each data point.
  2. The Stack is regularly updated to enact validated data removal requests. By clicking on "Access repository", you agree to update your own version of The Stack to the most recent usable version specified by the maintainers in [the following thread](https://huggingface.co/datasets/bigcode/the-stack/discussions/7). If you have questions about dataset versions and allowed uses, please also ask them in the dataset’s [community discussions](https://huggingface.co/datasets/bigcode/the-stack/discussions/new). We will also notify users via email when the latest usable version changes.
  3. To host, share, or otherwise provide access to The Stack dataset, you must include these Terms of Use and require users to agree to it.
