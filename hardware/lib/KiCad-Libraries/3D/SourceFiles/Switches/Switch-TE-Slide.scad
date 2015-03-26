/*
 * Create a Tyco Electronics Right-Sngle Through-Hole Slide switch

 * Author: Ian McInerney
 * Created: June 22, 2013
 *
 */

// An individual pin
module pin() {
	translate([0.0,0.0,-1.7])cube(size=[0.6,0.4,3.4], center=true);
}

// Main switch body
difference() {
	// The main switch rectangle
	translate([0.0,0.0,2.5])cube(size=[10.2,4.3,5.0], center=true);
	
	// The cutout where the switch lever goes
	translate([0.0,2.1,3.5])cube(size=[3.8,1.0,1.3], center=true);
}

// The switch lever
translate([1.0,3.15,3.5])cube(size=[1.5,2.5+0.5,1.2], center=true);

// The pins
translate([-2.0,0.0,0.0])pin();
translate([0.0,0.0,0.0])pin();
translate([2.0,0.0,0.0])pin();