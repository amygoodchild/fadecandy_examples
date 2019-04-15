// OSC 
// Fadecandy server
OPC opc;

float x;

void setup() {
  size(600,800);
  colorMode(HSB, 100);
  x=0;
  
  // Connect to the local instance of fcserver. You can change this line to connect to another computer's fcserver
  opc = new OPC(this, "127.0.0.1", 7890);
  opc.showLocations(true);
  
  opc.ledStrip(0, 20, width/2, 15*2+150, 20, 0, false);
  opc.ledStrip(64, 20, width/2, 15*4+150, 20, 0, false);
  opc.ledStrip(64*2, 20, width/2, 15*6+150, 20, 0, false);
  opc.ledStrip(64*3, 20, width/2, 15*8+150, 20, 0, false);
  opc.ledStrip(64*4, 20, width/2, 15*10+150, 20, 0, false);
  opc.ledStrip(64*5, 20, width/2, 15*12+150, 20, 0, false);
  opc.ledStrip(64*6, 20, width/2, 15*14+150, 20, 0, false); 
  opc.ledStrip(64*7, 20, width/2, 15*16+150, 20, 0, false);
    
  background(0);
 
}

void draw() {
  background(0);
  fill(100,0,100);
  noStroke();
  ellipse(mouseX, mouseY, 100,100);
  
  x+=5;
  
  if(x>width+200){
    x = -300;
  }
  
  fill(50,80,80);
  rect(x,0,100,800);
  
  fill(40,80,80);
  rect(x-100,0,100,800);
  
  fill(20,80,80);
  rect(x-200,0,100,800);
  
}
