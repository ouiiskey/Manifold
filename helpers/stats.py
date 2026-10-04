import os
import cv2
import subprocess

features = {
    "Jokers": 46,
    "Consumables": 24,
    "Decks": 19,
    "Challenges": 10,
    "Blinds": 5,
    "Ranks": 2,
    "Suits": 2,
    "Seals": 1,
    "Stickers": 3,
}
top_code = 5
top_art = 5

textures = os.listdir("assets/1x")
art = {}
for name in textures:
    image = cv2.imread(f"assets/1x/{name}", cv2.IMREAD_UNCHANGED)
    h, w, c = image.shape
    art[f"assets/1x/{name}"] = h * w
sorted_art = sorted(art.items(), key=lambda item: item[1])

code = {}
def count_files(dir, pre=""):
    for path in dir:
        with open(f"{pre}{path}", "rb") as file:
            code[f"{pre}{path}"] = sum(1 for _ in file)
src = [os.path.join(dp, f) for dp, dn, fn in os.walk("src") for f in fn]
count_files(src)
lua_count = len(src)

localization = os.listdir("localization")
count_files(localization, "localization/")
lua_count += len(localization)

lovely = [os.path.join(dp, f) for dp, dn, fn in os.walk("lovely") for f in fn]
count_files(lovely)

shaders = os.listdir("assets/shaders")
count_files(shaders, "assets/shaders/")

json = ["manifest.json", "manifold.json"]
count_files(json)

sounds = os.listdir("assets/sounds")

font_count = 2

sorted_code = sorted(code.items(), key=lambda item: item[1])

out = f'''<details>
    <summary><b>{sum(art.values()):,} pixels of art</b></summary>

* **Largest atlases:**\n'''
for i in range(-1, -1 - top_art, -1):
    out += f"    * {sorted_art[i][0]} ({sorted_art[i][1]:,} pixels)\n"
out += "* **Smallest atlases:**\n"
for i in range(0, top_art):
    out += f"    * {sorted_art[i][0]} ({sorted_art[i][1]:,} pixels)\n"
out += f'''</details>
<details>
    <summary><b>{sum(code.values()):,} lines of code</b></summary>

* **Longest files:**\n'''
for i in range(-1, -1 - top_code, -1):
    out += f"    * {sorted_code[i][0]} ({sorted_code[i][1]:,} lines)\n"
out += "* **Shortest files:**\n"
for i in range(0, top_code):
    out += f"    * {sorted_code[i][0]} ({sorted_code[i][1]:,} lines)\n"
out += f'''</details>
<details>
    <summary><b>{2 * len(textures) + 1 + lua_count + len(lovely) + len(shaders) + len(json) + len(sounds) + font_count + 1} game files</b></summary>

* **PNG:** {2 * len(textures) + 1} files
* **Lua:** {lua_count} files
* **TOML:** {len(lovely)} files
* **GLSL:** {len(shaders)} files
* **JSON:** {len(json)} files
* **Ogg:** {len(sounds)} file
* **TrueType:** {font_count} files
* **Markdown:** 1 file (You're reading it now)
</details>
<details>
    <summary><b>{sum(features.values())} feature additions</b></summary>
\n'''
for k, v in features.items():
    out += f"* **{k}:** {v}\n"
out += '''</details>

**1 dev**'''
subprocess.run(["wl-copy"], input=out, text=True)
print(out)