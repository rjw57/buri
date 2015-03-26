/*
 * Creates the SkyTraq Venus638 GPS Receiver.
 *
 * Author: Ian McInerney
 * Created: June 22, 2013
 */

// Create the chip
translate([0.0,0.0,0.65])difference() {
	// The main chip body
	cube(size=[10.0,10.0,1.3], center=true);

	// The bump to indicate pin 1
	translate([-4.0,4.0,1.0])sphere(r=0.5, center=true, $fn=10);
}
