/*
// Fadecandy Set up for LEDs
*/

float speed;
float x;
float backgroundOpacity;
float hueGap;
float hueStarter;
float rectWidth;

// Fadecandy server
OPC opc;

// Midi Library
import themidibus.*;
import javax.sound.midi.MidiMessage; 
import javax.sound.midi.SysexMessage;
import javax.sound.midi.ShortMessage;

// Set up midibus
MidiBus myBus; 


void setup() {
  // Sets up the canvas size
  size(600,800);
  
  // Create a new MidiBus object
  myBus = new MidiBus(this, 0, 0); 

  // Sets the color mode to RGB out of 255
  colorMode(HSB, 100);
 
  // Connect to the fadecandy server
  opc = new OPC(this, "127.0.0.1", 7890);
  
  // Set this to false if you don't want to see the dots
  opc.showLocations(false);
   
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
    
  hueGap=10;  
  hueStarter = 0;
  speed = 3; 
  rectWidth = 30;
  
  background(0);
 
}

void draw() {
  //background(0);
  
  fill(0,0,0,backgroundOpacity);
  rect(0,0,width,height);
  
  x+=speed;
  
  if(x>width-50){
    x=50;
  }
  if(x<50){
    x=width-50;
  }
  noStroke();
  for (int i=0; i<8; i++){
    fill((hueStarter+i*hueGap)%100,80,100);
    rect(x+i*10, i*30+170, rectWidth,20); 
  }



  
}


void midiMessage(MidiMessage message) { // You can also use midiMessage(MidiMessage message, long timestamp, String bus_name)
  // Receive a MidiMessage

   // Print out some info on the midi message. 
   //println();
   //println("MidiMessage Data:");
   //println("--------");
   //println("Status Byte/MIDI Command:"+message.getStatus());
   //println("Param 0: "+(int)(message.getMessage()[0] & 0xFF));  
   //println("Param 1: "+(int)(message.getMessage()[1] & 0xFF));
   //println("Param 2: "+(int)(message.getMessage()[2] & 0xFF));
  
  
  // Slider0: Background Opacity
  if ((int)(message.getMessage()[1] & 0xFF) == 0){
     backgroundOpacity = map( (int)(message.getMessage()[2] & 0xFF), 0, 127, 0, 10);        
   }

  // Slider1: Speed
  if ((int)(message.getMessage()[1] & 0xFF) == 1){
     speed = map( (int)(message.getMessage()[2] & 0xFF), 0, 127, -20, 20);        
   }
   
   // Slider2: HueGap
  if ((int)(message.getMessage()[1] & 0xFF) == 2){
     hueGap = map( (int)(message.getMessage()[2] & 0xFF), 0, 127, 0, 10);        
   }
   
   // Slider3: HueStarter
  if ((int)(message.getMessage()[1] & 0xFF) == 3){
     hueStarter = map( (int)(message.getMessage()[2] & 0xFF), 0, 127, 0, 100);        
   }
   
   // Slider4: Width
  if ((int)(message.getMessage()[1] & 0xFF) == 4){
     rectWidth = map( (int)(message.getMessage()[2] & 0xFF), 0, 127, 0, 100);        
   }

}
  
