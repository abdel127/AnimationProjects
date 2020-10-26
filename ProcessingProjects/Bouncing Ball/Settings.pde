// global variables. it's like a settings page

final String TITLE = "Bouncing Ball";
final int X_RES = 640, Y_RES = 480;
final float BOUNCENESS = 0.75; // how 'heavy' the object is

final float radius = 40;

// ball's values
float xposition = 300;
float yposition = 200;
float zposition = -Y_RES/2;

float xvelocity = 10;
float yvelocity = 0;
float zvelocity = -10;

float xrotation = 0;
float yrotation = 0;
float zrotation = 0;

// width/2.0, height/2.0, (height/2.0) / tan(PI*30.0 / 180.0), 
// width/2.0, height/2.0, 0, 0, 1, 0)

//camera(width/2.0, height/2.0, (height/2.0) / tan(PI*30.0 / 180.0), 
//       width/2.0, height/2.0, 0, 
//       0, 1, 0);

// default camera settings
float eye_x, eye_y, eye_z;
float cam_center_x, cam_center_y, cam_center_z;