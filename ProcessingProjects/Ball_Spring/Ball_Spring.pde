float floor = height; //<>// //<>// //<>// //<>// //<>// //<>//
float gravity = 10;
ArrayList<Spring> mySprings;
ArrayList<Node> myNodes;
float dt = 0.02f;
int xNodes = 30; // # of nodes in x direction
int yNodes = 30; // # of nodes in y direction
int nSprings = xNodes * (yNodes - 1) + yNodes * (xNodes - 1); // total number of springs
float kVal = 0.1f;
float kDVal = 10;
float relaxedLength = 80;
float radius = 500;
ArrayList<Ball> balls;
PVector ballPos = new PVector(1000, 900, 1000);
float groundHeight = 1500;
int target = 0;

void setup() {
  size (600, 700, P3D);
  G_eyeX = 4500;  //old value = width /2;
  G_eyeY = -700;  //old value = weight / 2;
  G_eyeZ = 2500;  //old value = (height/2.0) / tan(PI*30.0 / 180.0) + 200;
  //camera(4000, -300, (height/2.0) / tan(PI*30.0 / 180.0) + 600, width/2.0, height/2.0 + 400, 0, 0, 1, 0);

  mySprings = new ArrayList<Spring>();
  myNodes = new ArrayList<Node>();
  balls = new ArrayList<Ball>();
  balls.add(new Ball(ballPos, 10, radius, false, 0));
  balls.add(new Ball(addpv(ballPos, new PVector(0,-800,-600)), 5, 300, false, 1));
  balls.add(new Ball(addpv(ballPos, new PVector(1000, 500, 0)), 25, 300, false, 2));
  
  for (int i = 0;i < xNodes*yNodes;i++){ // Creating the Nodes
    if (i % yNodes == 0) myNodes.add(new Node(new PVector(100 * floor(i/yNodes), -200, 100 + (i % yNodes)*75), 1.f, true));
    else myNodes.add(new Node(new PVector(100 * floor(i/yNodes), -200, 100 + (i % yNodes)*75), 1.f, false));
  }
  
  for (int i = 0;i < myNodes.size()/yNodes;i++){
    for (int j = 0;j < yNodes - 1;j++){ // Vertical Springs
      mySprings.add(new Spring(myNodes.get(i*yNodes + j), myNodes.get(i*yNodes + j+1), kVal, kDVal, relaxedLength));
    }
    if (i > 0){
      for (int j = 0;j < yNodes;j++){ // Horizontal Springs
        mySprings.add(new Spring(myNodes.get((i-1)*yNodes + j), myNodes.get(i*yNodes + j), kVal, kDVal, relaxedLength));
      }
    }
  }
}

public void displayBalls(){
  for (int i = 0;i < balls.size();i++){
    balls.get(i).display();
  }
}

void draw() {
  surface.setTitle("Cloth Simulation: " + frameRate);
  background(125);
  lights();
  
  fill(0, 255, 0);
  
  displaySprings();
  displayBalls();
  
  for (int i = 0; i < balls.size();i++){
    balls.get(i).update(dt);
  }
  
  for (Spring spr : mySprings) {
    spr.updateNodes();
  }
  
  for (Node n : myNodes) {
    n.update(dt);
  }
  
  cameraHandler();
}
