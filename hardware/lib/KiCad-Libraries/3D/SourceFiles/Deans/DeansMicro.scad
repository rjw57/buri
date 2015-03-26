/*
 * Create a Micro Deans Connector.
 *
 * Author: Ian McInerney
 * Created: June 30, 2013
 */

use <../Libraries/fillet.scad>

module baseMolding() {
	difference() {
		translate([0.0,0.35,0.7])cube(size=[5.5,0.7,1.4],center=true);
		translate([0.0,0.7,1.4])rotate([45.0,0.0,0.0])cube(size=[5.8,0.909,1.0],center=true);
	}
}

module Pin() {
	difference() {
		translate([0,0,2.45])cube(size=[0.8,1.0,4.9],center=true);
		translate([0.0,-0.5,4.9])rotate([0.0,90.0,0.0])fillet(r=0.5, h=1.0);
		translate([0.0,0.5,4.9])rotate([0.0,90.0,180.0])fillet(r=0.5, h=1.0);
	}
}





rotate([0.0,0.0,180.0])translate([0.0,-5.15,0.0]) {
	difference() {
		translate([0.0,2.8,3.55])cube(size=[5.5,4.2,7.1], center=true);
		translate([0.95,2.8,4.7])cube(size=[0.8,1.0,4.9],center=true);
		translate([0.95,2.8+0.5,7.1])rotate([0.0,90.0,0.0])fillet(r=0.5, h=0.8);
		translate([0.95,2.8-0.5,7.1])rotate([0.0,90.0,180.0])fillet(r=0.5, h=0.8);
	}
	translate([0.0,0.7,0.0])rotate([0.0,0.0,180.0])baseMolding();
	translate([0.0,4.9,0.0])baseMolding();
	translate([-0.95,2.8,7.1])Pin();
	translate([0.95,2.3,0.0])rotate([0.0,180.0,0.0])Pin();
	translate([-0.95,2.3,0.0])rotate([0.0,180.0,0.0])Pin();
}