>📋 
This repository is the my unofficial implementation of [Evaluating the quality of word representation models for unstructured clinical Text based ICU mortality prediction](https://dl.acm.org/doi/10.1145/3288599.3297118?msclkid=85fa62fdcecd11ecad78ba9c1a6dde43). 

>📋  Optional: include a graphic explaining your approach/main result, bibtex entry, link to demos, blog posts and tutorials

## Requirements

>📋  Setup the environment

1. Download env/pytorch_env.yml
2. conda env create -f pytorch_env.yml
3. conda activate pytorch_env
4. jupyter notebook

## Data collection and Preprocessing and Training

1. Gain access to MIMIC-III dataset and connect to Amazon Athena
Ref: https://aws.amazon.com/blogs/big-data/perform-biomedical-informatics-without-a-database-using-mimic-iii-data-and-amazon-athena/

2. Once connected run the queries as mentioned in attached athena_sql/athena_sql. Run each query one after the other.

3. Save the data from last query execution in the "data" folder which will be used in training the model

#Calculate OASIS Score
1. Use the model from https://github.com/caisr-hh/Dayly-SAPS-III-and-OASIS-scores-for-MIMIC-III
2. To make the sql work with Athena had to make lot of changes. Attaching the OASIS.sql which can be run against Athena: athena_sql/oasis.sql

#Training the word2vec and random forest:
Run the attached jupyter notebook: Word2VecRandomclassifier.ipynb

This jupyter notebook uses code from: https://medium.com/@dilip.voleti/classification-using-word2vec-b1d79d375381


## Results

Our model achieves the following performance on :
Precision: 0.904 / Recall: 0.252 / Accuracy: 0.928


