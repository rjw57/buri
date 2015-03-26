/*
 * Creates the Analog Devices ADXL345 accelerometer.
 *
 * Author: Ian McInerney
 * Created: June 21, 2013
 */

// Create the chip
difference() {
	// The main chip body
	cube(size=[3.0,5.0,1.0], center=true);

	// The bump to indicate pin 1
	translate([-1.0,2.0,0.70])sphere(r=0.3, center=true, $fn=10);
}
