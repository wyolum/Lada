include <lada.scad>
module angled_edge(angle=150){
  difference(){
    union(){
      translate([-OFFSET, -EDGE_WIDTH/2, 0])inside_edge(LENGTH, THICKNESS, OFFSET);
      rotate(a=angle, v=[0,0,1])translate([-OFFSET, -EDGE_WIDTH/2, 0])inside_edge(LENGTH, THICKNESS, OFFSET);
    }
    translate([0, 0, THICKNESS - HEX_THICKNESS])hex();
  }
}
module henge(){
  difference(){
    translate([-OFFSET, -EDGE_WIDTH/2, 0])inside_edge(LENGTH, THICKNESS, OFFSET);
    translate([-.5*inch, -.5*inch, -1])cube([1*inch, 1*inch, .3*THICKNESS + 1]);
  }
  rotate(a=135, v=[0, 0, 1])difference(){
    translate([-OFFSET, -EDGE_WIDTH/2, 0])inside_edge(LENGTH, THICKNESS, OFFSET);
    translate([THICKNESS-.4*inch - .3 * THICKNESS, -.5*inch, .3*THICKNESS])cube([1*inch, 1*inch, 1*inch]);
  }
}

translate([2*inch, 0, 0])angled_edge();

difference(){
  rotate(a=90, v=[1, 0, 0])translate([0, 0, -.25*inch])
    linear_extrude(height=.5*inch)import("Lada_120_outside_corner.dxf");
  translate([-8.5, 0, -1])cylinder(d=3.5, h=100);
  translate([-8.5, 0, HEX_THICKNESS-1])cylinder(d=6, h=100);
  rotate(a=120, v=[0, 1, 0])translate([-8.5, 0, -99])cylinder(d=3.5, h=100);
  rotate(a=120, v=[0, 1, 0])translate([-8.5, 0, -101])cylinder(d=6., h=100);
}
