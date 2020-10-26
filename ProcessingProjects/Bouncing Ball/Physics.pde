void floorCollision() { //<>//
  final float floor = Y_RES;
  // if under the floor...
  if (yposition + radius > floor) {   
    yposition = floor - radius;
    yvelocity *= -BOUNCENESS; // reduce speed after bouncing
  }
}

// floor collision, but inverse
void ceilingCollision() {
  final float ceiling = Y_RES-X_RES;
  // if above the ceiling...
  if (yposition - radius < 0) {   
    yposition = 0 + radius;
    yvelocity = -yvelocity; // reduce speed after bouncing
  }
}


void xWallCollision() {
  // left wall collision
  if (xposition - radius < 0) {
    xposition = 0 + radius;
    
    // covers if wall is coming in from the right or the left. shared with right wall logic
    if (xvelocity > 0) {
      xvelocity -= BOUNCENESS;
    } else {
      xvelocity += BOUNCENESS;
    }
    xvelocity = -xvelocity + BOUNCENESS;
  }
  // right wall collision
  else if (xposition + radius > X_RES) {
    xposition = X_RES - radius;
    
    // covers if wall is coming in from the right or the left. shared with left wall logic
    if (xvelocity > 0) {
      xvelocity -= BOUNCENESS;
    } else {
      xvelocity += BOUNCENESS;
    }
    xvelocity = -xvelocity - BOUNCENESS;
  }
}

// see left/right wall collision
void yWallCollision() {
  // left wall collision
  if (zposition - radius < (-X_RES)) {
    zposition = -X_RES + radius;
    if (zvelocity > 0) {
      zvelocity -= BOUNCENESS;
    } else {
      zvelocity += BOUNCENESS;
    }
    zvelocity = -(zvelocity + BOUNCENESS);
  } 
  // right wall collision
  else if (zposition + radius > 0) {
    zposition = 0 - radius;
    if (zvelocity > 0) {
      zvelocity -= BOUNCENESS;
    } else {
      zvelocity += BOUNCENESS;
    }
    zvelocity = -(zvelocity - BOUNCENESS);
  }
}

// update the postion based on the sphere's velocities.
void computePhysics(float dt) {
  float acceleration = 9.8;
  yvelocity = yvelocity + acceleration * dt;

  // move the ball
  yposition = yposition + yvelocity * dt;
  xposition = xposition + xvelocity * dt;
  zposition = zposition + zvelocity * dt;
  
  // rotate the ball (only relevant with the texture on)
  xrotation += xvelocity/300;
  yrotation += yvelocity/300;
  zrotation += zvelocity/300;
  
  // debug statements
  println("xvel: ", xvelocity, "yvel: ", yvelocity, "zvel: ", zvelocity);
  println("xpos: ", xposition, "ypos: ", yposition, "zpos: ", zposition);
  println("xrot: ", xrotation, "yrot: ", yrotation, "zrot: ", zrotation);

  // check for collisions (which update velocities)
  floorCollision();
  ceilingCollision();
  xWallCollision();
  yWallCollision();
}