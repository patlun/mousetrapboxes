include <mousetrap_common.scad>
$fn=32;


// Generate top or bottom with a simple locking mechanism to hold the top in place, change variables to get the result you like
// This file creates a box for the Mjölner mouse trap

// What to generate - Valid values: bottom, top
generate = "bottom"; 

// measurements inside of box

// Length in millimeter
innerlength=140;
//Width  in millimeter
innerwidth=52;
// Height in millimeter
innerheigth=110;

// The number of hole rows in bottom part
number_of_hole_rows=6;
// Number of holes at lowest row
number_of_holes_bottom_row=12; 

if (generate == "bottom")
    bottom_w_pins (innerlength, innerwidth, innerheigth, number_of_hole_rows, number_of_holes_bottom_row);
else if (generate == "top")
    top_for_pins(innerlength, innerwidth, innerheigth);
else
  echo ("Need to give some input");
  
