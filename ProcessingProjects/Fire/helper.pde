// weird naming convention. The camera "eye's" postion.
float G_eyeX, G_eyeY, G_eyeZ;

// drag around the moouse left/right to change the x/z coordinates of the camera
// similarly up/down for y
void cameraHandler() {
  if (mousePressed) {
    G_eyeX += pmouseX - mouseX;
    G_eyeY += pmouseY - mouseY;
  }
  float offset = width/2;
  
  // x is the distance around the circle
  // z is the zoom on the camera (and part of the circle)
  float eyeX =offset + cos(radians(G_eyeX)) * G_eyeZ,
    eyeY = G_eyeY * 2,
    eyeZ = sin(radians(G_eyeX)) * G_eyeZ,
    centerX = width/2.0,
    centerY = height/2.0,
    centerZ = 0;
  
  camera(eyeX, eyeY, eyeZ, 
    centerX, centerY, centerZ, 
    0, 1, 0);
}

void drawFloor(color c) {
  noStroke();
  fill(c);
  pushMatrix();
  translate(width/2, height/2, 0);
  box(width, 5, width);
  popMatrix();
}