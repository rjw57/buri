/*
 * Creates the Invensense MPU9150 IMU.
 *
 * Author: Ian McInerney
 * Created: June 22, 2013
 */

// Create the chip
translate([0.0,0.0,0.5])difference() {
	// The main chip body
	cube(size=[4.0,4.0,1.0], center=true);

	// The bump to indicate pin 1
	translate([-1.5,1.5,0.70])sphere(r=0.3, center=true, $fn=10);
}
