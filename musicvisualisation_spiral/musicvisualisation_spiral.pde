/*
/ Music visuals based on a spectrum analyser
/ More variables controlled with a midi controller 
/
/ Amy Goodchild Feb 2019
/ www.amygoodchild.com
/ 
*/

// Midi Library
import themidibus.*;
import javax.sound.midi.MidiMessage; 
import javax.sound.midi.SysexMessage;
import javax.sound.midi.ShortMessage;


// Music library
import ddf.minim.analysis.*;
import ddf.minim.*;

// Set up midibus
MidiBus myBus; 


// Set up song (you can also change this to line in)
Minim       minim;
//AudioPlayer mySong;
AudioInput  input;
FFT         fft;

Band[] bands;

float lerpAmount = 0.15;

float rowgap;
float colgap;

float r = 15;
float newr = 15;
float a = 0.8;
float newturns = 5;
float turns = 5;
float fullScale = 0.02;
float newFullScale = 0.5;
float sat = 40;
float bri = 90;
float opa = 100;
float hueShift;
float backgroundOpacity = 100;
float hueBand = 30;

// How many frames from old variable to the next, higher is smoother but less responsive. 
int animationSpeed = 50;
int sizeAnimationSpeed = 20;

float sizeMapLowest = 0;
float sizeMapHighest = 600;

void setup()
{
  //size(1920,1080);
  fullScreen();
  colorMode(HSB, 100);
  smooth();
  frameRate(60);
  strokeWeight(1);
  
  
 
    
  colgap = width/25;
  rowgap = height/20;
  
  myBus = new MidiBus(this, 0, 0); // Create a new MidiBus object

  
  // Initialise music input
  minim = new Minim(this);  
  input = minim.getLineIn();
  fft = new FFT( input.bufferSize(), input.sampleRate() );
  
  bands = new Band[400];
  
  for (int i=0; i<bands.length; i++){
     bands[i] = new Band(i);
  }
  
  background(0);
  


}

void draw()
{
  //background(0);
  rectMode(CORNER);
  fill(0,0,0,backgroundOpacity);
  rect(0,0,width,height);
  fft.forward( input.left );
    
  
  animate();
  getAmps();

  for(int i = 0; i< bands.length; i++){
    bands[i].display();
  }
  
  fill(0,0,0);
  rect(0,0,100,30);
  fill(0,0,100);
  text(frameRate,10,10);

}

void animate(){
    // Animate towards new scale
    float scaleGap = newFullScale - fullScale;
    scaleGap = scaleGap / sizeAnimationSpeed;
    fullScale += scaleGap;
    
    
     // Animate towards new radius
    float rGap = newr - r;
    rGap = rGap / animationSpeed;
    r += rGap;   
 
 
     // Animate towards new turns
    float turnsGap = newturns - turns;
    turnsGap = turnsGap / animationSpeed;
    turns += turnsGap; 
    
    for(int i = 0; i< bands.length; i++){
       bands[i].calcLocation();
     } 
}

void getAmps(){
  
  for(int i = 0; i< bands.length; i+=2){
    bands[i].getAmp(fft.getBand(i));
  
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
  
  
  // Knob 16: full scale
  if ((int)(message.getMessage()[1] & 0xFF) == 16){
     newFullScale = map( (int)(message.getMessage()[2] & 0xFF), 0, 127, 0.02, 3);        
  }
  
  // Knob 17: radius
  if ((int)(message.getMessage()[1] & 0xFF) == 17){
     newr = map( (int)(message.getMessage()[2] & 0xFF), 0, 127, 0.01, 150);
     for(int i = 0; i< bands.length; i++){
       bands[i].calcLocation();
     }   
  }
  
    // Knob 18: turns
  if ((int)(message.getMessage()[1] & 0xFF) == 18){
     newturns = map( (int)(message.getMessage()[2] & 0xFF), 0, 127, 1, 10);
     for(int i = 0; i< bands.length; i++){
       bands[i].calcLocation();
     }   
  } 
  
   // Knob 19: lerp
  if ((int)(message.getMessage()[1] & 0xFF) == 19){
     lerpAmount = map( (int)(message.getMessage()[2] & 0xFF), 0, 127, 0.05, .5);  
  } 
  
  
  // Knob 20: sat
  if ((int)(message.getMessage()[1] & 0xFF) == 20){
     sat= map( (int)(message.getMessage()[2] & 0xFF), 0, 127, 0, 100);  
  } 
  
 // Knob 21: bri
  if ((int)(message.getMessage()[1] & 0xFF) == 21){
     bri= map( (int)(message.getMessage()[2] & 0xFF), 0, 127, 0, 100);  
  } 
  
  // Knob 22: opacity
  if ((int)(message.getMessage()[1] & 0xFF) == 22){
     opa= map( (int)(message.getMessage()[2] & 0xFF), 0, 127, 0, 100);  
  } 
  
   
  // Knob 23: background opacity
  if ((int)(message.getMessage()[1] & 0xFF) == 23){
    float input = (int)(message.getMessage()[2] & 0xFF);
      
      // mapped unevenly to give more control at lower opacities     
      if (input < 40){
        backgroundOpacity = map( input, 0, 49, 0.1, 2);
      }
      else if (input < 70){
         backgroundOpacity = map( input, 50, 69, 2.01, 5);       
      }
      else{
         backgroundOpacity = map( input, 70, 127, 5.01, 15);     
      }
  } 
  
  // slider 0
  if ((int)(message.getMessage()[1] & 0xFF) == 0){
     sizeMapLowest = map( (int)(message.getMessage()[2] & 0xFF), 0, 127, 0.1, 10); 
     for(int i = 0; i< bands.length; i++){
       bands[i].calcScale();
     }  
  } 
  
  // slider 1
  if ((int)(message.getMessage()[1] & 0xFF) == 1){
     sizeMapHighest = map( (int)(message.getMessage()[2] & 0xFF), 0, 127, 30, 800); 
     for(int i = 0; i< bands.length; i++){
       bands[i].calcScale();
     }  
  }
  
  // slider 2
  if ((int)(message.getMessage()[1] & 0xFF) == 2){
     hueShift = map( (int)(message.getMessage()[2] & 0xFF), 0, 127, 0, 100); 
     
  }
  
    // slider 3
  if ((int)(message.getMessage()[1] & 0xFF) == 3){
     hueBand = map( (int)(message.getMessage()[2] & 0xFF), 0, 127, 0, 60); 
     
  }
  
}
