// A class to describe a group of Particles
// An ArrayList is used to manage the list of Particles 

class SmokeParticleSystem {
  ArrayList<SmokeParticle> particles;
  PVector origin;

  SmokeParticleSystem(PVector position) {
    origin = position.copy();
    particles = new ArrayList<SmokeParticle>();
  }

  void addParticle() {
    particles.add(new SmokeParticle(origin));
  }

  void run() { // runs each particle and removes it if it is dead
    for (int i = particles.size()-1; i >= 0; i--) {
      SmokeParticle p = particles.get(i);
      p.run();
      if (p.isDead()) {
        ParticleCount--;
        particles.remove(i);
      }
    }
  }
}


// A Particle class

class SmokeParticle {
  PVector position = new PVector();
  PVector velocity = new PVector();
  PVector acceleration = new PVector();
  PVector negativeX = new PVector(-0.001, 0.001, 0); // rate of acceleration based on each particle's x-acceleration ...
  PVector positiveX = new PVector(0.001, 0.001, 0); //... in order to have it flow BACK to the middle
  PVector negativeZ = new PVector(0, 0.001, -0.001); // rate of acceleration based on each particle's x-acceleration ...
  PVector positiveZ = new PVector(0, 0.001, 0.001); //... in order to have it flow BACK to the middle
  float lifespan;

  SmokeParticle(PVector l) {
    // setting the value is probably more cost effecient than creating new objects
    //l.add(random(-40,40),0,random(-40,40)); // this causes funny things to happen ;)
    
    float mag = .2;
    velocity.set(random(-mag,mag), random(-1.5, -0.2), random(-mag,mag)); // the range of the random factor plays in the size of the fire (x, y) -> (width, height)
    position = l.copy();
    position.add(random(-20,20),-20,random(-20,20));
    lifespan = 360.0;
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
    lifespan -= 1;
  }

  // Method to display
  void display() {
    //strokeWeight(6);
    imageMode(CENTER);
    //blendMode(ADD);

        //fill(#FFFFFF);
    //stroke(255, 255-lifespan, 0, lifespan); // The alpha value decreases as lifespan decreases, giving them the translucent effect.
    pushMatrix();
    tint(#CCCCCC, lifespan/20);
    translate(position.x, position.y, position.z);
    rotateY(radians(random(0,360)));
    int val = int(random(0,16));
    //println(val);
    image(smoke, 0, 0, 15, 15);
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