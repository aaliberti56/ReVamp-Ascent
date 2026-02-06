import numpy as np
from features import extract_features_from_pil
from nms import non_max_suppression

CLASS_NAMES = ["bed", "chair", "sofa", "table"]

WINDOW_SIZES = [(128, 128)]
STEP_SIZE = 128
THRESHOLD = 0.4


def sliding_window(image, step, window_size):
    for y in range(0, image.height - window_size[1], step):
        for x in range(0, image.width - window_size[0], step):
            yield (x, y, image.crop(
                (x, y, x + window_size[0], y + window_size[1])
            ))


def detect_objects(image, model):
    detections = []

    count = 0


    for window_size in WINDOW_SIZES:
        for (x, y, window) in sliding_window(image, STEP_SIZE, window_size):
            count += 1
        if count % 25 == 0:
            print(f"Processate {count} finestre...")
            features = extract_features_from_pil(window)
            probs = model.predict_proba(features)[0]

            class_id = np.argmax(probs)
            confidence = probs[class_id]

            if confidence >= THRESHOLD:
                detections.append({
                    "category": CLASS_NAMES[class_id],
                    "confidence": float(confidence),
                    "bbox": {
                        "x": x,
                        "y": y,
                        "w": window_size[0],
                        "h": window_size[1]
                    }
                })

    # 🔹 QUI è il punto giusto
    detections = non_max_suppression(detections, threshold=0.4)

    return detections

