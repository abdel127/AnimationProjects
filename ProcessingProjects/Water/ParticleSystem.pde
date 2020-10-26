// A class to describe a group of Particles
// An ArrayList is used to manage the list of Particles 

class ParticleSystem {
  ArrayList<Particle> particles;
  PVector origin;

  ParticleSystem(PVector position) {
    origin = position.copy();
    particles = new ArrayList<Particle>();
  }

  void addParticle() {
    for (int i = 1; i <= 16; i++) {
      particles.add(new Particle(origin, i));
    }
  }

  void run() { // runs each particle and removes it if it is dead
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.run();
      if (p.isDead()) {
        ParticleCount--;
        particles.remove(i);
      }
    }
  }
}


// A Particle class

class Particle {
  PVector position = new PVector();
  PVector velocity = new PVector();
  PVector acceleration = new PVector();
  PVector negativeX = new PVector(-0.0001, 0, 0); // rate of acceleration based on each particle's x-acceleration ...
  PVector positiveX = new PVector(0.0001, 0, 0); //... in order to have it flow BACK to the middle
  PVector negativeZ = new PVector(0, 0, -0.0001); // rate of acceleration based on each particle's x-acceleration ...
  PVector positiveZ = new PVector(0, 0, 0.0001); //... in order to have it flow BACK to the middle
  float lifespan;

  Particle(PVector l, int x) {
     ParticleCount++;
     switch(x) {
      case 1:
        acceleration = new PVector(0.002, 0.04, -0.004667);
        velocity = new PVector(0.3, random(-4.3, -4), -0.7);
        break;
      case 2:
        acceleration = new PVector(0.004, 0.04, -0.004);
        velocity = new PVector(0.6, random(-4.3, -4), -0.6);
        break;
      case 3:
        acceleration = new PVector(0.004667, 0.04, -0.002);
        velocity = new PVector(0.7, random(-4.3, -4), -0.3);
        break;
      case 4:
        acceleration = new PVector(0.004, 0.04, 0);
        velocity = new PVector(0.6, random(-4.3, -4), 0);
        break;
      case 5:
        acceleration = new PVector(0.004667, 0.04, 0.002);
        velocity = new PVector(0.7, random(-4.3, -4), 0.3);
        break;
      case 6:
        acceleration = new PVector(0.004, 0.04, 0.004);
        velocity = new PVector(0.6, random(-4.3, -4), 0.6);
        break;
      case 7:
        acceleration = new PVector(0.002, 0.04, 0.004667);
        velocity = new PVector(0.3, random(-4.3, -4), 0.7);
        break;
      case 8:
        acceleration = new PVector(0, 0.04, 0.004);
        velocity = new PVector(0, random(-4.3, -4), 0.6);
        break;
      case 9:
        acceleration = new PVector(-0.002, 0.04, 0.004667);
        velocity = new PVector(-0.3, random(-4.3, -4), 0.7);
        break;
      case 10:
        acceleration = new PVector(-0.004, 0.04, 0.004);
        velocity = new PVector(-0.6, random(-4.3, -4), 0.6);
        break;
      case 11:
        acceleration = new PVector(-0.004667, 0.04, 0.002);
        velocity = new PVector(-0.7, random(-4.3, -4), 0.3);
        break;
      case 12:
        acceleration = new PVector(-0.004, 0.04, 0);
        velocity = new PVector(-0.6, random(-4.3, -4), 0);
        break;
      case 13:
        acceleration = new PVector(-0.004667, 0.04, -0.002);
        velocity = new PVector(-0.7, random(-4.3, -4), -0.3);
        break;
      case 14:
        acceleration = new PVector(-0.004, 0.04, -0.004);
        velocity = new PVector(-0.6, random(-4.3, -4), -0.6);
        break;
      case 15:
        acceleration = new PVector(-0.002, 0.04, -0.004667);
        velocity = new PVector(-0.3, random(-4.3, -4), -0.7);
        break;
      case 16:
        acceleration = new PVector(0, 0.04, -0.004);
        velocity = new PVector(0, random(-4.3, -4), -0.6);
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
    //if (velocity.x < 0) {
    //  acceleration.sub(negativeX);
    //} else {
    //  acceleration.sub(positiveX);
    //}
    //// not exactly sure how to handle this. seemed to work
    //if (velocity.z < 0) {
    //  acceleration.sub(negativeZ);
    //} else {
    //  acceleration.sub(positiveZ);
    //}

    velocity.add(acceleration);
    position.add(velocity);
    lifespan -= 1.4;
  }

  // Method to display
  void display() {
    strokeWeight(4);
    stroke(0, random(50, 100), 255, lifespan); // The alpha value decreases as lifespan decreases, giving them the translucent effect.
    point(position.x, position.y, position.z);
  }

  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  }
}