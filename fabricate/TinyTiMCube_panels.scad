mm = 1;
module top(){
difference(){
    color([1, 1, 1, .4])cube([143.988*mm, 143.988*mm, 1.51*mm]);
    translate([26.274 * mm, 26.274 * mm, -1])cylinder(h=3.51*mm, r=1.7*mm);
    translate([117.714 * mm, 26.274 * mm, -1])cylinder(h=3.51*mm, r=1.7*mm);
    translate([117.714 * mm, 117.714 * mm, -1])cylinder(h=3.51*mm, r=1.7*mm);
    translate([26.274 * mm, 117.714 * mm, -1])cylinder(h=3.51*mm, r=1.7*mm);
}

}
module bottom(){
    translate([0, 0, 142.478*mm])top();
}

module front(){
translate([0, 1.51*mm, 1.51*mm])
rotate(v=[1, 0, 0], a=90)
difference(){
    color([1, 1, 1, .4])cube([143.988*mm, 140.968*mm, 1.51*mm]);
    translate([26.274 * mm, 24.764 * mm, -1])cylinder(h=3.51*mm, r=1.7*mm);
    translate([117.714 * mm, 24.764 * mm, -1])cylinder(h=3.51*mm, r=1.7*mm);
    translate([117.714 * mm, 116.204 * mm, -1])cylinder(h=3.51*mm, r=1.7*mm);
    translate([26.274 * mm, 116.204 * mm, -1])cylinder(h=3.51*mm, r=1.7*mm);
}

}
module back(){
    translate([0, 142.478*mm, 0])front();
}

module right(){
    translate([1.51*mm, 1.51*mm, 1.51*mm])
    rotate(v=[0, 1, 0], a=-90)
    difference(){
    color([1, 1, 1, .4])cube([140.968*mm, 140.968*mm, 1.51*mm]);
    translate([24.764 * mm, 24.764 * mm, -1])cylinder(h=3.51*mm, r=1.7*mm);
    translate([116.204 * mm, 24.764 * mm, -1])cylinder(h=3.51*mm, r=1.7*mm);
    translate([116.204 * mm, 116.204 * mm, -1])cylinder(h=3.51*mm, r=1.7*mm);
    translate([24.764 * mm, 116.204 * mm, -1])cylinder(h=3.51*mm, r=1.7*mm);
}

}
module left(){
translate([142.478*mm, 0, 0])
right();
}
module main(){
    top();
    bottom();
    front();
    back();
    right();
    left();
}
main();

