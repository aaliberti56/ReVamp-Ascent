from datasets import load_dataset
import os

dataset = load_dataset("filnow/furniture-synthetic-dataset")

BASE_DIR = "dataset"
os.makedirs(BASE_DIR, exist_ok=True)

for split in ["train"]:
    for item in dataset[split]:
        label = item["type"]
        img = item["image"]

        label_dir = os.path.join(BASE_DIR, label)
        os.makedirs(label_dir, exist_ok=True)

        img_id = len(os.listdir(label_dir))
        img.save(os.path.join(label_dir, f"{img_id}.png"))

print("Immagini salvate correttamente!")
