/*
 * Create a fillet for a corner.
 * 
 * r = radius of the fillet
 * h = height of the fillet
 *
 * Borrowed from: http://forum.openscad.org/rounded-corners-td3843.html
 */
module fillet(r, h) {
    translate([r / 2, r / 2, 0])

        difference() {
            cube([r + 0.01, r + 0.01, h], center = true);

            translate([r/2, r/2, 0])
                cylinder(r = r, h = h + 1, center = true, $fn=100);

        }
}