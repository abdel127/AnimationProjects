class Ball {

  PVector acceleration;
  PVector velocity;
  PVector position;
  PVector c = new PVector(0,0,255);
  float mass;
  boolean fixed;
  float radius;
  int id;
  
  Ball(PVector pos, float m, float r, boolean fix, int id_) {
    position = pos;
    acceleration = new PVector(0.0, 0.0);
    velocity = new PVector(0.0, 0.0);
    mass = m;
    fixed = fix;
    radius = r;
    id = id_;
  }
 
  void update(float dt) {
    if (fixed) {return;}
    if (target != id){
      c = new PVector(0,0,255);
    } else {
      c = new PVector(255,0,0);
      acceleration.add(multpv(getChange(),30));
    }
    for (int i = 0;i < balls.size();i++){
      if (position != balls.get(i).position && distance(position,balls.get(i).position) < radius + balls.get(i).radius){
        PVector direction = subpv(balls.get(i).position, position);
        balls.get(i).acceleration.add(multpv(direction.normalize(),1/direction.mag()));
        acceleration.add(multpv(direction.normalize(),-50/direction.mag()));
      }
    }
    acceleration.add(new PVector(0.f,gravity));
    velocity.add(acceleration).mult(dt);
    position.add(velocity);

    if(position.y + radius >= groundHeight){
      acceleration.y = acceleration.y * -1;
      position.y = groundHeight - 0.01 - radius;
    }
  }
  
  void display() {
    pushMatrix();
    noStroke();
    fill(c.x, c.y, c.z);
    translate(position.x, position.y, position.z);
    sphere(radius);
    popMatrix();
  }

}