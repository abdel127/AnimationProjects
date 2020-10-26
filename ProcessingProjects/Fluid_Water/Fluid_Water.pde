water_particles myWater;
float timeStep = 0.008;
float x1;
float x2;
PVector v1;
PVector v2;
PVector n;

PImage img;

void setup() {
  size(1000, 500, P3D);
  background(255);
  myWater = new water_particles(430);
  
  
  // Random waves to have the water move when run.
  for (int i = 0; i*myWater.dx < 180; i++) {
    myWater.h[myWater.n_particles/6+i] = 260 + i*myWater.dx;
  }
  
  for (int i = 0; i*myWater.dx < 160; i++) {
    myWater.h[myWater.n_particles/6-i] = 260 + i*myWater.dx;
  }
  
  for (int i = 0; i*myWater.dx < 100; i++) {
    myWater.h[myWater.n_particles/2+i-20] = 530 - i*myWater.dx;
  }
  
  for (int i = 0; i*myWater.dx < 100; i++) {
    myWater.h[myWater.n_particles/2-i-20] = 530 - i*myWater.dx;
  }
  
  img = loadImage("water.jpg");
  
}

void draw() {
  camera(500, height/4.0, (height/2.0) / tan(PI*30.0 / 180.0)+450, width/2.0, height/2.0, 350, 0, 1, 0);
  background(255);
  directionalLight(205, 205, 205, 1, 1, 0);
  directionalLight(205, 205, 205, 0, 1, -1);
  
  textSize(30);
  text(frameRate, 140, 150, 400);
  
  for (int i = 0; i < 40; i++) { myWater.update(timeStep); }
  
  myWater.display();
  
  stroke(0);
  strokeWeight(3);
  
  // Top Square
  line(0, 200, 300, 0, 200, -200);
  line((myWater.n_particles - 1)*myWater.dx, 200, 300, (myWater.n_particles - 1)*myWater.dx, 200, -200);
  line(0, 200, -200, (myWater.n_particles - 1)*myWater.dx, 200, -200);
  line(0, 200, 300, (myWater.n_particles - 1)*myWater.dx, 200, 300);
  
  // Left 2 sides
  line(0, 200, 300, 0, 590, 300);
  line(0, 200, -200, 0, 590, -200);
  
  // Right 2 sides
  line((myWater.n_particles - 1)*myWater.dx, 200, 300, (myWater.n_particles - 1)*myWater.dx, 590, 300);
  line((myWater.n_particles - 1)*myWater.dx, 200, -200, (myWater.n_particles - 1)*myWater.dx, 590, -200);
  
  // Bottom line
  line(0, 590, 300, (myWater.n_particles - 1)*myWater.dx, 590, 300);
}
