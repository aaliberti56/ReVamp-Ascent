import requests
import base64
import json

API_KEY = "b7HUkknWbXyuoA4mBBRO"   # <-- metti la tua
MODEL_ID = "my-first-project-1chzt/2"
IMAGE_PATH = "fotoMultipla.png"

# leggi immagine
with open(IMAGE_PATH, "rb") as f:
    img_bytes = f.read()

# encode base64
img_base64 = base64.b64encode(img_bytes).decode("utf-8")

# chiamata HTTP a Roboflow
url = f"https://detect.roboflow.com/{MODEL_ID}"
params = {
    "api_key": API_KEY,
    "confidence": 0.4,
    "overlap": 0.3
}

response = requests.post(
    url,
    params=params,
    data=img_base64,
    headers={"Content-Type": "application/x-www-form-urlencoded"}
)

# stampa risultato
result = response.json()
print(json.dumps(result, indent=2))

