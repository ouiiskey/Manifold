dark = 0.32549
light = 0.75686

for i in range(16):
    hue = dark + i * (light - dark) / 15
    print(f"vec3({hue:.4f})", end = ",\n" if i < 15 else "\n")
