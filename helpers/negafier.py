import numpy as np

palette = [
    np.array([60.0, 67.0, 104.0]),
    np.array([240.0, 52.0, 100.0]),
    np.array([35.0, 89.0, 85.0]),
    np.array([240.0, 107.0, 63.0]),
    np.array([66.0, 83.0, 86.0]),
    np.array([228.0, 44.0, 32.0]),
    np.array([0.0, 140.0, 227.0]),
    np.array([227.0, 145.0, 0.0])
]

def hue(s, t, h):
    hs = h % 1 * 6
    if hs < 1:
        return hs * (t - s) + s
    if hs < 3:
        return t
    if hs < 4:
        return (t - s) * (4 - hs) + s
    return s

for i in range(len(palette)):
    c = palette[i] / 255
    low = min(c)
    high = max(c)
    delta = high - low
    sum = high + low

    hsl = [0, 0, sum / 2]
    if delta != 0:
        hsl[1] = delta / sum if hsl[2] < 0.5 else delta / (2 - sum)
        if high == c[0]:
            hsl[0] = (c[1] - c[2]) / delta
        elif high == c[1]:
            hsl[0] = (c[2] - c[0]) / delta + 2
        else:
            hsl[0] = (c[0] - c[1]) / delta + 4

        hsl[0] = hsl[0] / 6 % 1

    hsl[0] = 0.2 - hsl[0]
    hsl[2] = 1 - hsl[2]

    t = hsl[2] + hsl[1] * hsl[2] if hsl[2] < 0.5 else hsl[1] + hsl[2] - hsl[1] * hsl[2]
    s = 2 * hsl[2] - t
    c = np.array([hue(s, t, hsl[0] + 1/3), hue(s, t, hsl[0]), hue(s, t, hsl[0] - 1/3)])
    c += 0.8 * np.array([79, 99, 103]) / 255
    if c[2] < 0.7:
        c[2] = c[2] / 3
    c *= 255
    c.round(out = c)
    print(f"vec3({c[0]:.1f}, {c[1]:.1f}, {c[2]:.1f}) / 255.0", end = ",\n" if i < len(palette) - 1 else "\n")