/*
 * Creates a microSD card slot with a hinged lid manufactured by Amphenol.
 * 
 *
 * Author: Ian McInerney
 * Created: June 24, 2013
 */

// Include the microSD card outline
use <microSD_Card.scad>
use <../Libraries/fillet.scad>

module feet() {
	difference() {
		// The main part of the foot
		translate([0.2,0.0,0.05])cube(size=[0.4,1.0,0.1], center=true);

		// The cylindrical middle cuout
		translate([0.0,0.0,-0.1])cylinder(r=0.1, h=0.3, $fn=100, center=false);

		// Make the rounded corners
		translate([0.0,-0.5,0.05])fillet(0.1, 0.2);
		translate([0.0,0.5,0.05])rotate([0.0,0.0,-90])fillet(0.1, 0.2);
	}

}

module cutout() {
	translate([0.0,-2.8,0.0])cylinder(r=0.55/2, h=0.3, center=false, $fn=100);
	translate([0.0,-1.4,0.15])cube(size=[0.55,2.8,0.3], center=true);
}

module main() {
	// Create the shape
	difference() {
		// The main cube
		translate([0.0,0.0,0.9])cube(size=[13.6,13.3,1.8], center=true);
	
		// Remove the piece of the top where the metal is not
		translate([0.0,5.225,1.75])cube(size=[13.7,2.9,0.3], center=true);
	
		// Remove the SD card cutout from the object
		translate([0.0,13.3/2+0.8,0.6+0.35])microSD();

		// Remove the oval from the hinged part
		translate([-3.53,-2.82,1.5])cylinder(r=1.0, h=0.4, $fn=100, center=false);
		translate([-3.53+7.4,-2.82,1.5])cylinder(r=1.0, h=0.4, $fn=100, center=false);
		translate([0.32,-2.82,1.7])cube(size=[7.4,2.0,0.4], center=true);

		// Create the tongue between pins 1 and 2
		translate([3.47,3.8,1.6])cutout();
		translate([3.47-1.1-0.55,3.8,1.6])cutout();

		// Create the tongue between pins 7 and 8
		translate([-4.53+0.3,3.8,1.6])cutout();
		translate([-4.53+0.3+1.1+0.55,3.8,1.6])cutout();
	}
}

translate([-13.6/2-0.4,-5.35,0.0])rotate([0.0,0.0,0.0])feet();
translate([13.6/2+0.4,-5.35,0.0])rotate([0.0,0.0,180.0])feet();
translate([-13.6/2-0.4,3.05,0.0])rotate([0.0,0.0,0.0])feet();
translate([13.6/2+0.4,3.05,0.0])rotate([0.0,0.0,180.0])feet();
color("Yellow")main();
color("Blue")translate([0.0,13.3/2+0.8,0.6+0.35])microSD();

