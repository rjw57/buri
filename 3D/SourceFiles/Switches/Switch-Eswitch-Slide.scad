/*
 * Creates a DPDT switch manufactured by E-Switch.
 * 
 * Author: Ian McInerney
 * Created: June 25, 2013
 */

module pin() {
	translate([0.0,0.0,-1.3])cube(size=[0.5,0.3,3.6], center=true);
}

module sideSupport() {
difference() {
	union() {
		translate([0.0,0.0,0.25])cube(size=[0.4,3.0,0.5], center=true);
		translate([0.0,0.0,-1.15])cube(size=[0.4,0.6, 2.3], center=true);
		translate([0.0,-0.6,-0.5])rotate([78.69,0.0,0.0])translate([0.0,0.5,-0.25495])cube(size=[0.4,1.0,0.5099], center=true);
		translate([0.0,-0.6,-0.5])rotate([9.462,0.0,0.0])translate([0.0,0.25,-0.912])cube(size=[0.4,0.5,1.824], center=true);
		rotate([0.0,0.0,180.0])translate([0.0,-0.6,-0.5])rotate([78.69,0.0,0.0])translate([0.0,0.5,-0.25495])cube(size=[0.4,1.0,0.5099], center=true);
		rotate([0.0,0.0,180.0])translate([0.0,-0.6,-0.5])rotate([9.462,0.0,0.0])translate([0.0,0.25,-0.912])cube(size=[0.4,0.5,1.824], center=true);
	}
	translate([-0.3,0.75,0.0])rotate([0.0,90.0,0.0])cylinder(r=0.25, h=0.8, $fn=100, center=false);
	translate([-0.3,-0.75,0.0])rotate([0.0,90.0,0.0])cylinder(r=0.25, h=0.8, $fn=100, center=false);
}

}

// The main cube
difference() {
	// The main switch cube
	translate([0.0,0.0,2.1])cube(size=[10.0,6.0,3.2], center=true);

	// the cutout for the switch handle
	translate([0.0,0.0,3.55])cube(size=[5.4,3.4,0.4], center=true);
}

// The switch handle
translate([1.0,0.0,3.7-0.35+2.0])cube(size=[3.0,3.0,4.15], center=true);


// The pins
translate([-2.0,1.0,0.0])pin();
translate([0.0,1.0,0.0])pin();
translate([2.0,1.0,0.0])pin();
translate([-2.0,-1.0,0.0])pin();
translate([0.0,-1.0,0.0])pin();
translate([2.0,-1.0,0.0])pin();

// The side supports
translate([4.8,0.0,0.0])sideSupport();
translate([-4.8,0.0,0.0])sideSupport();
