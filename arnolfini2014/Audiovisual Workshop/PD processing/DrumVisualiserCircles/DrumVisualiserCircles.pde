import oscP5.*;
import netP5.*;

OscP5 oscP5;

float jitter = 0;
int r = 120;
int g = 130;
int b = 120;
int fillcolor = 255;

void setup() {
  size(500, 500);
  smooth();
  oscP5 = new OscP5(this, 12000);
}

void draw() {
  background(r, g, b);
  
  // kick drum
  if(jitter > 0) {
    jitter = jitter - 0.35;
  }  

  // snare drum
  if(r>120) {
      r = r - 20;
      g = g - 20;
      b = b - 20;
  }  

  // hat
  if(fillcolor<255) {
     fillcolor = fillcolor + 10;
  }  
  
  for(int i = 0; i < 25; i++) {
    for(int j = 0; j < 25; j++) {
      fill(fillcolor);
      ellipse(10+(i*20)+random(-jitter, jitter), 10+(j*20)+random(-jitter, jitter), 10, 10);
    }
  } 
}

void mousePressed() {
  jitter = 4;
  r = 200; g = 230; b=200;
  fillcolor = 55;
}

void oscEvent(OscMessage theOscMessage) {
  if(theOscMessage.checkAddrPattern("/kick")==true) {
    jitter = 5;
  } 
  if(theOscMessage.checkAddrPattern("/snare")==true) {
    r = 200; 
    g = 230; 
    b=200;
  } 
  if(theOscMessage.checkAddrPattern("/hat")==true) {
    fillcolor = 55;
  }
}
