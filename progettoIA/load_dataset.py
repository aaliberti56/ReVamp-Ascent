from datasets import load_dataset

dataset = load_dataset("filnow/furniture-synthetic-dataset")

print(dataset)
print(dataset["train"][0])
print(set(dataset["train"]["type"]))
