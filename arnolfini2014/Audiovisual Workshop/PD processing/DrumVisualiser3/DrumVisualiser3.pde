import oscP5.*;
import netP5.*;

OscP5 oscP5;

int kick;
int snare;
int hat;
int xLoc;
int yLocKick;
int yLocSnare;
int yLocHat;
color kickCol;
color snareCol;
color hatCol;

void setup() {
  size(1200, 800);
  background(0);
  kick = 150;
  snare = 150;
  hat = 75;
  xLoc = 100;
  yLocKick = 200;
  yLocSnare = 400;
  yLocHat = 600;
  kickCol = color(220, 100, 100);
  snareCol = color(100, 222, 100);
  hatCol = color(100, 100, 222);
  smooth();
  oscP5 = new OscP5(this, 12000);
}

void draw() {
  //background(0);
  
  xLoc = xLoc + 6;
  if(xLoc > width) { // wrapper (i.e., when it's all the way to the right)
    xLoc = 0; 
    //background(0);
     yLocKick = (int)random(50, height-50);
  yLocSnare = (int)random(50, height-50);
  yLocHat = (int)random(50, height-50);
    kickCol = color(random(255), random(255), random(255));
  snareCol = color(random(255), random(255), random(255));
  hatCol = color(random(255), random(255), random(255));
}
  
  // kick drum
  if(kick > 0) {
    kick = kick - 3;
    fill(kickCol); 
    //stroke(222, kick, kick);
    rect(xLoc-(kick/2), yLocKick-(kick/2), kick, kick);
  }  

  // snare drum
  if(snare>0) {
    snare = snare - 3;
    fill(snareCol); 
    //stroke(snare, 222, snare);
    rect(xLoc-(snare/2), yLocSnare-(snare/2), snare, snare);
  }  


  // hat
  if(hat>0) {
    hat = hat - 3;
    fill(hatCol); 
    //stroke(hat*3, 222, 222);
    rect(xLoc-(hat/2), yLocHat-(hat/2), hat, hat);
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
    kick = 75;
  } 
  if(theOscMessage.checkAddrPattern("/snare")==true) {
    snare = 75;
  } 
  if(theOscMessage.checkAddrPattern("/hat")==true) {
    hat = 75;
  }
}

