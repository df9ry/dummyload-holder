// Resolution for 3D printing:
$fa = 1;
$fs = 0.2;

//use <ttf/Roddenberry-DgLm.ttf>
//use <ttf/RoddenberryItalic-VYz6.ttf>
//use <ttf/RoddenberryBold-AgG2.ttf>
use <ttf/RoddenberryBoldItalic-q4ol.ttf>

// Allgemeines:
delta  =   0.01;  // Standard Durchdringung

width     = 148.00;
height    =  68.00;
thick     =   0.60;

switch_d  =  15.30;
switch_x0 = 107.90 + switch_d / 2;
switch_y0 =  29.30 + switch_d / 2;

imprint   =   0.40;

module print_text(x0, y0, text, size = 10, 
                  font = "Liberation Sans:style=Bold")
{
    translate([x0, y0, thick - imprint])
        linear_extrude(imprint + delta)
            text(text, size = size,
                font = font);
}

module print_svg(x0, y0, file, scale = 1.0)
{
    translate([x0, y0, thick - imprint])
       linear_extrude(height = imprint + delta)
           scale([scale, scale])
              import(file=file, center=true);
}

difference() {
    cube([width, height, thick]);
    union() {
        // Loch für den Schalter:
        translate([switch_x0, switch_y0, -delta])
            cylinder(h = thick + 2*delta, d = switch_d);
        // Texte:
        print_text(10, 50, "Dummy Load");
        print_text(10, 32, "50 \u03A9 100W");
        print_text(10, 10, "DF9RY", 14,
                   "Roddenberry:style=Bold Italic");
        // Symbole:
        print_svg(114.9, 56, "Antenne.svg", 0.18);
        print_svg(114.9, 20, "Resistor.svg", 0.55);
    }
}