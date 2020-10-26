// texture object
PImage img;
// object to paply texture to
PShape ball;

void setup() { 
  size(640, 480, P3D);
  xvelocity = random(-20,20);
  //yvelocity = random(-20,20);
  //zvelocity = random(-20,20);
  //frameRate(5);
  //ortho();
  textFont(loadFont("DejaVuSansMono-18.vlw"));
  
  // setup shape with a texture
  img = loadImage("BasketballColor.jpg");
  ball = createShape(SPHERE, 50);
  ball.setTexture(img);
  ball.setStrokeWeight(0);
  
  // set defualt camera values
  eye_x = width/2.0;
  eye_y = height/2.0;
  eye_z = (height/2.0) / tan(PI*30.0 / 180.0);
  cam_center_x = width/2.0;
  cam_center_y = height/2.0;
  cam_center_z = 0;
  //fullScreen(P3D);
  
  perspective(PI/3, (float)width/height, 0.01, 10000); // sets min/max distance 
}

void drawSphere() {
  pushMatrix(); // needed so you don't mess up rotations of other 3d objects
  //fill(0,200,10); // color the sphere
  
  noStroke(); // turns off sphere verticies
  translate(xposition,yposition,zposition);
  
  rotateX(-zrotation); // rotate so it 'rolls' (it kinda works)
  rotateZ(xrotation);
  
  shape(ball); // actually draw the ball
  popMatrix(); 
}

void drawWalls() {
  // left wall
  pushMatrix();
  fill(#ED6E6E);
  translate(0, Y_RES/2, -X_RES/2);
  rotateY(radians(90));
  box(X_RES,X_RES,0);
  popMatrix();
  
  // right wall
  pushMatrix();
  fill(#AFED6E);
  translate(X_RES, Y_RES/2, -X_RES/2);
  rotateY(radians(90));
  box(X_RES,X_RES,0);
  popMatrix();
  
  //ceiling
  pushMatrix();
  fill(#706EED);
  translate(X_RES/2, 0, -X_RES/2);
  rotateX(radians(90));
  box(X_RES,X_RES,0);
  popMatrix();
  
  // floor
  pushMatrix();
  fill(#EDC36E);
  translate(X_RES/2, Y_RES, -X_RES/2);
  rotateX(radians(90));
  box(X_RES,X_RES,0);
  popMatrix();
  
  // back wall
  pushMatrix();
  fill(#E46EED);
  translate(X_RES/2, Y_RES/2, -X_RES);
  box(X_RES,X_RES,0);
  popMatrix();
}

// unused function: used this if you don't want to use the draw walls function
void drawFloor() {
  pushMatrix();
  fill(#D1D1D1);
  translate(X_RES/2, Y_RES, -X_RES/2);
  rotateX(radians(90));
  box(X_RES,X_RES,0);
  popMatrix();
}

// draw a circle under the ball's postiion
void drawShadow() {
  pushMatrix();
  fill(0,0,0,180);
  translate(xposition,Y_RES-3,zposition); //-3 so it's just above the floor
  rotateX(radians(90));
  ellipse(0,0,radius*2,radius*2); // 2d shapes work too!
  popMatrix();
}

// a debugging function that draws some values on the screen
void showtext() {
  text("xpos: " + nf(xposition,0,3), 5,24);
  text("ypos: " + nf(yposition,0,3), 5,24*2);
  text("zpos: " + nf(zposition,0,3), 5,24*3);
  text("xvel: " + (xvelocity), 5,24*4);
  text("yvel: " + (yvelocity), 5,24*5);
  text("zvel: " + (zvelocity), 5,24*6);
}

void draw() {
  // this is the default camera settings
  camera(eye_x, eye_y, eye_z, 
      cam_center_x, cam_center_y, cam_center_z, 
      0, 1, 0);
      
  // show frame rate in title bar
  frame.setTitle(TITLE + ": " + int(frameRate) + " fps");
  background(#B0CAE5);
  fill(#000000, 255);
  //showtext();
 
  computePhysics(0.15); // updates accel, pos, etc
  lights();
  drawSphere();
  //drawFloor();
  drawShadow();
  drawWalls();
  cameraMovement();
}

// experimental code
void cameraMovement() {
  if (keyPressed) {
    float val = 5;
    println("Keycode:", keyCode);
    char input = key;
    int d = keyCode;
    if (keyCode == UP || key == 'w' || key == 'W') {
        cam_center_z -= val;
        eye_z -= val;
    }
    else if (keyCode == DOWN || key == 's' || key == 'S') {
        cam_center_z += val;
        eye_z += val;
    }
    else if (keyCode == LEFT || key == 'a' || key == 'A') {
        cam_center_x -= val;
        eye_x -= val;
    }
    else if (keyCode == RIGHT || key == 'd' || key == 'D') {
        cam_center_x += val;
        eye_x += val;
    }
  }
}

void mouseClicked() {
  // this old code would reset the position of the ball to the center
  //xposition = 300; 
  //yposition = 200;
  //zposition = -Y_RES/2;
  
  // give the ball some random velocities to make it go around more chaotically
  yvelocity = 0; // reset's gravity's effects
  xvelocity += random(-20,20);
  yvelocity += random(-100,0);
  zvelocity += random(-20,20); 
}

void keyPressed() {
  if (key == 'r') {
    xposition = 300;
    yposition = 200;
    zposition = -Y_RES/2;
    xvelocity = random(-20,20);
    yvelocity = random(-20,20);
    zvelocity = random(-20,20);
  }
}
