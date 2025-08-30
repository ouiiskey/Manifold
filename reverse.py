import sys

from fontTools.pens.transformPen import TransformPen
from fontTools.pens.ttGlyphPen import TTGlyphPen
from fontTools.ttLib import TTFont

font = TTFont(sys.argv[1])
glyf = font["glyf"]
hmtx = font["hmtx"]

for key in glyf.keys():
    glyph = glyf[key]
    width, lsb = hmtx[key]
    cx = width / 2
    cy = (font["hhea"].ascent + font["hhea"].descent) / 2
    pen = TTGlyphPen(glyf)
    transform = TransformPen(pen, (-1, 0, 0, -1, 2 * cx, 2 * cy))
    glyph.draw(transform, glyf)
    glyf[key] = pen.glyph()

font.save("assets/fonts/reverse_m6x11.ttf")
