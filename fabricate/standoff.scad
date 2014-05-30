/*
	Snap in PCB standoff.
	Kevin Osborn
	http://wyolum.com
	Created 5/30/2014
*/

/*
Printing Notes:
If you are printing this as a part of a case or testing jig, you can print the bottom plate hot and fast if you'd like, but for holes for M3 and smaller, you should slow down and cool the printing temperature for the tower bits. Also, if you are just printing standalone for testing fit, you need to print at least two at once in order to let the thin tower parts cool between layers.

*/

$fn=50;
module boardmount(HoleD,BoardThick,lift)
{
	topZ = lift+BoardThick;
	pegR = HoleD/2;
	// this is really a setting.
	notchW = pegR/1.5;//width of the flexy notch in terms of peg radius
	difference()
	{
		union()
		{
			cylinder(r= pegR,h = topZ); //master peg
			translate([0,0,topZ])cylinder(r1=pegR,r2= pegR+.5, h =1);// relief for overhang
			translate([0,0,topZ+1])cylinder(r1=pegR+.5,r2= pegR-.25, h =1); // insertion cone
			cylinder(r = (HoleD/2)+1, h=lift); //standoff is always 2mm> post size (Diameter)
		}
	cylinder(r= pegR-.5, h = topZ+3);
	translate([-(HoleD+2)/2,-notchW/2,lift])cube([HoleD+2,notchW,6]);//notch for insertion flex
	}//difference
}; //module


// Sample part for test fitting
//translate([-7.5,-7.5,0])cube([15,15,1]);
//translate([0,0,1])boardmount(HoleD = 2.7, BoardThick = 1.70, lift=5);