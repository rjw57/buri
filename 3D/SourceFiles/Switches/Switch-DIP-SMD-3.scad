/*
 * Create a CK Components 3-switch surface mount DIP switch package.
 *
 * Author: Ian McInerney
 * Created: June 22, 2013
 */

// An individual pin
module pin() {
	translate([0.0,0.79/2+0.115,0.05])cube(size=[0.61,0.79,0.1], center=true);
	translate([0.0,0.115/2,1.1125])cube(size=[0.61,0.115,2.225], center=true);
}



// Main module body
difference() {
	// The main body
	translate([0.0,0.0,2.7])cube(size=[9.6,7.49,3.5], center=true);

	// The switch cutouts
	translate([-2.54,0.0,4.3])cube(size=[1.5,3,1.0], center=true);
	translate([0.0,0.0,4.3])cube(size=[1.5,3,1.0], center=true);
	translate([2.54,0.0,4.3])cube(size=[1.5,3,1.0], center=true);
}

// Create the switches in the cutouts
translate([-2.54,1.3/2,4.0])cube(size=[1.4,1,1], center=true);
translate([0.0,1.3/2,4.0])cube(size=[1.4,1,1], center=true);
translate([2.54,1.3/2,4.0])cube(size=[1.4,1,1], center=true);

// Create the individual pins
translate([-2.54,7.49/2,0.0])pin();
translate([0.0,7.49/2,0.0])pin();
translate([2.54,7.49/2,0.0])pin();
rotate([0.0,0.0,180])translate([-2.54,7.49/2,0.0])pin();
rotate([0.0,0.0,180])translate([0.0,7.49/2,0.0])pin();
rotate([0.0,0.0,180])translate([2.54,7.49/2,0.0])pin();

