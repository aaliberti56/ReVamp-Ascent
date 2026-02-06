import requests
import base64
import uuid
import os
from PIL import Image
import io

# ================== CONFIG ==================
ROBOFLOW_API_KEY = "b7HUkknWbXyuoA4mBBRO"
MODEL_ID = "my-first-project-1chzt/2"
API_URL = "https://detect.roboflow.com"

CONFIDENCE_THRESHOLD = 0.35
CROP_FOLDER = "static/crops"

os.makedirs(CROP_FOLDER, exist_ok=True)

# ================== FUNZIONE ==================
def detect_with_roboflow_and_crop(image_file):
    image_bytes = image_file.read()
    encoded_image = base64.b64encode(image_bytes).decode("utf-8")

    response = requests.post(
        f"{API_URL}/{MODEL_ID}?api_key={ROBOFLOW_API_KEY}&confidence={int(CONFIDENCE_THRESHOLD * 100)}",
        data=encoded_image,
        headers={"Content-Type": "application/x-www-form-urlencoded"}
    )

    if response.status_code != 200:
        raise RuntimeError("Errore Roboflow")

    data = response.json()

    image = Image.open(io.BytesIO(image_bytes)).convert("RGB")

    detections = []

    for p in data.get("predictions", []):
        x = int(p["x"] - p["width"] / 2)
        y = int(p["y"] - p["height"] / 2)
        w = int(p["width"])
        h = int(p["height"])

        crop = image.crop((x, y, x + w, y + h))

        filename = f"{uuid.uuid4().hex}.png"
        filepath = os.path.join(CROP_FOLDER, filename)
        crop.save(filepath)

        detections.append({
            "category": p["class"],
            "confidence": float(p["confidence"]),
            "image_url": f"/static/crops/{filename}"
        })

    return detections