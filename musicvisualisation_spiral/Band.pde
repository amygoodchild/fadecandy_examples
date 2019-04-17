class Band{
  
  
    int band;
    float amp;
    float ampLerped;
    float max;
    
    int row;
    int col;
    
    float x;
    float y;
    
    float scale;
  
  
  Band(int band_){
    
    band = band_;
    max = 0;
    amp = 0;
    
    row = band / 25;
    col = band % 25;
    
   // x = col * colgap + (colgap/2);
   // y = row * rowgap + (rowgap/2);
   
   float t = turns*radians(band);
   x = width/2 + a * t * r * cos(t);
   y = height/2 + a * t * r * sin(t);
    
    scale = map(band, 207, 0, sizeMapHighest,sizeMapLowest);
    
  }
  
  void update(){
    
    
    
  }
  
  void display(){
     fill(100,0,100,10);
    //noFill();
    //ellipse(x,y,5,5);
    
    
  
    noStroke();
    fill( ( ( (band)%hueBand)+hueShift)%100, sat,bri, opa);
    rectMode(CENTER);
    
    pushMatrix();
    translate(x,y);
    rotate(ampLerped*scale);
    
    
    rect (0,0,ampLerped*scale*fullScale,ampLerped*scale*fullScale);
    popMatrix();
   // fill(100,0,100);
   // text(band, x,y);
   
   
    
   

   // println("band: " + band);
   // println("amp: " + amp);
    
    
  }
  
  void getAmp (float newAmp){
    
     ampLerped = lerp(ampLerped, newAmp, lerpAmount);
     amp = newAmp;

  }
  
  void calcLocation(){
   
   float t = turns*radians(band);
   x = width/2 + a * t * r * cos(t);
   y = height/2 + a * t * r * sin(t);
  }
  
  void calcScale(){
    scale = map(band, 207, 0, sizeMapHighest,sizeMapLowest); 
  }
  
  
}
