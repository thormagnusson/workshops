import oscP5.*;
import netP5.*;

OscP5 oscP5;

int kick;
int snare;
int hat;
int xLoc;

void setup() {
  size(1200, 800);
  background(0);
  kick = 150;
  snare = 150;
  hat = 75;
  xLoc = 100;
  smooth();
  oscP5 = new OscP5(this, 12000);
}

void draw() {
  //background(0);
  
  xLoc = xLoc + 3;
  if(xLoc > width) {
    xLoc = 0; 
    background(0);
}
  
  // kick drum
  if(kick > 0) {
    kick = kick - 3;
    fill(222, kick, kick); 
    //stroke(222, kick, kick);
    ellipse(xLoc, 200, kick, kick);
  }  

  // snare drum
  if(snare>0) {
    snare = snare - 3;
    fill(snare, 222, snare); 
    //stroke(snare, 222, snare);
  ellipse(xLoc, 400, snare, snare);
  }  


  // hat
  if(hat>0) {
    hat = hat - 3;
    fill(hat*3, 222, 222); 
    //stroke(hat*3, 222, 222);
    rect(xLoc-(hat/2), 600-(hat/2), hat, hat);
  }  



}

void mousePressed() {
  kick = 150;
  snare = 150;
  hat = 75;
}

// if I got OSC message that is "kick" then I set kick to 150

void oscEvent(OscMessage theOscMessage) {
  if(theOscMessage.checkAddrPattern("/kick")==true) {
    kick = 150;
  } 
  if(theOscMessage.checkAddrPattern("/snare")==true) {
    snare = 150;
  } 
  if(theOscMessage.checkAddrPattern("/hat")==true) {
    hat = 55;
  }
}

