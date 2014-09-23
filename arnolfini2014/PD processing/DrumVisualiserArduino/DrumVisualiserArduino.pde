import oscP5.*;
import netP5.*;
import processing.serial.*;
import cc.arduino.*;

// NOTE: YOU NEED TO LOAD SIMPLEFIRMATA FOR THIS TO WORK

Arduino arduino;

color off = color(4, 79, 111);
color on = color(84, 145, 158);

int[] values = { Arduino.LOW, Arduino.LOW, Arduino.LOW, Arduino.LOW,
 Arduino.LOW, Arduino.LOW, Arduino.LOW, Arduino.LOW, Arduino.LOW,
 Arduino.LOW, Arduino.LOW, Arduino.LOW, Arduino.LOW, Arduino.LOW };

OscP5 oscP5;

int kick;
int snare;
int hat;

void setup() {
  size(800, 600);
  background(0);
  kick = 150;
  snare = 150;
  hat = 75;
  smooth();
  oscP5 = new OscP5(this, 12000);
    println(Arduino.list());
  arduino = new Arduino(this, Arduino.list()[0], 57600);
  
  for (int i = 0; i <= 13; i++)
    arduino.pinMode(i, Arduino.OUTPUT);
}

void draw() {
  background(0);

  
  // kick drum
  if(kick > 0) {
    kick = kick - 10;
    fill(222, kick, kick); 
    stroke(222, kick, kick);
    ellipse(200, 300, kick, kick);
  } else {
    arduino.digitalWrite(13, Arduino.LOW);
  }

  // snare drum
  if(snare>0) {
    snare = snare - 10;
    fill(snare, 222, snare); 
    stroke(snare, 222, snare);
  ellipse(600, 300, snare, snare);
  } else {
    arduino.digitalWrite(12, Arduino.LOW);
  } 


  // hat
  if(hat>0) {
    hat = hat - 10;
    fill(hat*3, 222, 222); 
    stroke(hat*3, 222, 222);
    rect(400-(hat/2), 300-(hat/2), hat, hat);
  } else {
    arduino.digitalWrite(11, Arduino.LOW);
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
        arduino.digitalWrite(13, Arduino.HIGH);
  } 
  if(theOscMessage.checkAddrPattern("/snare")==true) {
    snare = 150;
            arduino.digitalWrite(12, Arduino.HIGH);
  } 
  if(theOscMessage.checkAddrPattern("/hat")==true) {
    hat = 75;
            arduino.digitalWrite(11, Arduino.HIGH);
  }
}

