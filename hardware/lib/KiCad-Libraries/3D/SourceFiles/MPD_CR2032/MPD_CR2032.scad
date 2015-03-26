/*
 * Creates the Memory Protecton Devices CR2032 Battery holder.
 *
 * Author: Ian McInerney
 * Created: June 22, 2013
 */

// The pin holder on either end
module pinHolder() {
	translate([1.905,0,2.69])cube(size=[3.81,6.35,5.38], center=true);
	translate([4.8625,0.0,0.15])cube(size=[2.105,2.75,0.3], center=true);
}

// Create the hollow area inside for the battery
module internalCutout() {
	// The cutout for the positive terminal area
	difference() {
		// The main cylinder
		translate([0.0,0.0,0.2])cylinder(h=6.0,r=12.0, center=false, $fn=100);
		// Cut off the cylinder at the Y-Axis
		translate([-6.0,0.0,0.0])cube(size=[12.0,100.0,100.0], center=true);
		// Cut off the cylinder at the maximum Y extents
		translate([0.0,15.4025,0])cube(size=[34.0,10.695,12.64], center=true);

		translate([0.0,-15.4025,0])cube(size=[34.0,10.695,12.64], center=true);	
	}

	// The cutout for the negative terminal area
	difference() {
		// The main cylinder
		translate([0.0,0.0,0.2])cylinder(h=6.0,r=10.03, center=false, $fn=100);
		// Cut off the cylinder at the Y-Axis
		translate([6.1,0.0,0.0])cube(size=[12.0,100.0,100.0], center=true);
	}
}

// The outside cylinders
module baseDesign() {
	difference() {
		cylinder(h=5.38,r=12.64, center=false, $fn=100);
		translate([-6.32,0.0,0.0])cube(size=[12.64,100.0,100.0], center=true);
	}
	difference() {
		cylinder(h=5.38,r=10.67, center=false, $fn=100);
		translate([5.335,0.0,0.0])cube(size=[10.67,22.0,10.0], center=true);
	}

	// The negative terminal
	rotate(a=[0,0,180])translate([9.6175,0,0])pinHolder();

	// The positive terminal
	translate([9.6175,0,0])pinHolder();
}



// Create the holder
difference() {
	baseDesign();
	internalCutout();

	// The cube to represent the maximum positive Y extent
	translate([0.0,16.0425,0])cube(size=[34.0,10.695,12.64], center=true);

	// The cube to represent the maximum negative Y extent
	translate([0.0,-16.0425,0])cube(size=[34.0,10.695,12.64], center=true);	
}
