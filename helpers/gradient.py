dark = 83
light = 193

for i in range(16):
    hue = round(dark + i * (light - dark) / 15)
    print(f"vec3({hue:.1f} / 255.0)", end = ",\n" if i < 15 else "\n")
