include <lada.scad>

$fn=100;

mm = 1;
inch = 25.4 * mm;

R = 10 * mm;
H = 20 * mm;
L = 11 * inch;
W = 11 * inch;
wall_offset = 3.5*mm;

difference(){
  union(){
    difference(){
      cylinder(h=H, r=R);
      // translate([-5*mm, 5*mm-R, -1])cube([R, R, H + 2]);
    }
  }
  // slot
  translate([0, wall_offset, -1])cube([2*inch, 3*mm, H + 2]);
  translate([-3*mm - wall_offset, -2*inch, -1])cube([3*mm, 2*inch, H + 2]);

  // key top
  translate([-3*mm - wall_offset, wall_offset, -1])cube([2*inch, 3*mm, 3*mm + 1]);
  translate([-3*mm - wall_offset, -2*inch+6*mm, -1])cube([3*mm, 2*inch, 3*mm + 1]);

  // key bottom
  translate([-3*mm - wall_offset, wall_offset, H - 3 * mm])cube([2*inch, 3*mm, 3*mm + 1]);
  translate([-3*mm - wall_offset, -2*inch+6*mm, H - 3*mm])cube([3*mm, 2*inch, 3*mm + 1]);

  translate([0, 0, -1])cylinder(h=H+2, d=3.5*mm);
  translate([-0, -R, -5*mm])cube([R, R, H]);
  translate([0, 0, H-3])rotate(a=180, v=[0, 1, 0])scale([1, 1, 10])hex();
}

