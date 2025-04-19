import os

import cv2

filenames = os.listdir("assets/1x")

for name in filenames:
    image = cv2.imread("assets/1x/" + name, cv2.IMREAD_UNCHANGED)
    image = cv2.resize(image, None, fx=2, fy=2, interpolation=cv2.INTER_NEAREST)
    cv2.imwrite("assets/2x/" + name, image)
