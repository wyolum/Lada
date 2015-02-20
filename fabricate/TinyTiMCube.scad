include <lada.scad>

difference(){
  rotate(a=acos(([1, 1, 1] * [0, 0, 1]) / sqrt(3)), v=cross([1, 1, 1] / sqrt(3), [0, 0, 1]))
    intersection(){
    inside_corner(1*inch, 3.3*mm, 0.6*inch, standoff_h=200);
    cube(.75*inch);
  }
  translate([-5*inch, -5*inch, 0])cube([10*inch, 10*inch, .5*inch]);
}



