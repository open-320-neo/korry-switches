/*
This Korry button Replica consists of 3 printed Parts:
 - Button
 - Housing
 - PCB
 - Mounting

/* [General] */
plate_thickness = 3;
radius = 0.75;
wall_thickness = 0.4;
tolerance = 0.2;
act_length = 4;
rail_width = 3;
rail_height = 5;
space = 3.5;

spring_height = 10;
spring_diameter = 2.6;

pos = 6;

$fs = 0.01;

/* [Button] */
button_size = 15.7;
button_radius = 0.1;
button_height = 12;

lens_thickness = 2;
lens_size = button_size - wall_thickness*2;
echo(lens_size);
lens_radius = 0.7 - 0.4;

button_hole_size = button_size - wall_thickness*4;
button_hole_height = button_height + 1;

wall_height = button_height - lens_thickness;
wall_width = button_size - wall_thickness;

/* [PCB] */
pcb_thickness = 1.6;
pcb_button = [6, 6, 7];
pcb_pin = [7.5,6.7,3.7];

/* [Housing] */
housing_size = 17.2;
housing_height = button_height + act_length + pcb_button[2] - space;

skirt_size = 19.15;
skirt_thickness = 0.75;



// Roundedcube function inspired by Daniel Upshaw
module roundedcube(size = [1,1,1], center = true, radius = 0.5) {
    // Create 4 cylinders for all corners of the cube, then the hull of them is made
    hull() {
        translate([size[0]/2-radius, size[1]/2-radius, 0])cylinder(h = size[2], r = radius, center = true);
        translate([-size[0]/2+radius, size[1]/2-radius, 0])cylinder(h = size[2], r = radius, center = true);
        translate([size[0]/2-radius, -size[1]/2+radius, 0])cylinder(h = size[2], r = radius, center = true);
        translate([-size[0]/2+radius, -size[1]/2+radius, 0])cylinder(h = size[2], r = radius, center = true);
    }
}


// Button
translate([0,0,20])color("red")union () {
    difference() {
        union() {
            // Button
            button = [button_size, button_size, button_height];
            roundedcube(button, true, button_radius);
            
            // Rail pug
            rail = [button_size + tolerance*8,rail_width,rail_height];
            translate([0, 0, -button_height/2 +rail_height/2])cube(rail, true);
        }
        // Lens
        translate([0, 0, button_height/2 - lens_thickness/2 + 0.5]){
            lens = [lens_size, lens_size, lens_thickness + 1];
            cube(lens,true);
        }
    
        // Button Hole
        button_hole = [button_hole_size, button_hole_size, button_hole_height];
        roundedcube(button_hole, true, lens_radius);
    }
    
    // Wall
    translate([0,0, -lens_thickness/2]) {
        cube([wall_thickness*2,wall_width,wall_height], true);
    }
    translate([0,0, -button_height/2-1.5 +3/2]) {
        cube([wall_thickness*5, wall_width, 5], true);
    }
    
    
    //Spring Pins
    translate([pos, pos, -button_height/2]){    
        translate([0,0,-0.5])cylinder(h = 1 , d = 1.6 , center = true);
        translate([0,0,-2])cylinder(h = 4 , d = 1 , center = true);
    }
    translate([pos, -pos, -button_height/2]){    
        translate([0,0,-0.5])cylinder(h = 1 , d = 1.6 , center = true);
        translate([0,0,-2])cylinder(h = 4 , d = 1 , center = true);
    }
    translate([-pos, pos, -button_height/2]){    
        translate([0,0,-0.5])cylinder(h = 1 , d = 1.6 , center = true);
        translate([0,0,-2])cylinder(h = 4 , d = 1 , center = true);
    }
    translate([-pos, -pos, -button_height/2]){    
        translate([0,0,-0.5])cylinder(h = 1 , d = 1.6 , center = true);
        translate([0,0,-2])cylinder(h = 4 , d = 1 , center = true);
    }
    
    
    
    // Spring Tabs
    difference() {
        
        translate([0,0, -button_height/2 +3/2]) {
            roundedcube([button_size, button_size, 3], true, button_radius);
        }
        
        // Cuts
        cube([100, 8, 100], true);
        cube([8, 100, 100], true);
        
        translate([0,0,-7]){
            cylinder(housing_size/2,00,housing_size,$fn=4,center = true);
        }
        
        
    }
}

// Housing
color("lime")union() { difference() {
    union() {
        // Skirt
        skirt = [skirt_size, skirt_size, skirt_thickness];
        translate([0, 0, -(skirt_thickness - button_height)/2 -space ])roundedcube(skirt, true, 1.5);
        
        // Housing
        housing = [housing_size, housing_size, housing_height];
        translate([0, 0, -(housing_height - button_height)/2 -space ])roundedcube(housing, true, button_radius+0.2);
        
        translate([0,0, button_height/2 -0.5 -space -plate_thickness -skirt_thickness])cube([5,housing_size+tolerance*4,1], true);
    }
    
    // Hole for Button to fit in
    hole = [button_size + tolerance*2, button_size + tolerance*2, 100];
    roundedcube(hole, true, 0.1);
    
    // Railing
    rail = [housing_size + 1,rail_width + tolerance*2,rail_height + act_length + tolerance*2];
    translate([0, 0, -button_height/2 +rail_height/2 -act_length/2])cube(rail, true);
    
}
    
        
    difference() {
        // Housing
        housing = [housing_size, housing_size, pcb_button[2]-1];
        color("purple")translate([0, 0, -(housing_height - button_height)/2 -space -housing_height/2 +((pcb_button[2]-1)/2) ])roundedcube(housing, true, button_radius+0.2);
        // Chamfer
        translate([0, 0, -housing_size/4 -(housing_height - button_height)/2 -space -housing_height/2 +6.5]){
            cylinder(housing_size/2,00,housing_size,$fn=4,center = true);
        }
        // Cuts
        cube([100, 8, 100], true);
        cube([8, 100, 100], true);
    
        // Screwholes
        translate([pos, pos, 0])cylinder(h = 100, d = 1.6, center = true);
        translate([-pos, pos,0])cylinder(h = 100, d = 1.6, center = true);
        translate([pos, -pos,0])cylinder(h = 100, d = 1.6, center = true);
        translate([-pos, -pos,0])cylinder(h = 100, d = 1.6, center = true);
        
        // Springholes
        translate([0,0,-(housing_height - button_height)/2 -space -housing_height/2 +pcb_button[2]/2 +spring_height/2 -1] )   {
            translate([pos, pos, 0])cylinder(h = spring_height, d = spring_diameter, center = true);
            translate([-pos, pos, 0])cylinder(h = spring_height, d = spring_diameter, center = true);
            translate([pos, -pos, 0])cylinder(h = spring_height, d = spring_diameter, center = true);
            translate([-pos, -pos, 0])cylinder(h = spring_height, d = spring_diameter, center = true);
        }
    }
    
}




// PCB
translate([0,0,-20])color("green")translate([0, 0, -button_height/2 -pcb_button[2] -act_length]) {
    difference() {
        union() {
            // PCB Plate
            pcb = [housing_size, housing_size, pcb_thickness];
            translate([0,0,-pcb_thickness/2])roundedcube(pcb, true, button_radius);
    
            // PCB Button
            translate([0,0,pcb_button[2]/2])cube(pcb_button, true);
    
            // LED spacers
            translate([5,0,5/2])cylinder(h = 5, r = 2, center = true);
            translate([-5,0,5/2])cylinder(h = 5, r = 2, center = true);
            // LEDs
            translate([5,0,5+5/2])cylinder(h = 5, r = 1.5, center = true);
            translate([-5,0,5+5/2])cylinder(h = 5, r = 1.5, center = true);
            
            // Pin Header
            translate([0,6,pcb_pin.z/2])cube(pcb_pin, true);
        }
        // Screholes
        translate([pos, pos, 0])cylinder(h = 5, r = 1.5/2, center = true);
        translate([-pos, pos, 0])cylinder(h = 5, r = 1.5/2, center = true);
        translate([pos, -pos, 0])cylinder(h = 5, r = 1.5/2, center = true);
        translate([-pos, -pos, 0])cylinder(h = 5, r = 1.5/2, center = true);
    }
}



