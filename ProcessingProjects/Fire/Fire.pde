import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;

PeasyCam cam;

ParticleSystem ps; // The main particle system.
SmokeParticleSystem sps; // The main particle system.
PImage fire[] = new PImage[16];
PImage smoke;

int ParticleCount = 0;

void setup() {
  size(640, 1024, P3D);
  ps = new ParticleSystem(new PVector(width/2, 500));
  sps = new SmokeParticleSystem(new PVector(width/2, 500));

  //G_eyeX = 423;  //old value = width /2;
  //G_eyeY = -26;  //old value = weight / 2;
  //G_eyeZ = 915;  //old value = (height/2.0) / tan(PI*30.0 / 180.0) + 200;

  int cnt = 0;
  for (int i = 0; i < 4; i++) {
    for (int j = 0; j < 4; j++) {
      fire[cnt] = loadImage("flame_"+i+"_"+j+".png");
      cnt++;
    }
  }
  smoke = loadImage("smoke.png");
  

  cam = new PeasyCam(this, 
    width/2, height/2, 0, 
    600);
  cam.setRotations(0.35414395, 
    0.58189636, 
    -0.19976383
    );
}

void draw() {
  surface.setTitle("Fire Simluation");
  background(120);
  
  textSize(24);
  
  drawFloor(#0FA00D);
  
  cam.beginHUD();
  fill(255);
  text("FPS: " + nfc(frameRate, 2), 10, 24);
  text("Particles: " + ParticleCount, 10, 24*2);
  cam.endHUD();
  
  hint(DISABLE_DEPTH_TEST);

  // make logs (setup)
  fill(#905900);
  noStroke();

  // first log
  pushMatrix();
  int boxX = 10, boxY = 10, boxZ = 80;
  translate((width/2), height/2 - (boxY/2), 0);
  rotateY(radians(45));
  box(boxX, boxY, boxZ);
  popMatrix();

  // second log (rotation flipped)
  pushMatrix();
  translate((width/2), height/2 - (boxY/2), 0);
  rotateY(radians(-45));
  box(boxX, boxY, boxZ);
  popMatrix();

  // 10
  for (int i = 0; i < 40; i++) {
    sps.addParticle();
    ParticleCount++;
  }
  sps.run();

  // 30
  for (int i = 0; i < 40; i++) {
    ps.addParticle();
    ParticleCount++;
  }
  ps.run();

  //cameraHandler();
}