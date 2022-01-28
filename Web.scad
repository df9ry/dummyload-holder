// Resolution for 3D printing:
$fa      =  1;
$fs      =  0.4;

// Allgemeines:
delta    =  0.1;  // Standard Durchdringung

l        = 25.0;  // Abstand zwischen den Clustern
w        =  8.0;  // Breite der Balken
h        =  2.5;  // Höhe der Balken
d        =  4.0;  // Durchmesser der Löcher

d_row    = sin(60) * l;

module balken() {
    difference() {
        union() {
            cylinder(d = w, h = h);
            translate([0, -w/2, 0])
                cube([l, w, h]);
            translate([l, 0, 0])
                cylinder(d = w, h = h);
        };
        union() {
            translate([0, 0, -delta])
                cylinder(d = d, h = h + 2*delta);
            translate([l, 0, -delta])
                cylinder(d = d, h = h + 2*delta);
        }
    }
}

module balken_rand() {
    l1 = 2 * d_row;
    difference() {
        union() {
            cylinder(d = w, h = h);
            translate([-w/2, 0, 0])
                cube([w, l1, h]);
            translate([0, l1, 0])
                cylinder(d = w, h = h);
        };
        union() {
            translate([0, 0, -delta])
                cylinder(d = d, h = h + 2*delta);
            translate([0, l1, -delta])
                cylinder(d = d, h = h + 2*delta);
        }
    }
}

module balken_links() {
    rotate([0, 0, 120])
        balken();
}

module balken_rechts() {
    rotate([0, 0, 60])
        balken();
}

module row4() {
    for (n = [1 : 1 : 3]) {
        dx = l * n;
        translate([dx, 0, 0]) 
            balken();
    }
}

module row5() {
    for (n = [0 : 1 : 3]) {
        dx = (l / 2) + l * n;
        translate([dx, 0, 0]) 
            balken();
    }
}

for (n = [0, 4]) {
    translate([0, n * d_row, 0])
        row4();
}

for (n = [1, 3]) {
    translate([0, n * d_row, 0])
        row5();
}

for (n = [1, 2, 3, 4]) {
    dx = l * n;
    translate([dx, 0, 0])
        balken_links();
}

for (n = [1, 2, 3, 4]) {
    dx = l * n;
    translate([dx, 0, 0])
        balken_rechts();
}

for (n = [0, 1, 2, 3]) {
    dx = (l / 2) + l * n;
    dy = d_row * 3;
    translate([dx, dy, 0])
        balken_rechts();
}

for (n = [1, 2, 3, 4]) {
    dx = (l / 2) + l * n;
    dy = d_row * 3;
    translate([dx, dy, 0])
        balken_links();
}

for (n = [0, 3]) {
    dx = (l / 2) + l * n;
    dy = d_row;
    translate([dx, dy, 0])
        balken_rechts();
}

for (n = [1, 4]) {
    dx = (l / 2) + l * n;
    dy = d_row;
    translate([dx, dy, 0])
        balken_links();
}

for (n = [1, 4]) {
    dx = l * n;
    dy = d_row * 2;
    translate([dx, dy, 0]) {
        balken_links();
        balken_rechts();
    }
}

translate([l / 2, d_row, 0])
    balken_rand();

translate([l / 2 + 4 * l, d_row, 0])
    balken_rand();
