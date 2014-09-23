
void setup() {
  size(1000, 800);
  frameRate(24);
  background(100, 200, 100);
  rect(100, 100, 300, 200);
  fill(200, 100, 200);
  rect(120, 120, 30, 30);
  fill(100, 100, 200);
  for(int i = 0; i<100; i = i+1){
    ellipse(30, 120+(i*30), 30, 30);
  }

  for(int i = 0; i<1000; i = i+1){
    fill(random(100, 200), random(100, 200), random(100, 200));
    ellipse(random(1200), random(800), random(100), random(100));
  }
}

void draw(){
  //background(100, 200, 100);
  fill(255, 255, 255);
  rect(mouseX, mouseY, 30, 30);
  rect(mouseX, mouseY, 30, 30);
  rect(mouseX+30, mouseY+30, 30, 30);
  rect(mouseX-30, mouseY+30, 30, 30);
  for(int i = 0; i<100; i = i+1){
    ellipse(mouseX+random(-120,120), mouseY+random(-120,120), 30, 30);
  }
}

