from PIL import Image

def crop_object(image: Image.Image, det: dict):
    x, y, w, h = det["x"], det["y"], det["w"], det["h"]

    left = max(0, int(x - w / 2))
    top = max(0, int(y - h / 2))
    right = min(image.width, int(x + w / 2))
    bottom = min(image.height, int(y + h / 2))

    return image.crop((left, top, right, bottom))