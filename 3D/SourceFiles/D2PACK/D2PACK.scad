/*
 * Creates a D2-PACK.
 *
 * Author: Ian McInerney
 * Created: July 8, 2013
 *
 */
use <../Libraries/fillet.scad>

module Pin() {
difference() {
union() {
	translate([0.0,1.45,0.32])cube(size=[0.85,2.9,0.64],center=true);
	translate([0.0,2.9,1.78])rotate([90.0,0.0,0.0])cube(size=[0.85,3.56,0.64],center=true);
	translate([0.0,4.35,3.24])cube([0.85,2.9,0.64],center=true);
	translate([0.0,3.22,2.92])rotate([-90.0,0.0,90.0])fillet(r=0.32,h=0.85);	
	translate([0.0,2.58,0.64])rotate([90.0,0.0,-90.0])fillet(r=0.32,h=0.85);

}
translate([0.0,2.58,3.56])rotate([-90.0,0.0,90.0])fillet(r=0.32,h=0.9);	
translate([0.0,3.22,0.0])rotate([90.0,0.0,-90.0])fillet(r=0.32,h=0.9);
}
}

translate([0.0,5.5,0.0])difference() {
	translate([0.0,0.0,2.25])cube(size=[10.3,11.0,4.5], center=true);

	// The flange on the top
	translate([0.0,4.75,3.0])cube(size=[10.4,1.7,3.2], center=true);
	translate([-5.15,3.9+0.8,-0.1])rotate([0.0,0.0,12.5])cube(size=[5.0,10.0,1.6],center=false);
	translate([5.15,3.9+0.8,-0.1])rotate([0.0,0.0,77.5])cube(size=[5.0,10.0,1.6],center=false);

	// The bevelled sides
	translate([-5.75,3.9,1.4])rotate([8.0,0.0,0.0])cube(size=[11.5,1.0,10],center=false);
	translate([5.15,-5.6,1.4])rotate([0.0,-8.0,0.0])cube(size=[1.0,11.5,10],center=false);
	translate([-5.15,-5.6,1.4])rotate([0.0,8.0,0.0])translate([-1.0,0.0,0.0])cube(size=[1.0,11.5,10],center=false);
}

// The pins (and stub)
translate([-2.54,-4.8,0.0])Pin();
translate([2.54,-4.8,0.0])Pin();
translate([0.0,0.0,3.24])cube(size=[0.85,2.0,0.64],center=true);
