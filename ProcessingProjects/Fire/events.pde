// causes zoomin when you use the mouse wheel
void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  G_eyeZ += e * 50;
  //println(cam.getRotations());
}