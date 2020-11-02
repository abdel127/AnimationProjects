/** CSci-4611 Assignment 2:  Car Soccer
 */

#include "car_soccer.h"
#include "config.h"


CarSoccer::CarSoccer() : GraphicsApp(1024,768, "Car Soccer") {
    // Define a search path for finding data files (images and shaders)
    searchPath_.push_back(".");
    searchPath_.push_back("./data");
    searchPath_.push_back(DATA_DIR_INSTALL);
    searchPath_.push_back(DATA_DIR_BUILD);
}

CarSoccer::~CarSoccer() {
}


Vector2 CarSoccer::joystick_direction() {
    Vector2 dir;
    if (IsKeyDown(GLFW_KEY_LEFT))
        dir[0]--;
    if (IsKeyDown(GLFW_KEY_RIGHT))
        dir[0]++;
    if (IsKeyDown(GLFW_KEY_UP))
        dir[1]++;
    if (IsKeyDown(GLFW_KEY_DOWN))
        dir[1]--;
    return dir;
}


void CarSoccer::OnSpecialKeyDown(int key, int scancode, int modifiers) {
    if (key == GLFW_KEY_SPACE) {
        // Here's where you could call some form of launch_ball();
		ball_.Reset();
		car_.Reset();
		car2_.Reset();
    }

	if (key == GLFW_KEY_UP) {
		car_.set_speed(car_.speed() - 1.5);
	}

	else if (key == GLFW_KEY_DOWN) {
		car_.set_speed(car_.speed() + 1.5);
	}

	else if (key == GLFW_KEY_LEFT) {
		car_.set_heading_angle(car_.heading_angle() - 0.02 * car_.speed());
	}

	else if (key == GLFW_KEY_RIGHT) {
		car_.set_heading_angle(car_.heading_angle() + 0.02 * car_.speed());
	}

	if (key == GLFW_KEY_ESCAPE) {
		car2_.set_speed(car2_.speed() - 1.5);
	}

	else if (key == GLFW_KEY_TAB) {
		car2_.set_speed(car2_.speed() + 1.5);
	}

	else if (key == GLFW_KEY_LEFT_CONTROL) {
		car2_.set_heading_angle(car2_.heading_angle() - 0.02 * car2_.speed());
	}

	else if (key == GLFW_KEY_LEFT_ALT) {
		car2_.set_heading_angle(car2_.heading_angle() + 0.02 * car2_.speed());
	}
}


void CarSoccer::UpdateSimulation(double timeStep) {
	// Here's where you shound do your "simulation", updating the positions of the
	// car and ball as needed and checking for collisions.  Filling this routine
	// in is the main part of the assignment.
	ball_.update(timeStep);
	car_.update(timeStep);
	car2_.update(timeStep);
	ball_.collision(car_);
	ball_.collision(car2_);
	//car_.collision(car2_, timeStep);
	//car2_.collision(car_, timeStep);

	// Far goal
	if (ball_.position()[0] <= 10 - ball_.radius() && ball_.position()[0] >= -10 + ball_.radius() && ball_.position()[1] <= 10 - ball_.radius() && ball_.position()[2] <= -50 + ball_.radius()) {
		ball_.Reset();
		car_.Reset();
		car2_.Reset();
	}

	// Near goal
	if (ball_.position()[0] <= 10 - ball_.radius() && ball_.position()[0] >= -10 + ball_.radius() && ball_.position()[1] <= 10 - ball_.radius() && ball_.position()[2] >= 50 - ball_.radius()) {
		ball_.Reset();
		car_.Reset();
		car2_.Reset();
	}

}

void CarSoccer::InitOpenGL() {
    // Set up the camera in a good position to see the entire field
    projMatrix_ = Matrix4::Perspective(60, aspect_ratio(), 1, 1000);
    modelMatrix_ = Matrix4::LookAt(Point3(0,60,70), Point3(0,0,10), Vector3(0,1,0));
 
    // Set a background color for the screen
    glClearColor(0.8,0.8,0.8, 1);
    
    // Load some image files we'll use
    fieldTex_.InitFromFile(Platform::FindFile("pitch.png", searchPath_));
    crowdTex_.InitFromFile(Platform::FindFile("crowd.png", searchPath_));
}


void CarSoccer::DrawUsingOpenGL() {
    // Draw the crowd as a fullscreen background image
    quickShapes_.DrawFullscreenTexture(Color(1,1,1), crowdTex_);
    
    // Draw the field with the field texture on it.
    Color col(16.0/255.0, 46.0/255.0, 9.0/255.0);
    Matrix4 M = Matrix4::Translation(Vector3(0,-0.201,0)) * Matrix4::Scale(Vector3(50, 1, 60));
    quickShapes_.DrawSquare(modelMatrix_ * M, viewMatrix_, projMatrix_, col);
    M = Matrix4::Translation(Vector3(0,-0.2,0)) * Matrix4::Scale(Vector3(40, 1, 50));
    quickShapes_.DrawSquare(modelMatrix_ * M, viewMatrix_, projMatrix_, Color(1,1,1), fieldTex_);
    
	// Draw the car
	Color carcol(0.8, 0.2, 0.2);
	Matrix4 Mcar =
		Matrix4::Translation(car_.position() - Point3(0, 0, 0)) *
		Matrix4::RotationY(car_.heading_angle()) *
		Matrix4::Scale(car_.size()) *
		Matrix4::Scale(Vector3(0.5, 0.5, 0.5));
	quickShapes_.DrawCube(modelMatrix_ * Mcar, viewMatrix_, projMatrix_, carcol);

	// Draw the booster
	Color arrowcol(1.0, 1.0, 0.0);
	Point3 arrowpos = Point3(car_.position()[0], car_.position()[1] + car_.size()[1] / 3.0, car_.position()[2]);
	float mag = sqrt(car_.velocity()[0] * car_.velocity()[0] + car_.velocity()[1] * car_.velocity()[1] + car_.velocity()[2] * car_.velocity()[2]);
	Vector3 arrowdir = Vector3(car_.velocity()[0] / mag, car_.velocity()[1] / mag, car_.velocity()[2] / mag);
	if (car_.speed() > 0) {
		arrowdir = Vector3(arrowdir[0] * -1, arrowdir[1] * -1, arrowdir[2] * -1);
	}
	quickShapes_.DrawArrow(modelMatrix_, viewMatrix_, projMatrix_, arrowcol, arrowpos, arrowdir, 0.5);

	// Draw the car2
	Color car2col(0.2, 0.2, 0.8);
	Matrix4 Mcar2 =
		Matrix4::Translation(car2_.position() - Point3(0, 0, 0)) *
		Matrix4::RotationY(car2_.heading_angle()) *
		Matrix4::Scale(car2_.size()) *
		Matrix4::Scale(Vector3(0.5, 0.5, 0.5));
	quickShapes_.DrawCube(modelMatrix_ * Mcar2, viewMatrix_, projMatrix_, car2col);

	// Draw the booster2
	Color arrow2col(0.0, 1.0, 1.0);
	Point3 arrow2pos = Point3(car2_.position()[0], car2_.position()[1] + car2_.size()[1] / 3.0, car2_.position()[2]);
	float mag2 = sqrt(car2_.velocity()[0] * car2_.velocity()[0] + car2_.velocity()[1] * car2_.velocity()[1] + car2_.velocity()[2] * car2_.velocity()[2]);
	Vector3 arrow2dir = Vector3(car2_.velocity()[0] / mag2, car2_.velocity()[1] / mag2, car2_.velocity()[2] / mag2);
	quickShapes_.DrawArrow(modelMatrix_, viewMatrix_, projMatrix_, arrow2col, arrow2pos, arrow2dir, 0.5);
    
    // Draw the ball
    Color ballcol(1,1,1);
    Matrix4 Mball =
        Matrix4::Translation(ball_.position() - Point3(0,0,0)) *
        Matrix4::Scale(Vector3(ball_.radius(), ball_.radius(), ball_.radius()));
    quickShapes_.DrawSphere(modelMatrix_ * Mball, viewMatrix_, projMatrix_, ballcol);
    
    
    // Draw the ball's shadow -- this is a bit of a hack, scaling Y by zero
    // flattens the sphere into a pancake, which we then draw just a bit
    // above the ground plane.
    Color shadowcol(0.2,0.4,0.15);
    Matrix4 Mshadow =
        Matrix4::Translation(Vector3(ball_.position()[0], -0.1, ball_.position()[2])) *
        Matrix4::Scale(Vector3(ball_.radius(), 0, ball_.radius())) *
        Matrix4::RotationX(90);
    quickShapes_.DrawSphere(modelMatrix_ * Mshadow, viewMatrix_, projMatrix_, shadowcol);
    
    
    // You should add drawing the goals and the boundary of the playing area
    // using quickShapes_.DrawLines()
	
	// Offensive goal and net
	Color offgoalcol(0.2, 0.2, 0.8);
	std::vector<Point3> offpoints;
	offpoints.push_back(Point3(-10.0, 0.0, -50.0));
	offpoints.push_back(Point3(-10.0, 10.0, -50.0));
	offpoints.push_back(Point3(-10.0, 10.0, -50.0));
	offpoints.push_back(Point3(10.0, 10.0, -50.0));
	offpoints.push_back(Point3(10.0, 10.0, -50.0));
	offpoints.push_back(Point3(10.0, 0, -50.0));
	quickShapes_.DrawLines(modelMatrix_, viewMatrix_, projMatrix_, offgoalcol, offpoints, QuickShapes::LinesType::LINES, 0.5);
	std::vector<Point3> offpoints2;
	offpoints2.push_back(Point3(-6.0, 0.0, -50.0));
	offpoints2.push_back(Point3(-6.0, 10.0, -50.0));
	offpoints2.push_back(Point3(-2.0, 0.0, -50.0));
	offpoints2.push_back(Point3(-2.0, 10.0, -50.0));
	offpoints2.push_back(Point3(2.0, 10.0, -50.0));
	offpoints2.push_back(Point3(2.0, 0, -50.0));
	offpoints2.push_back(Point3(6.0, 10.0, -50.0));
	offpoints2.push_back(Point3(6.0, 0, -50.0));
	offpoints2.push_back(Point3(-10.0, 2.5, -50.0));
	offpoints2.push_back(Point3(10.0, 2.5, -50.0));
	offpoints2.push_back(Point3(-10.0, 5.0, -50.0));
	offpoints2.push_back(Point3(10.0, 5.0, -50.0));
	offpoints2.push_back(Point3(-10.0, 7.5, -50.0));
	offpoints2.push_back(Point3(10.0, 7.5, -50.0));
	quickShapes_.DrawLines(modelMatrix_, viewMatrix_, projMatrix_, offgoalcol, offpoints2, QuickShapes::LinesType::LINES, 0.1);

	// Defensive goal and net
	Color defgoalcol(0.8, 0.2, 0.2);
	std::vector<Point3> defpoints;
	defpoints.push_back(Point3(-10.0, 0.0, 50.0));
	defpoints.push_back(Point3(-10.0, 10.0, 50.0));
	defpoints.push_back(Point3(-10.0, 10.0, 50.0));
	defpoints.push_back(Point3(10.0, 10.0, 50.0));
	defpoints.push_back(Point3(10.0, 10.0, 50.0));
	defpoints.push_back(Point3(10.0, 0, 50.0));
	quickShapes_.DrawLines(modelMatrix_, viewMatrix_, projMatrix_, defgoalcol, defpoints, QuickShapes::LinesType::LINES, 0.5);
	std::vector<Point3> defpoints2;
	defpoints2.push_back(Point3(-6.0, 0.0, 50.0));
	defpoints2.push_back(Point3(-6.0, 10.0, 50.0));
	defpoints2.push_back(Point3(-2.0, 0.0, 50.0));
	defpoints2.push_back(Point3(-2.0, 10.0, 50.0));
	defpoints2.push_back(Point3(2.0, 10.0, 50.0));
	defpoints2.push_back(Point3(2.0, 0, 50.0));
	defpoints2.push_back(Point3(6.0, 10.0, 50.0));
	defpoints2.push_back(Point3(6.0, 0, 50.0));
	defpoints2.push_back(Point3(-10.0, 2.5, 50.0));
	defpoints2.push_back(Point3(10.0, 2.5, 50.0));
	defpoints2.push_back(Point3(-10.0, 5.0, 50.0));
	defpoints2.push_back(Point3(10.0, 5.0, 50.0));
	defpoints2.push_back(Point3(-10.0, 7.5, 50.0));
	defpoints2.push_back(Point3(10.0, 7.5, 50.0));
	quickShapes_.DrawLines(modelMatrix_, viewMatrix_, projMatrix_, defgoalcol, defpoints2, QuickShapes::LinesType::LINES, 0.1);

	// Borders of pitch
	Color bordercol(0.7, 0.7, 0.7);
	std::vector<Point3> borderpoints;
	borderpoints.push_back(Point3(-40.0, 0.0, 50.0));
	borderpoints.push_back(Point3(-40.0, 35.0, 50.0));
	borderpoints.push_back(Point3(-40.0, 35.0, 50.0));
	borderpoints.push_back(Point3(-40.0, 35.0, -50.0));
	borderpoints.push_back(Point3(-40.0, 35.0, -50.0));
	borderpoints.push_back(Point3(-40.0, 0.0, -50.0));
	borderpoints.push_back(Point3(-40.0, 35.0, -50.0));
	borderpoints.push_back(Point3(40.0, 35.0, -50.0));
	borderpoints.push_back(Point3(40.0, 35.0, -50.0));
	borderpoints.push_back(Point3(40.0, 0.0, -50.0));
	borderpoints.push_back(Point3(40.0, 35.0, -50.0));
	borderpoints.push_back(Point3(40.0, 35.0, 50.0));
	borderpoints.push_back(Point3(40.0, 35.0, 50.0));
	borderpoints.push_back(Point3(40.0, 0.0, 50.0));
	borderpoints.push_back(Point3(40.0, 35.0, 50.0));
	borderpoints.push_back(Point3(-40.0, 35.0, 50.0));
	quickShapes_.DrawLines(modelMatrix_, viewMatrix_, projMatrix_, bordercol, borderpoints, QuickShapes::LinesType::LINES, 0.3);
}
