/*
 * Creates a microSD Card.
 * 
 *
 * Author: Ian McInerney
 * Created: June 22, 2013
 */

use <../Libraries/fillet.scad>

// Create the raised lip on the end of the card
module raisedLip() {
	
	translate([0.0,-28.16,0.0])
	difference() {
		cylinder(h=0.3, r1=30.0, r2=29.66, center=false, $fn=100);
		
		// Make the flat back
		translate([0.0,28.16/2,0.0])cube(size=[30.0,28.16,1.0], center=true);

		// Remove any curved parts to create the 11mm back distance
		translate([15.5,0.0,0.0])cube(size=[20.0,100.0,1.0], center=true);
		translate([-15.5,0.0,0.0])cube(size=[20.0,100.0,1.0], center=true);

		// Remove the remaining parts of the cylinder that aren't required
		translate([0.0,-15.0,0.0])cube(size=[80.0,70.0,1.0], center=true);
	}	
}

// Create the overall shape of the uSD card
module overallShape() {
	// Overall box for the uSD card
	translate([0.0,0.0,0.35])cube(size=[11.0,15.0,0.7], center=true);
	translate([0,-7.5,0.7])raisedLip();
}

module microSD() {
	// Remove the specific small patches
	difference() {
		// Place the overall shape of the card
		translate([0.0,-7.5,0.0])overallShape();
	
		// The bevel on the front bottom
	//	rotate([])translate([])cube(
	
		// The notch at the front
		translate([5.5,-2.5,0.5])cube(size=[2.6,5.2,1.1], center=true);
		translate([5.5,-5.1,0.5])rotate([0.0,0.0,45.0])cube(size=[1.83,1.83,1.1], center=true);
	
		// The notch in the side
		translate([5.2,-8.5,0.4])cube(size=[0.8,1.2,1.0], center=true);
		translate([5.5,-9.1,0.5])rotate([0.0,0.0,45.0])cube(size=[0.989,0.989,1.5], center=true);
	
		// Create the fillets on the major corners
		translate([-5.5,-15,0.0])rotate([0.0,0.0,0.0])fillet(0.8,3.0);
		translate([5.5,-15,0.0])rotate([0.0,0.0,90.0])fillet(0.8,3.0);
		translate([4.2,0.0,0.0])rotate([0.0,0.0,180])fillet(0.8,3.0);
		translate([-5.5,0.0,0.0])rotate([0.0,0.0,-90.0])fillet(0.8,3.0);
	}
}

microSD();