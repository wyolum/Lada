 # -*- coding: latin-1 -*-
import string
from string import *
import os.path
from random import choice
import string
from numpy import *
import PIL.Image
from reportlab.pdfgen import canvas
from reportlab.graphics import renderPDF
from reportlab.graphics.shapes import Drawing, Group, String, Circle, Rect
from reportlab.lib.units import inch, mm, cm
from reportlab.lib.colors import pink, black, red, blue, green, white
from reportlab.platypus import Paragraph, SimpleDocTemplate, Table, TableStyle
import reportlab.rl_config
import codecs
reportlab.rl_config.warnOnMissingFontGlyphs = 0
from reportlab.pdfbase import pdfmetrics
from reportlab.pdfbase.ttfonts import TTFont
import glob
import os.path
import sys
try:
    sys.path.append('/home/justin/Dropbox/WyoLumCode/CNC/')
    from CNC.cnc import *
    from CNC.baffles import *
except:
    pass

from numpy import arange
from copy import deepcopy

def new_canvas(name, width, height, margin):
    can = canvas.Canvas(name,
                        pagesize=(width + 2 * margin, height + 2 * margin))
    return can

OFFSET = .4 * inch
M3_RAD = 1.7 * mm

class Sida:
    def __init__(self, x, y, holes):
        self.x = x
        self.y = y
        self.holes = holes ### [(x, y, r), ...]
        
    def drawOn(self, lower_left, can):
        can.translate(lower_left[0], lower_left[1])
        can.rect(0, 0, self.x, self.y)
        for hole in self.holes:
            can.circle(*hole)
            
        can.translate(-lower_left[0], -lower_left[1])
        

class Lada:
    def __init__(self, length, width, height, material_thickness, max_edge_span=10*inch, margin=0):
        total_h = 3 * margin + height + width
        total_w = 3 * margin + length  + width
        
        self.length = length
        self.height = height
        self.width = width
        self.margin = margin
        self.material_thickness = material_thickness
        self.max_edge_span = max_edge_span
        
        n_edge_l = int((self.length - 2 * self.material_thickness  - 2 * OFFSET) / max_edge_span)
        n_edge_w = int((self.width - 2 * self.material_thickness  - 2 * OFFSET) / max_edge_span)
        n_edge_h = int((self.height - 2 * self.material_thickness  - 2 * OFFSET) / max_edge_span)

        front_holes = [
            (self.material_thickness + OFFSET, OFFSET, M3_RAD),
            (self.length - self.material_thickness - OFFSET, OFFSET, M3_RAD),
            (self.length - self.material_thickness - OFFSET, self.height - OFFSET - 2 * self.material_thickness, M3_RAD),
            (self.material_thickness + OFFSET, self.height - OFFSET - 2 * self.material_thickness, M3_RAD)
            ]
        top_holes = [
            (self.material_thickness + OFFSET, self.material_thickness + OFFSET, M3_RAD),
            (self.length - (self.material_thickness + OFFSET), self.material_thickness + OFFSET, M3_RAD),
            (self.length - (self.material_thickness + OFFSET), self.width - (self.material_thickness + OFFSET), M3_RAD),
            (self.material_thickness + OFFSET, self.width - (self.material_thickness + OFFSET), M3_RAD)
            ]
        side_holes = [
            (OFFSET, OFFSET, M3_RAD),
            (self.height - OFFSET - 2 * self.material_thickness, OFFSET, M3_RAD),
            (self.height - OFFSET - 2 * self.material_thickness, self.width - 2 * self.material_thickness - OFFSET, M3_RAD),
            (OFFSET, self.width - 2 * self.material_thickness - OFFSET, M3_RAD)
            ]

        
        xstart = self.material_thickness + OFFSET
        dx = (self.length - 2 * xstart) / (n_edge_l + 1)
        for i in range(n_edge_l):
            front_holes.append((xstart + (i + 1) * dx, OFFSET, M3_RAD))
            front_holes.append((xstart + (i + 1) * dx, self.height - OFFSET - 2 * self.material_thickness, M3_RAD))

            top_holes.append((xstart + (i + 1) * dx, self.material_thickness + OFFSET, M3_RAD))
            top_holes.append((xstart + (i + 1) * dx, self.width - self.material_thickness - OFFSET, M3_RAD))

            
        for i in range(n_edge_h):
            ystart = OFFSET
            dy = (self.height - 2 * (ystart + self.material_thickness)) / (n_edge_h + 1)
            front_holes.append((self.material_thickness + OFFSET, ystart + (i + 1) * dy, M3_RAD))
            front_holes.append((self.length - self.material_thickness - OFFSET, ystart + (i + 1) * dy, M3_RAD))
            
            side_holes.append((ystart + (i + 1) * dy, OFFSET, M3_RAD))
            side_holes.append((ystart + (i + 1) * dy, self.width - OFFSET - 2 * self.material_thickness, M3_RAD))
        
        for i in range(n_edge_w):
            ystart = OFFSET + self.material_thickness
            dy = (self.width - 2 * OFFSET - 2 * self.material_thickness) / (n_edge_w + 1)
            top_holes.append((self.material_thickness + OFFSET, ystart + (i + 1) * dy, M3_RAD))
            top_holes.append((self.length - 2 * OFFSET - self.material_thickness + OFFSET, ystart + (i + 1) * dy, M3_RAD))

            ystart = OFFSET
            side_holes.append((OFFSET, ystart + (i + 1) * dy, M3_RAD))
            side_holes.append((self.height - OFFSET - 2 * self.material_thickness, ystart + (i + 1) * dy, M3_RAD))
            

        self.top = Sida(self.length, self.width, top_holes)
        self.front = Sida(self.length, self.height - 2 * self.material_thickness, front_holes)
        self.side = Sida(self.height - 2 * self.material_thickness, self.width - 2 * self.material_thickness, side_holes)

    def drawOn(self, can):
        lower_left = []
        self.front.drawOn((self.margin, self.margin), can)
        self.top.drawOn((self.margin, self.height - self.material_thickness), can)
        if False: ## one page
            self.side.drawOn((2 * self.margin + self.length, self.margin + self.height + self.material_thickness), can)
            can.showPage()
        else:
            can.showPage()
            self.side.drawOn((self.margin, self.margin), can)
            can.showPage()


def test():
    can = new_canvas("lada_test.pdf", 20*inch, 12*inch, .5*inch)
    lada = Lada(20 * inch, 4 * inch, 8 * inch, 3 * mm, max_edge_span=10*inch)
    lada.drawOn(can)
    can.save()
    print 'wrote', can._filename
