include <mousetrap_common.scad>
$fn=32;


// Generate top or bottom with a simple locking mechanism to hold the top in place, change variables to get the result you like

// What to generate - Valid values: bottom, top
generate = "bottom"; 

// measurements inside of box

// Length in millimeter
innerlength=110;
//Width  in millimeter
innerwidth=52;
// Height in millimeter
innerheight=55;

// The number of hole rows in bottom part
number_of_hole_rows=4;
// Number of holes at lowest row
number_of_holes_bottom_row=10; 

if (generate == "bottom")
    bottom_w_pins (innerlength, innerwidth, innerheight, number_of_hole_rows, number_of_holes_bottom_row);
else if (generate == "top")
    top_for_pins(innerlength, innerwidth, innerheight);
else
  echo ("Need to give some input");
  
