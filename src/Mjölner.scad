include <mousetrap_common.scad>
$fn=32;

// Generate a plain top or bottom, change variables to get the result you like
// This file creates a box for the Mjölner mouse trap

// What to generate - Valid values: bottom, top
generate = "bottom"; 

// measurements inside of box

// Length in millimeter
innerlength=150;
//Width  in millimeter
innerwidth=52;
// Height in millimeter
innerheight=110;

// The number of hole rows in bottom part
number_of_hole_rows=6;
// Number of holes at lowest row
number_of_holes_bottom_row=14; 

if (generate == "bottom")
    bottom (innerlength, innerwidth, innerheight, number_of_hole_rows, number_of_holes_bottom_row);
else if (generate == "top")
    top(innerlength, innerwidth, innerheight);
else
  echo ("Need to give some input");
  
