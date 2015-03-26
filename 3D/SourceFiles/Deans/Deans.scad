/*
 * Creates a male Deans plug connector
 *
 * Author: Ian McInerney
 * Created: June 27, 2013
 */

use <../Libraries/fillet.scad>

module pin() {
	translate([0.0,0.0,5.1]) {
		// The copper contact
		difference() {
			cube(size=[1.3,4.1,19.4], center=true);
			translate([0.0,-2.05,9.7])rotate([0.0,90.0,0.0])fillet(r=0.2, h=1.5);
			translate([0.0,2.05,9.7])rotate([180.0,90.0,0.0])fillet(r=0.2, h=1.5);
			translate([0.0,-2.05,-9.7])rotate([0.0,-90.0,0.0])fillet(r=0.2, h=1.5);
			translate([0.0,2.05,-9.7])rotate([180.0,-90.0,0.0])fillet(r=0.2, h=1.5);

			translate([0.65,0,9.7])rotate([0.0,90.0,90.0])fillet(r=0.2, h=4.1);
			translate([-0.65,0.0,9.7])rotate([180.0,90.0,90.0])fillet(r=0.2, h=4.1);
			translate([0.65,0,-9.7])rotate([0.0,-90.0,90.0])fillet(r=0.2, h=4.1);
			translate([-0.65,0.0,-9.7])rotate([180.0,-90.0,90.0])fillet(r=0.2, h=4.1);
		}
		
		// The spring piece
		translate([-8.95,0.0,5.3])rotate([90.0,0.0,0.0]) {
			difference() {
				cylinder(r=10.4, h=3.1, $fn=100, center=true);
				cylinder(r=10.2, h=3.2, $fn=100, center=true);
				translate([-1.0,0.0,0.0])cube(size=[21,21,3.3], center=true);
			}
		}
	}
}

// The two main body segments
translate([0.0,4.45,3.25])cube(size=[7.5,6.5,6.5], center=true);
translate([0.0,-2.3,3.25])cube(size=[6.3,7.0,6.5], center=true);

// The negative pin
translate([0.45,-2.4,0.0])pin();

// The positive pin
translate([0.0,4.15,0.0])rotate([0.0,0.0,-90.0])pin();
