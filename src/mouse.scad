include <mousetrap_common.scad>
$fn=32;

// Generate a plain top or bottom, change variables to get the result you like

// What to generate - Valid values: bottom, top
generate = "bottom"; 

// measurements inside of box

// Length in millimeter
innerlength=110;
//Width  in millimeter
innerwidth=52;
// Height in millimeter
innerheigth=55;

// The number of hole rows in bottom part
number_of_hole_rows=4;
// Number of holes at lowest row
number_of_holes_bottom_row=10; 

if (generate == "bottom")
    bottom (innerlength, innerwidth, innerheigth, number_of_hole_rows, number_of_holes_bottom_row);
else if (generate == "top")
    top(innerlength, innerwidth, innerheigth);
else
  echo ("Need to give some input");
  
