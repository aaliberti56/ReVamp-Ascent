import joblib
import sys
from PIL import Image
from image_features import extract_features_from_pil

CLASS_NAMES = ["bed", "chair", "sofa", "table"]

if len(sys.argv) != 2:
    print("Uso: python predict.py path_immagine")
    sys.exit(1)

image_path = sys.argv[1]

loaded = joblib.load("model.pkl")
model = loaded[0]

img = Image.open(image_path).convert("RGB")
features = extract_features_from_pil(img)

predicted_index = model.predict(features)[0]
prediction = CLASS_NAMES[predicted_index]
probabilities = model.predict_proba(features)[0]

print(f"\n✅ Categoria predetta: {prediction}\n")
print("Probabilità:")
for name, prob in zip(CLASS_NAMES, probabilities):
    print(f"  {name}: {prob:.2f}")
