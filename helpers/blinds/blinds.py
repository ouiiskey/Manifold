import cv2
import numpy as np

shine = cv2.imread("shine.png", cv2.IMREAD_UNCHANGED)
blinds = cv2.imread("blinds.png", cv2.IMREAD_UNCHANGED)
s = np.tile(shine, (blinds.shape[0] // 34, 1, 1)).astype(np.int32) # Aseprite rounds to 0
b = np.tile(blinds, (1, 21, 1)).astype(np.int32)
alpha = s[..., 3, np.newaxis] / 255
transform = ((s[..., :3] - b[..., :3]) * alpha).astype(np.int32)
image = b + np.dstack((transform, b[..., 3]))

cv2.imwrite("../assets/1x/blinds.png", image)