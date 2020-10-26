// MY VERSION

class Node {

  PVector acceleration;
  PVector velocity;
  PVector position;
  float mass;
  boolean fixed;
  
  Node(PVector pos, float m, boolean fix) {
    position = pos;
    acceleration = new PVector(0.0, 0.0);
    velocity = new PVector(0.0, 0.0);
    mass = m;
    fixed = fix;
  }
 
  void update(float dt) {
    if (fixed) {return;}
    acceleration.add(new PVector(0.f,gravity));
    velocity.add(acceleration).mult(dt);
    position.add(velocity);
    for(int i = 0;i < balls.size(); i++){
      if (distance(balls.get(i).position,position) < balls.get(i).radius*1.05){
        PVector moveit = subpv(position,ballPos).normalize();
        while(distance(ballPos,position) < radius + 20){
          position.add(moveit);
        }
        acceleration.add(multpv(moveit,100));
        balls.get(i).acceleration.add(multpv(moveit,-1));
      }
    }
  }
  
  void display() {
    
    if (fixed) {
      pushMatrix();
      strokeWeight(5);
      stroke(0, 255, 0);
      point(position.x, position.y, position.z);
      popMatrix();
    }
    else {
      pushMatrix();
      strokeWeight(5);
      stroke(255, 0, 0);
      point(position.x, position.y, position.z);
      popMatrix();
    }
  }

}