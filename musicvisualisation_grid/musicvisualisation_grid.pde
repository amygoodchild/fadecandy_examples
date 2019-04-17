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

Band[] bands;

// Set up song (you can also change this to line in)
Minim       minim;
//AudioPlayer mySong;
AudioInput  input;
FFT         fft;

// Set up midibus
MidiBus myBus; 

int scale = 50;
float minLerpAmount = 0.08;
float maxLerpAmount = 0.15;
float lerpAmount = 0.15;

float rowgap;
float colgap;
int rows = 20;
int cols = 20;


int r = 10;
float a = 0.8;

void setup()
{
  size(1920,1080);
  //fullScreen();
  colorMode(HSB, 100);
  smooth();
  frameRate(120);
  strokeWeight(1);
  
  colgap = width/rows;
  rowgap = height/cols;
  
  
  // Initialise music input
  minim = new Minim(this);  
  input = minim.getLineIn();
  fft = new FFT( input.bufferSize(), input.sampleRate() );
  
  bands = new Band[396];
  
  for (int i=0; i<bands.length; i++){
     bands[i] = new Band(i);
  }
  


}

void draw()
{
  background(0);
  //fill(0,0,0,5);
  //rect(0,0,width,height);
  fft.forward( input.left );
    
  getAmps();

  for(int i = 0; i< bands.length; i++){
    bands[i].display();
  }

}

void getAmps(){
  
  for(int i = 0; i< bands.length; i++){
    bands[i].getAmp(fft.getBand(i));
  
  }
  
}
