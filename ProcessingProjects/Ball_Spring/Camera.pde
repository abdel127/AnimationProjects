
// weird naming convention. The camera "eye's" postion.
float G_eyeX, G_eyeY, G_eyeZ;
boolean forwards = false, backwards = false, right = false, left = false;

// drag around the moouse left/right to change the x/z coordinates of the camera
// similarly up/down for y
void cameraHandler() {
  if (mousePressed) {
    G_eyeX += pmouseX - mouseX;
    G_eyeY += (pmouseY - mouseY) * 4.0;
  }
  float offset = width/2;
  
  // x is the distance around the circle
  // z is the zoom on the camera (and part of the circle)

  float eyeX =offset + cos(radians(G_eyeX)) * G_eyeZ,
    eyeY = G_eyeY * 2,
    eyeZ = sin(radians(G_eyeX)) * G_eyeZ,
    centerX = 700,
    centerY = 400,
    centerZ = 500;
  
  camera(eyeX, eyeY, eyeZ, 
    centerX, centerY, centerZ, 
    0, 1, 0);
}
void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  G_eyeZ += e * 50;
}

void keyPressed(){
  if (key == 'd'){
    right = true;
  } else if (key == 'a') {
    left = true;
  } else if (key == 's'){
    backwards = true;
  } else if (key == 'w'){
    forwards = true;
  } else if (key == 'c'){
    target = (target+1)%balls.size();
  }
}

void keyReleased(){
  if (key == 'd'){
    right = false;
  } else if (key == 'a') {
    left = false;
  } else if (key == 's'){
    backwards = false;
  } else if (key == 'w'){
    forwards = false;
  }
}

PVector getChange(){
  PVector change = new PVector(0,0,0);
  if (forwards == true) change.x += 1;
  if (backwards == true) change.x -= 1;
  if (right == true) change.z += 1;
  if (left == true) change.z -= 1;
  return change;
}