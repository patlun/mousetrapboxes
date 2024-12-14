include <BOSL2/std.scad>
include <mousetrap_common.scad>
$fn=32;

// What to generate - bottom, top
generate = "top"; 

// measurements inside of box
innerlength=110;
innerheigth=55;
innerwidth=52;

number_of_hole_rows=4;
// Number of holes at lowest row
number_of_holes_bottom_row=10; 

if (generate == "bottom")
    bottom_w_pins (innerlength, innerwidth, innerheigth, number_of_hole_rows, number_of_holes_bottom_row);
else if (generate == "top")
    top_for_pins(innerlength, innerwidth, innerheigth);
else
  echo ("Need to give some input");
  
