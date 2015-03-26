/*
 * Creates the SON-10 package
 *
 * Author: Ian McInerney
 * Created: October 11, 2013
 */

// Create the chip
translate([0.0,0.0,0.4])difference() {
	// The main chip body
	cube(size=[3.15,3.15,0.8], center=true);

	// The bump to indicate pin 1
	translate([-1.2,1.2,0.60])sphere(r=0.3, center=true, $fn=10);
}
