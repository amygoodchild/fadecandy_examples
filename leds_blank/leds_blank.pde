/*
// Fadecandy Set up for LEDs
*/


// Fadecandy server
OPC opc;



void setup() {
  // Sets up the canvas size
  size(600,800);
  
  // Sets the color mode to RGB out of 255
  colorMode(RGB, 255);
 
  // Connect to the fadecandy server
  opc = new OPC(this, "127.0.0.1", 7890);
  
  // Set this to false if you don't want to see the dots
  opc.showLocations(true);
   
  // Leave this whole section alone for now
  // opc.ledStrip(index, number of leds in strip, x location, y location, spacing, angle, direction)
  opc.ledStrip(0, 15, width/2, 15*2+150, 20, 0, false);
  opc.ledStrip(64, 15, width/2, 15*4+150, 20, 0, false);
  opc.ledStrip(64*2, 15, width/2, 15*6+150, 20, 0, false);
  opc.ledStrip(64*3, 15, width/2, 15*8+150, 20, 0, false);
  opc.ledStrip(64*4, 15, width/2, 15*10+150, 20, 0, false);
  opc.ledStrip(64*5, 15, width/2, 15*12+150, 20, 0, false);
  opc.ledStrip(64*6, 15, width/2, 15*14+150, 20, 0, false); 
  opc.ledStrip(64*7, 15, width/2, 15*16+150, 20, 0, false);
  // Leave this whole section alone for now
    
       
  background(0);
 
}

void draw() {
  background(0);
  
  // Write anything you want to draw on the lights here...
  



  
}
