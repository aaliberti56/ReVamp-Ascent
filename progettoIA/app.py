from flask import Flask, request, jsonify
from flask_cors import CORS
from PIL import Image
import joblib
import io

from image_features import extract_features_from_pil
from detect_objects import detect_objects
from roboflow_detect import detect_with_roboflow_and_crop

CLASS_NAMES = ["bed", "chair", "sofa", "table"]

loaded = joblib.load("model.pkl")
model = loaded[0]

app = Flask(__name__)
CORS(app)


# ================= MODALITÀ A =================
@app.route("/predict", methods=["POST"])
def predict():
    if "image" not in request.files:
        return jsonify({"error": "No image"}), 400

    image = Image.open(
        io.BytesIO(request.files["image"].read())
    ).convert("RGB").resize((512, 512))

    features = extract_features_from_pil(image)

    pred_index = model.predict(features)[0]
    probs = model.predict_proba(features)[0]

    return jsonify({
        "method": "single",
        "category": CLASS_NAMES[pred_index],
        "probabilities": {
            CLASS_NAMES[i]: float(probs[i])
            for i in range(len(CLASS_NAMES))
        }
    })


# ================= MODALITÀ B =================
@app.route("/detect", methods=["POST"])
def detect():
    image = Image.open(
        io.BytesIO(request.files["image"].read())
    ).convert("RGB")

    detections = detect_objects(image, model)

    return jsonify({
        "method": "sliding_window",
        "detections": detections
    })


# ================= MODALITÀ C (YOLO) =================
@app.route("/detect-yolo-crop", methods=["POST"])
def detect_yolo_crop():
    image_file = request.files["image"]
    detections = detect_with_roboflow_and_crop(image_file)

    return jsonify({
        "method": "yolo",
        "count": len(detections),
        "detections": detections
    })


if __name__ == "__main__":
    app.run(host="127.0.0.1", port=5000, debug=True)