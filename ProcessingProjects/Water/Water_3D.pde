import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;

ParticleSystem ps; // The main particle system.

int ParticleCount = 0;

PeasyCam cam;

void setup() {
  size(640, 1024, P3D);
  ps = new ParticleSystem(new PVector(width/2, 500));
  
  G_eyeX = 423;  //old value = width /2;
  G_eyeY = -26;  //old value = weight / 2;
  G_eyeZ = 915;  //old value = (height/2.0) / tan(PI*30.0 / 180.0) + 200;
  cam = new PeasyCam(this, 
    width/2, height/2, 0, 
    1000);
  cam.setRotations(0.35414395, 
    0.58189636, 
    -0.19976383
    );
}

void draw() {
  //surface.setTitle("Framerate: " + frameRate);
  background(50);
  textSize(24);
  fill(255);
  //text("FPS: " + frameRate, 6, 26);
  cam.beginHUD();
  fill(255);
  text("FPS: " + nfc(frameRate, 2), 10, 24);
  text("Particles: " + ParticleCount, 10, 24*2);
  cam.endHUD();

  for (int i = 0; i < 20; i++) {
    pushMatrix();
    fill(170);
    translate(width/2, height/2 - 7 - i);
    rotateX(PI/2);
    ellipse(0, 0, 500, 500);
    popMatrix();
  }
  
  pushMatrix();
  fill(0, 70, 255);
  translate(width/2, height/2 - 28);
  rotateX(PI/2);
  ellipse(0, 0, 470, 470);
  popMatrix();
  
  pushMatrix();
  fill(200);
  translate(width/2, height/2-29);
  rotateX(PI/2);
  ellipse(0, 0, 100, 100);
  popMatrix();
  
  for(int i = 0; i < 10; i++) {
    ps.addParticle();
  }
  ps.run();
  
  drawFloor(#000000);
  
  //cameraHandler(); 
}
