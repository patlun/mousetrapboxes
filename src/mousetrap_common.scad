include <BOSL2/std.scad>
$fn=32;

// Constants and common variables
holecc=10;
rowheigth=holecc;
startheigth=rowheigth;
holesdiff=2; // number of rows to subtract per row 
holediameter=4;
clearance=0.25; // Some wiggle room for top
wallthickness=1.2;
wallthickness2=wallthickness*2+clearance;
// Some variables for the locks
lockheight=wallthickness+1.5; // Giving some play room
lockplacement=16; // from top of bottom part
pindiameter=8;
hatdiameter=10.5;
// The height of the opening at the bottom 
frontopening=30;
topheigth=8;// Inner height of top box + ?

// For setting file local variables to same value as the ones in this file
//function get_wallthickness () = 1.2;

// Create the bottom box including holes
module bottom (in_length, in_width, in_heigth, in_number_of_hole_rows, in_number_of_holes_bottom_row)
{
    assert(in_length > 0, "Length need to be greater than 0");
    assert(in_width > 0, "Width need to be greater than 0");
    assert(in_heigth > frontopening, str("Height need to be greater than frontopening (", frontopening, ") mm") );
    
    length=in_length+wallthickness;  // 1 wall
    heigth=in_heigth+wallthickness-0.01;  // 1 wall
    width=in_width+wallthickness*2;  // 2 walls 
    holestart=-in_length/2;
    holerowmovement=width/2;

    difference () {
        cuboid([length, width, heigth], anchor=BOTTOM, rounding=wallthickness/2);
        move([wallthickness, 0, wallthickness])cuboid([in_length, in_width, in_heigth], anchor=BOTTOM, rounding=1.5, except=TOP);
        ymove(holerowmovement) sideholes(holestart, in_number_of_holes_bottom_row, in_number_of_hole_rows);
        ymove(-holerowmovement)sideholes(holestart, in_number_of_holes_bottom_row, in_number_of_hole_rows);
        back(in_number_of_hole_rows, width, length);
    };
};

// Bottom with ears for hinges/lock
module bottom_w_pins (in_length, in_width, in_heigth, in_number_of_hole_rows, in_number_of_holes_bottom_row)
{
    length=in_length+wallthickness;  // 1 wall
    heigth=in_heigth+wallthickness-0.01;  // 1 wall
    width=in_width+wallthickness*2; 

    topinnerheigth=8; 
    lockplacementX=length/2 - topinnerheigth;
    lockplacementY=width/2+lockheight/2;
//lockplacementZ=heigth-((in_heigth-frontopening)-topinnerheigth-wallthickness); 
    lockplacementZ=heigth-lockplacement; 
    bottom (in_length, in_width, in_heigth, in_number_of_hole_rows, in_number_of_holes_bottom_row);

    move([lockplacementX, lockplacementY, lockplacementZ]) rlock();
    move([lockplacementX, -lockplacementY, lockplacementZ]) llock();
};

module top (in_length, in_width, in_heigth){
    assert(in_length > 0, "Length need to be greater than 0");
    assert(in_width > 0, "Width need to be greater than 0");
    assert(in_heigth > frontopening, str("Height need to be greater than frontopening (", frontopening, ") mm") );
    
    innerlength=in_length+wallthickness2+clearance;
    innerwidth=in_width + wallthickness+2;
    length=innerlength+wallthickness;  // 1 wall
    heigth=topheigth+wallthickness;  // 1 wall
    width=innerwidth+wallthickness*2;   // 2 walls
    frontlength=in_heigth-frontopening; 
    frontheigth=topheigth+3;
    

    difference () {
        cuboid([length, width, heigth], anchor=BOTTOM, rounding=wallthickness/2);
        move([wallthickness, 0, wallthickness+0.1])cuboid([length, in_width, in_heigth], anchor=BOTTOM, rounding=1.5, except=TOP);
    };
    move([length/2+wallthickness/2, 0, frontlength/2])
        yrot(270) front(frontlength, width, frontheigth);
};

module top_for_pins (in_length, in_width, in_heigth){
    lockplacementX=8;
    // Z, measure from bottom, don't forget the wallthickness
    lockplacementZ=lockplacement+wallthickness;
    innerlength=in_length+wallthickness2+clearance;
    innerwidth=in_width + wallthickness+2;
    length=innerlength+wallthickness;  // 1 wall
    heigth=topheigth+wallthickness;  // 1 wall
    difference () {
        top(in_length, in_width, in_heigth);
        move([length/2-lockplacementX, 0, lockplacementZ /*heigth+lockplacementX*/]) 
            ycyl(d=8.5, l=innerwidth+1);
    };
};

module front(in_length, in_width, in_heigth) {
    difference() {
        cuboid([in_length, in_width, in_heigth], anchor=BOTTOM, rounding=wallthickness/2);
        move([wallthickness, 0, wallthickness]) 
            cuboid([in_length, in_width-(wallthickness*2)-2*clearance, in_heigth], anchor=BOTTOM, rounding=wallthickness/2);
  };
};


// -- Helper functions
// Add holes to back wall
module back (in_holerows, 
        in_width,     // Placement of holes at Y
        in_length) {  // Placement hove holes at X
    holes_per_row=round(in_width/holecc);
    startingplacement=round(in_width/holes_per_row)/2;
    cc=in_width/holes_per_row;
    for ( i = [0:1:in_holerows - 1])  
        zrot(90) move([-in_width/2, in_length/2-wallthickness/2, startheigth+(rowheigth*i)]) xrot(90) holerow(holes_per_row, startingplacement, cc);
};

// Add holes to the sides 
module sideholes(in_holestart, in_start_no_of_holes, in_holerows) {
   startingplacement=10;
    for ( i = [0:1:in_holerows - 1 ]) 
        move([in_holestart, 0, startheigth+(rowheigth*i)]) xrot(90)  holerow(in_start_no_of_holes-(holesdiff*i), startingplacement);     
};

// Create one rows of holes
module holerow(in_holes_per_row, in_startplace, in_cc) { 
    xmove(in_startplace) cylinder(h=wallthickness+3, d=holediameter, anchor=CENTER);
    cc =  is_undef(in_cc) ? holecc : in_cc;
    for ( i = [1:1:in_holes_per_row-1]) 
        xmove(in_startplace+(cc*i)) cylinder(h=wallthickness+3, d=holediameter, anchor=CENTER);
};

// Create the pins in the locking parts
// 2 modules instead of rotating and getting an head ache by that.
module rlock () {
  ycyl(d=pindiameter, l=lockheight);
  ymove(lockheight)ycyl(d=hatdiameter, l=lockheight);
};
module llock () {
  ycyl(d=pindiameter, l=lockheight);
  ymove(-lockheight)ycyl(d=hatdiameter, l=lockheight);
};