// Resolution for 3D printing:
$fa = 1;
$fs = 0.4;

// Allgemeines:
delta    = 0.1;  // Standard Durchdringung

l        = 8.0;  // Abstand zwischen den Widerständen
z        = 1.0;  // Dicke der Abstandshalter
d        = 0.5;  // Wanddicke
ld       = 0.85; // Lochdurchmesser
rohr_l   = 5.0;  // Rohrlänge
rohr_d   = 3.75; // Rohrdicke

module scheibe() {
    difference() {
        difference() {
            cylinder(d = l, h = z);
            translate([0, 0, d])
                cylinder(d = l - 2*d, h = d + delta);
        };
        translate([0, 0, -delta])
            cylinder(d = ld, h = z + 2 * delta);
    }
}

module fill() {
    difference() {
        cylinder(d = l + 4 * d, h = d);
        translate([0, 0, -delta])
            cylinder(d = l - 2 * d, h = d + 2 * delta);
    }
}

module full() {
    for (n = [0 : 40 : 320]) {
        translate([ l * sin(n), l * cos(n), 0 ])
            scheibe();
    }; // end for //

    fill();
    scheibe();
}

module cut() {
    difference() {
        translate([0, 0, d])
            cylinder(d = 20.3, h = z);
        translate([0, 0, -delta])
            cylinder(d = l, h = z + 2 * delta);
    }
}

module rohr() {
    difference() {
        cylinder(d = rohr_d, h = rohr_l);
        translate([0, 0, -delta])
            cylinder(d = 2*ld, h = rohr_l + 2 * delta);
    }
}

module print() {
    difference() {
        full();
        cut();
    }
    rohr();
}

print();