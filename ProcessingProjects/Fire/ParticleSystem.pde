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
    particles.add(new Particle(origin));
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
  PVector negativeX = new PVector(-0.001, 0.001, 0); // rate of acceleration based on each particle's x-acceleration ...
  PVector positiveX = new PVector(0.001, 0.001, 0); //... in order to have it flow BACK to the middle
  PVector negativeZ = new PVector(0, 0.001, -0.001); // rate of acceleration based on each particle's x-acceleration ...
  PVector positiveZ = new PVector(0, 0.001, 0.001); //... in order to have it flow BACK to the middle
  float lifespan;

  Particle(PVector l) {
    // setting the value is probably more cost effecient than creating new objects
    velocity.set(random(-1.5, 1.5), random(-1.5, -0.2), random(-1.5, 1.5)); // the range of the random factor plays in the size of the fire (x, y) -> (width, height)
    float old = acceleration.z;
    // use an 'old' value so the z value indepedent
    if (velocity.x < 0) { // give it positive acceleration if velocity is negative
      acceleration.set(0.01, 0.008, old);
    } else {
      acceleration.set(-0.01, 0.008, old);
    } // give it negative acceleration if velocity is positive

    old = acceleration.x;
    if (velocity.z < 0) { // give it positive acceleration if velocity is negative
      acceleration.set(old, 0.008, 0.01);
    } else {
      acceleration.set(old, 0.008, -0.01);
    } // give it negative acceleration if velocity is positive
    position = l.copy();
    lifespan = 255.0;
  }

  void run() {
    update();
    display();
  }

  // Method to update position
  void update() {
    if (velocity.x < 0) {
      acceleration.sub(negativeX);
    } else {
      acceleration.sub(positiveX);
    }
    // not exactly sure how to handle this. seemed to work
    if (velocity.z < 0) {
      acceleration.sub(negativeZ);
    } else {
      acceleration.sub(positiveZ);
    }

    velocity.add(acceleration);
    position.add(velocity);
    lifespan -= 4;
  }

  // Method to display
  void display() {
    //strokeWeight(6);
    imageMode(CENTER);
    noStroke();
    
    //blendMode(ADD);
    //fill(#FFFFFF);
    //stroke(255, 255-lifespan, 0, lifespan); // The alpha value decreases as lifespan decreases, giving them the translucent effect.
    pushMatrix();
    tint(255, lifespan*random(.5,.7));
    translate(position.x, position.y, position.z);
    rotateY(radians(random(0,360)));
    int val = int(random(0,16));
    //println(val);
    image(fire[val], 0, 0, 15, 15);
    popMatrix();
    //beginShape();
    //texture(fire[0]);
    //vertex(position.x, position.y, position.z, 0, 0);
    //vertex(position.x + 10, position.y, position.z, 128, 0);
    //vertex(position.x + 10, position.y + 10, position.z, 128, 128);
    //vertex(position.x, position.y + 10, position.z, 0, 128);
    //endShape();
  }

  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  }
}