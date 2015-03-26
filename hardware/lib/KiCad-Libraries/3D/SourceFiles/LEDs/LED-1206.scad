/*
 * Creates a 1206 size LED
 *
 * Author: Ian McInerney
 * Created: June 21, 2013
 */

// The base of the LED
cube(size=[1.6,3.2,0.25], center=true);


// Create the center lens thing
difference() {
	// The lens of the LED
	translate([0,0,0.25])cube(size=[1.6,2,0.5], center=true);

	// The bump in the middle of the LED
	translate([0,0,0.70])sphere(r=0.4, center=true, $fn=10);
}
