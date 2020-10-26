class Spring {
  Node left, right;
  float restLength;
  float k, kd;

  // Anchor
  Spring(Node l, Node r, float k_, float kd_, float rest) {
    left = l;
    right = r;
    k = k_;
    kd = kd_;
    restLength = rest;
  }

  void display() {
    pushMatrix();
    strokeWeight(1);
    if (mySprings.get(77) == this || mySprings.get(116) == this || mySprings.get(58) == this) {stroke (255);}
    else {stroke(0);}
    line(left.position.x, left.position.y, left.position.z, right.position.x, right.position.y, right.position.z);
    popMatrix();
  }

  void updateNodes() {
    float currentLength = dist(left.position.x, left.position.y, left.position.z, right.position.x, right.position.y, right.position.z);
    float f = -(1/k)*(currentLength - restLength);
    PVector forceDir = multpv(subpv(right.position,left.position),f/currentLength);
    PVector dampDir = multpv(subpv(right.velocity,left.velocity),-kd);
    
    left.acceleration.sub(addpv(multpv(forceDir,1/left.mass),dampDir));
    right.acceleration.add(addpv(multpv(forceDir,1/right.mass),dampDir));
  }
  
  PVector cross(Spring sp) { // Attempt at getting the normal vector between two springs
    PVector pv;
    
    PVector temp1 = left.position, temp2 = right.position, temp3 = sp.left.position;
    pv = (subpv(temp1, temp2).cross(subpv(temp1, temp3)));
    
    return pv;
  }
}

void displaySprings() {
  for (int i = 0; i<yNodes-1; i++){ // The left most column of boxes
      float v1X = mySprings.get(i).left.position.x;
      float v1Y = mySprings.get(i).left.position.y;
      float v1Z = mySprings.get(i).left.position.z;
      float v2X = mySprings.get(i+yNodes-1).left.position.x;
      float v2Y = mySprings.get(i+yNodes-1).left.position.y;
      float v2Z = mySprings.get(i+yNodes-1).left.position.z;
      float v3X = mySprings.get(i+yNodes-1).right.position.x;
      float v3Y = mySprings.get(i+yNodes-1).right.position.y;
      float v3Z = mySprings.get(i+yNodes-1).right.position.z;
      float v4X = mySprings.get(i).right.position.x;
      float v4Y = mySprings.get(i).right.position.y;
      float v4Z = mySprings.get(i).right.position.z;
      
      beginShape();
      if ((i+yNodes-1) % 3 == 0) {fill(#AF7932);}
      else if ((i+yNodes-1) % 3 == 1) {fill(#FFB048);}
      else {fill(#D3923C);}
      PVector norm = mySprings.get(i).cross(mySprings.get(i+38));
      // normal(norm.x, norm.y, norm.z);
      vertex(v1X, v1Y, v1Z);
      vertex(v2X, v2Y, v2Z);
      vertex(v3X, v3Y, v3Z);
      vertex(v4X, v4Y, v4Z);
      endShape();
  }
  
  for (int j = yNodes-1; j < yNodes*2-1; j++) { // The rest of the cloth
    for (int i = j; i < sq(xNodes - 1) * 2 - (xNodes +1); i += yNodes*2-1) { 
      float v1X = mySprings.get(i).left.position.x;
      float v1Y = mySprings.get(i).left.position.y;
      float v1Z = mySprings.get(i).left.position.z;
      float v2X = mySprings.get(i+yNodes*2-1).left.position.x;
      float v2Y = mySprings.get(i+yNodes*2-1).left.position.y;
      float v2Z = mySprings.get(i+yNodes*2-1).left.position.z;
      float v3X = mySprings.get(i+yNodes*2-1).right.position.x;
      float v3Y = mySprings.get(i+yNodes*2-1).right.position.y;
      float v3Z = mySprings.get(i+yNodes*2-1).right.position.z;
      float v4X = mySprings.get(i).right.position.x;
      float v4Y = mySprings.get(i).right.position.y;
      float v4Z = mySprings.get(i).right.position.z;
      
      beginShape();
      if (j % 3 == 0) {fill(#AF7932);}
      else if (j % 3 == 1) {fill(#FFB048);}
      else {fill(#D3923C);}
      PVector norm = mySprings.get(i).cross(mySprings.get(i+58));
      //normal(norm.x, norm.y, norm.z);
      vertex(v1X, v1Y, v1Z);
      vertex(v2X, v2Y, v2Z);
      vertex(v3X, v3Y, v3Z);
      vertex(v4X, v4Y, v4Z);
      endShape();
    }
  }
}