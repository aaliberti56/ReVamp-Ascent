def iou(boxA, boxB):
    xA = max(boxA["x"], boxB["x"])
    yA = max(boxA["y"], boxB["y"])
    xB = min(boxA["x"] + boxA["w"], boxB["x"] + boxB["w"])
    yB = min(boxA["y"] + boxA["h"], boxB["y"] + boxB["h"])

    interW = max(0, xB - xA)
    interH = max(0, yB - yA)
    interArea = interW * interH

    areaA = boxA["w"] * boxA["h"]
    areaB = boxB["w"] * boxB["h"]

    union = areaA + areaB - interArea
    if union == 0:
        return 0

    return interArea / union


def non_max_suppression(detections, threshold=0.5):
    if not detections:
        return []

    # ordina per confidenza decrescente
    detections = sorted(
        detections,
        key=lambda x: x["confidence"],
        reverse=True
    )

    final_detections = []

    while detections:
        best = detections.pop(0)
        final_detections.append(best)

        detections = [
            d for d in detections
            if d["category"] != best["category"]
            or iou(d["bbox"], best["bbox"]) < threshold
        ]

    return final_detections
