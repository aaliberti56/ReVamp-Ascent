import numpy as np
from skimage.feature import hog
from skimage.color import rgb2gray
from skimage.transform import resize

# ⚠️ DEVONO combaciare con training
IMG_SIZE = (128, 128)
HOG_ORIENTATIONS = 9
HOG_PIXELS_PER_CELL = (8, 8)
HOG_CELLS_PER_BLOCK = (2, 2)

def extract_features_from_pil(image):
    """
    Estrae feature HOG da un'immagine PIL (RGB)
    Ritorna array shape (1, n_features)
    """

    # resize
    img = resize(np.array(image), IMG_SIZE)

    # grayscale
    gray = rgb2gray(img)

    # HOG
    features = hog(
        gray,
        orientations=HOG_ORIENTATIONS,
        pixels_per_cell=HOG_PIXELS_PER_CELL,
        cells_per_block=HOG_CELLS_PER_BLOCK,
        block_norm="L2-Hys"
    )

    return features.reshape(1, -1)
