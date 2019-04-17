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
    
    row = band / rows;
    col = band % cols;
    
    x = col * colgap + (colgap/2);
    y = row * rowgap + (rowgap/2);
   
  
    
  scale = map(band, 207, 0,10,1);
    
  }
  
  void update(){
    
    
    
  }
  
  void display(){
     fill(100,0,100,50);
     ellipse(x,y,5,5);
    
    
   if (ampLerped*scale > 7){
     noStroke();
     fill(band/5,0,100, 80);
     ellipse (x,y,ampLerped*scale,ampLerped*scale);
    //rectMode(CENTER);
   // rect(x,y,ampLerped*scale,ampLerped*scale);
   }
    //fill(100,0,100);
   // text(band, x,y);
   

   // println("band: " + band);
   // println("amp: " + amp);
    
    
  }
  
  void getAmp (float newAmp){
    
     if (newAmp > ampLerped){       
       ampLerped = lerp(ampLerped, newAmp, maxLerpAmount);
     }
     else{
       ampLerped = lerp(ampLerped, newAmp, minLerpAmount);
       
     }
     amp = newAmp;

  }
  
  
  
}
