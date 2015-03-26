/*
 * Creates the Antenova M2M M10382 GPS
 *
 * Author: Ian McInerney
 * Created: October 11, 2013
 */


module mainChip() {
	// Create the main chip outline
	translate([0.0,0.0,1.9]) {
		// The main chip body
		cube(size=[9.9,24.2,3.8], center=true);
	}
}

module mainCutout() {
	difference() {
		cube(size=[5.76,18.29,0.5], center=true);
		translate([-1.65,9.6,0]) rotate([0.0,0.0,30.0]) {
			cube(size=[5.0,2.45,1.0], center=true);
		}
	}
}

module antennaCutout() {
	mainCutout();
	translate([2.66,6.05,0]) {
		cube(size=[5.33,12.2,0.5], center=true);
	}
}

module chipCutout() {
	difference() {
		mainCutout();
		cube(size=[5.76,2.0,5.0], center=true);
		cylinder(h=5.0, r=2, center=true, $fn=40);
	}
}

difference() {
	mainChip();
	translate([0.0,0.0,3.8]) {antennaCutout();}
	translate([0.0,0.0,3.4]) {chipCutout();}
	translate([0.0,0.0,3.2]) {chipCutout();}
}