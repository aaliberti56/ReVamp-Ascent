from PIL import Image
import joblib

from detect_objects import detect_objects

# carica modello
loaded = joblib.load("model.pkl")
model = loaded[0]

# carica immagine di test
image = Image.open("test5.jpg").convert("RGB")

# detection
detections = detect_objects(image, model)

print("DETECTIONS TROVATE:")
for d in detections:
    print(
        f"- {d['category']} | conf={d['confidence']:.2f} | "
        f"bbox=({d['bbox']['x']}, {d['bbox']['y']}, "
        f"{d['bbox']['w']}x{d['bbox']['h']})"
    )
