import lada
from lada import inch, mm

PCB_THICKNESS = 0.06 * inch
STANDOFF_H = 8 * mm

### cheat!
lada.OFFSET = 0.6*inch + PCB_THICKNESS + STANDOFF_H
### end cheat!!

T = 3.3 * mm
LENGTH = 5 * inch + 2 * STANDOFF_H + 0 * T
WIDTH = 5 * inch + 2 * STANDOFF_H + 0 * T
HEIGHT = 5 * inch + 2 * STANDOFF_H + 0 * T

LENGTH = 4.8 * inch + 2 * (PCB_THICKNESS + STANDOFF_H + T)
WIDTH = LENGTH
HEIGHT = LENGTH

can = lada.new_canvas("TinyTiMCube.pdf", 20*inch, 12*inch, .5*inch)
panels = lada.Lada(LENGTH, WIDTH, HEIGHT, T, max_edge_span=100*inch)
panels.drawOn(can)
can.save()
print 'wrote', can._filename

scad = panels.toScad()
f = open("TinyTimCube_panels.scad", 'w')
print >> f, scad
f.close()
print 'write', f.name

