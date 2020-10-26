import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;

import processing.sound.*;

int ParticleCount = 0;
ArrayList<ParticleSystem> systemList; // List to contain all future created particle systems. 

PeasyCam cam;
SoundFile fireworkSFX;

void setup() {
  size(640, 1024, P3D);
  systemList = new ArrayList<ParticleSystem>();
  cam = new PeasyCam(this, 
    width/2, height/1.5, 0, 
    1000);
  cam.setRotations(0.35414395, 
    0.58189636, 
    -0.19976383
    );
    fireworkSFX = new SoundFile(this, "rocket.wav");
}

void mousePressed() {
  systemList.add(new ParticleSystem(new PVector(mouseX, mouseY, random(-width/2, width/2))));
  fireworkSFX.play();
}

void draw() {
  background(0, 0, 40);
  textSize(24);
  
  cam.beginHUD();
  fill(255);
  text("FPS: " + nfc(frameRate, 2), 10, 24);
  text("Particles: " + ParticleCount, 10, 24*2);
  cam.endHUD();

  drawFloor(#12CB48);

  for (int i = systemList.size() - 1; i >= 0; i--) { // run through all particle systems
    ParticleSystem ps = systemList.get(i);

    if (ps.rocket == 0) { // mechanism to delay explosion until rocket reaches position
      //noStroke();
      strokeWeight(3);
      stroke(255);
      fill(255, 120, 0);
      point(ps.x1, ps.y1, ps.z1);
      //triangle(ps.x1, ps.y1, ps.x2, ps.y2, ps.x3, ps.y3);
      ps.y1 -= 6;
      ps.y2 -= 6;
      ps.y3 -= 6;
      if (ps.y1 <= ps.origin.y) {
        ps.rocket = 1;
      }
    } else {
      ps.time += 1;
      if (ps.time < 100) {
        ps.addParticle();
        ps.run();
      } else { // Stops tracking particle system once it is done to avoid overloading
        if (ps.particles.isEmpty()) {
          systemList.remove(i);
        }
        ps.run();
      }
    }
  }
}



// A class to describe a group of Particles
// An ArrayList is used to manage the list of Particles 

class ParticleSystem {
  ArrayList<Particle> particles;
  PVector origin;
  int time = 0; // stops adding particles after a certain time
  int rocket = 0; // 0 for rocket not reached position. anything else for it has.
  float x1 = 0; // Coordinates for the rocket's triangle
  float y1 = 0; // Coordinates for the rocket's triangle
  float x2 = 0; // Coordinates for the rocket's triangle
  float y2 = 0; // Coordinates for the rocket's triangle
  float x3 = 0; // Coordinates for the rocket's triangle
  float y3 = 0; // Coordinates for the rocket's triangle
  float z1 = 0;
  color col;

  ParticleSystem(PVector position) {
    origin = position.copy();
    particles = new ArrayList<Particle>();
    x1 = position.x;
    y1 = position.y + 500;
    x2 = position.x + 3;
    y2 = position.y + 530;
    x3 = position.x - 3;
    y3 = position.y + 530;
    z1 = position.z;
    col = color(random(0, 255), random(0, 255), random(0, 255));
  }

  void addParticle() { // Adds 16 particles with different initial velocities to have the effect of an explosion.

    for (int i = 1; i <= 16; i++) {
      Particle c = new Particle(origin, i);
      c.col = col; 
      particles.add(c);
    }
  }

  void run() {
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.opacity = map(i, 0, particles.size(), 255, 0);
      if (i < particles.size()/10) {
        p.col = #DDDDDD;
      } else {
        p.col = col;
      }

      p.run();
      if (p.isDead()) {
        particles.remove(i);
        ParticleCount--;
      }
    }
  }
}


// A Particle class

class Particle {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float lifespan;
  float opacity;
  color col;

  Particle(PVector l, int x) { // Switch statements to initialize each particle to its specific velocity
    ParticleCount++;
    switch(x) {
    case 1:
      acceleration = new PVector(random(-0.001, 0.001), 0.001, random(-0.001, .001));
      velocity = new PVector(0.3, -0.7);
      break;
    case 2:
      acceleration = new PVector(random(-0.001, 0.001), 0.001, random(-0.001, .001));
      velocity = new PVector(0.5, -0.5);
      break;
    case 3:
      acceleration = new PVector(random(-0.001, 0.001), 0.001, random(-0.001, .001));
      velocity = new PVector(0.7, -0.3);
      break;
    case 4:
      acceleration = new PVector(random(-0.001, 0.001), 0.001, random(-0.001, .001));
      velocity = new PVector(0.8, 0);
      break;
    case 5:
      acceleration = new PVector(random(-0.001, 0.001), 0.001, random(-0.001, .001));
      velocity = new PVector(0.7, 0.3);
      break;
    case 6:
      acceleration = new PVector(random(-0.001, 0.001), 0.001, random(-0.001, .001));
      velocity = new PVector(0.5, 0.5);
      break;
    case 7:
      acceleration = new PVector(random(-0.001, 0.001), 0.001, random(-0.001, .001));
      velocity = new PVector(0.3, 0.7);
      break;
    case 8:
      acceleration = new PVector(random(-0.001, 0.001), 0.001, random(-0.001, .001));
      velocity = new PVector(0, 0.8);
      break;
    case 9:
      acceleration = new PVector(random(-0.001, 0.001), 0.001, random(-0.001, .001));
      velocity = new PVector(-0.3, 0.7);
      break;
    case 10:
      acceleration = new PVector(random(-0.001, 0.001), 0.001, random(-0.001, .001));
      velocity = new PVector(-0.5, 0.5);
      break;
    case 11:
      acceleration = new PVector(random(-0.001, 0.001), 0.001, random(-0.001, .001));
      velocity = new PVector(-0.7, 0.3);
      break;
    case 12:
      acceleration = new PVector(random(-0.001, 0.001), 0.001, random(-0.001, .001));
      velocity = new PVector(-0.8, 0);
      break;
    case 13:
      acceleration = new PVector(random(-0.001, 0.001), 0.001, random(-0.001, .001));
      velocity = new PVector(-0.7, -0.3);
      break;
    case 14:
      acceleration = new PVector(random(-0.001, 0.001), 0.001, random(-0.001, .001));
      velocity = new PVector(-0.5, -0.5);
      break;
    case 15:
      acceleration = new PVector(random(-0.001, 0.001), 0.001, random(-0.001, .001));
      velocity = new PVector(-0.3, -0.7);
      break;
    case 16:
      acceleration = new PVector(random(-0.001, 0.001), 0.001, random(-0.001, .001));
      velocity = new PVector(0, -0.8);
      break;
    }
    position = l.copy();
    lifespan = 255.0;
  }

  void run() {
    update();
    display();
  }

  // Method to update position
  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    lifespan -= 1;
  }

  // Method to display
  void display() {
    strokeWeight(3);
    stroke(col, opacity);
    //stroke(random(0,255), random(0,255), random(0,255), lifespan);
    //pushMatrix();
    point(position.x, position.y, position.z); // Can be make points instead of ellipses
    //point(0,0,0);
    //popMatrix();
  }

  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  }
}


void drawFloor(color c) {
  noStroke();
  fill(c);
  pushMatrix();
  translate(width/2, height, 0);
  box(width, 5, width);
  popMatrix();
}
