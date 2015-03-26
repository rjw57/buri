/*
 * Creates an HC-49 Surface mount crystal.
 *
 * Author: Ian McInerney
 * Created: October 11, 2013
 */

use <../Libraries/fillet.scad>

module base() {
	difference() {
		translate([0.0, 0.0, 0.25]) {
			cube([11.4, 4.7, 0.5],center=true);
		}
		translate([5.7,-2.35,0.1])rotate([0.0,0.0,90])fillet(0.6,1.0);
		translate([-5.7,-2.35,0.1])rotate([0.0,0.0,0.0])fillet(0.6,1.0);
		translate([-5.7,2.35,0.1])rotate([0.0,0.0,-90])fillet(0.6,1.0);
		translate([5.7,2.35,0.1])rotate([0.0,0.0,180])fillet(0.6,1.0);
	}
}

module canister() {
	translate([3.2,0.0,0.0])cylinder(r=2, h=3.3, $fn=40);
	translate([-3.2,0.0,0.0])cylinder(r=2, h=3.3, $fn=40);
	translate([0.0,0.0,1.65])cube(size=[6.4,4.0,3.3], center=true);
}

module pin() {
	difference() {
		cube([0.65, 0.6, 0.25], center=true);
		
	}
}

base();
canister();
translate([6.025, 0.0, 0.125]) {pin();}
translate([-6.025, 0.0, 0.125]) {pin();}