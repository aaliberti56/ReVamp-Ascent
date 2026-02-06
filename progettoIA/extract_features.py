import os
import numpy as np
from skimage.io import imread
from skimage.transform import resize
from skimage.feature import hog
from sklearn.preprocessing import LabelEncoder
import joblib

DATASET_DIR = "dataset"
IMG_SIZE = (128, 128)

X = []
y = []

for label in os.listdir(DATASET_DIR):
    label_dir = os.path.join(DATASET_DIR, label)
    if not os.path.isdir(label_dir):
        continue

    for file in os.listdir(label_dir):
        img_path = os.path.join(label_dir, file)
        img = imread(img_path)
        img = resize(img, IMG_SIZE)

        features = hog(
            img,
            orientations=9,
            pixels_per_cell=(8, 8),
            cells_per_block=(2, 2),
            channel_axis=-1
        )

        X.append(features)
        y.append(label)

X = np.array(X)
y = np.array(y)

le = LabelEncoder()
y_encoded = le.fit_transform(y)

joblib.dump((X, y_encoded, le), "features.pkl")

print("Feature estratte e salvate!")
