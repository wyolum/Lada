include <lada.scad>

left_span = 17 * mm; // distance from center of left mount hole to edge of display
right_span = 17 * mm; // "                      right "
bottom_span = 18 * mm; // "                     bottom "
top_span = 18 * mm;    // "                      top     "
screen_thickness = 5*mm;
overhang = 5*mm;
screen_clip(left_span, screen_thickness, overhang);
translate([0, 20*mm, 0])screen_clip(right_span, screen_thickness, overhang);
translate([0, 40*mm, 0])screen_clip(top_span, screen_thickness, overhang);
translate([0, 80*mm, 0])screen_clip(top_span, screen_thickness, overhang);
translate([0, 60*mm, 0])screen_clip(bottom_span, screen_thickness, overhang);
translate([0, 100*mm, 0])screen_clip(bottom_span, screen_thickness, overhang);
