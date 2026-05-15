dark = 0.32549
light = 0.75686

for i in range(16):
    hue = format(dark + i * (light - dark) / 15, ".4f")
    print("vec3(" + hue + ")", end = ",\n" if i < 15 else "\n")
