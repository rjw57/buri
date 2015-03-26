/*
 * Creates a CIC.
 *
 * Author: Ian McInerney
 * Created: December 21, 2013
 */

translate([69.1/2,0.0,0.0])rotate([0.0,0.0,90.0]){

difference() {
	// The rectangle to use to define the cell
	cube(size=[39.66,69.10,0.1778],center=false);
	
	// Remove the corners
	translate([32.33,0.0,-0.2])rotate([0.0,0.0,-42.45])cube(size=[12.0,11,0.4], center=false);
	translate([32.33,69.10,-0.2])rotate([0.0,0.0,42.45-90])cube(size=[11.0,11,0.4], center=false);


	// Make the striations on the cell
	for (i=[0:1:137]) {
		translate([0.2,i*0.5,0.16])cube(size=[39.0,0.05,1.0], center=false);
	}

}

// Make the terminals on the edge of the cell
translate([0.0,12.0,0.0])difference() {
	union() {
		// The straight pieces of the tab
		translate([-11.4,0.8,0])cube(size=[11.4,2.0,0.1], center=false);
		translate([-11.4,-2.8,0])cube(size=[11.4,2.0,0.1], center=false);
		translate([-11.4/2,-7.155+5.355/2,0.0])cylinder(h=0.1, r=5.355/2, $fn=40);	// The circles on the tab
		translate([-11.4/2,7.155-5.355/2,0.0])cylinder(h=0.1, r=5.355/2, $fn=40);	// The circles on the tab
	}
	translate([-11.4/2,7.155-5.355/2,-0.1])cylinder(h=0.3, r=3.355/2, $fn=40);	// The circles on the tab
	translate([-11.4/2,-7.155+5.355/2,-0.1])cylinder(h=0.3, r=3.355/2, $fn=40);	// The circles on the tab
}

translate([0.0,69.1/2,0.0])difference() {
	union() {
		// The straight pieces of the tab
		translate([-11.4,0.8,0])cube(size=[11.4,2.0,0.1], center=false);
		translate([-11.4,-2.8,0])cube(size=[11.4,2.0,0.1], center=false);
		translate([-11.4/2,-7.155+5.355/2,0.0])cylinder(h=0.1, r=5.355/2, $fn=40);	// The circles on the tab
		translate([-11.4/2,7.155-5.355/2,0.0])cylinder(h=0.1, r=5.355/2, $fn=40);	// The circles on the tab
	}
	translate([-11.4/2,7.155-5.355/2,-0.1])cylinder(h=0.3, r=3.355/2, $fn=40);	// The circles on the tab
	translate([-11.4/2,-7.155+5.355/2,-0.1])cylinder(h=0.3, r=3.355/2, $fn=40);	// The circles on the tab
}

translate([0.0,69.1-12.0,0.0])difference() {
	union() {
		// The straight pieces of the tab
		translate([-11.4,0.8,0])cube(size=[11.4,2.0,0.1], center=false);
		translate([-11.4,-2.8,0])cube(size=[11.4,2.0,0.1], center=false);
		translate([-11.4/2,-7.155+5.355/2,0.0])cylinder(h=0.1, r=5.355/2, $fn=40);	// The circles on the tab
		translate([-11.4/2,7.155-5.355/2,0.0])cylinder(h=0.1, r=5.355/2, $fn=40);	// The circles on the tab
	}
	translate([-11.4/2,7.155-5.355/2,-0.1])cylinder(h=0.3, r=3.355/2, $fn=40);	// The circles on the tab
	translate([-11.4/2,-7.155+5.355/2,-0.1])cylinder(h=0.3, r=3.355/2, $fn=40);	// The circles on the tab
}
}