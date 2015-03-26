/*
 * Creates a TASC Cell.
 *
 * Author: Ian McInerney
 * Created: July 1, 2013
 */



difference() {
        cube(size=[12.8778,31.8516,0.1778],center=false);
        
        // Make the semi-triangular shape
        translate([12.8778,0.0,-0.2])rotate([0.0,0.0,18.6])cube(size=[12.0,40.37442,0.4], center=false);
        translate([0.0,31.8516,-0.2])rotate([0.0,0.0,-40.0])cube([12.0,12.0,0.4], center=false);

        // Make the terminals on the top of the cell
        translate([0.2,3.4798,0.15])cube(size=[1.0287,2.0574,1.0], center=false);
        translate([0.2,0.5,0.15])cube(size=[0.3429,30.5308,1.0], center=false);


//        translate([0.2,0.4687,0.16])cube(size=[12.5,0.05,1.0], center=false);
//        translate([0.2,1.4724,0.16])cube(size=[12.0,0.05,1.0], center=false);
//        translate([0.2,2.4761,0.16])cube(size=[11.5,0.05,1.0], center=false);
//        translate([0.2,3.4798,0.16])cube(size=[11.0,0.05,1.0], center=false);
//        translate([0.2,4.4835,0.16])cube(size=[10.5,0.05,1.0], center=false);
//        translate([0.2,5.4872,0.16])cube(size=[10.0,0.05,1.0], center=false);

        for (i=[0:1:28]) {
                translate([0.2,i*1.0037+0.4687,0.16])cube(size=[12.0-i*0.3377823,0.05,1.0], center=false);
        }
        translate([0.2,29*1.0037+0.4687,0.16])cube(size=[1.8,0.05,1.0], center=false);
}

//1.0037
