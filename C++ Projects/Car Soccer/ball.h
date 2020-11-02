/** CSci-4611 Assignment 2:  Car Soccer
 */

#ifndef BALL_H_
#define BALL_H_

#include <mingfx.h>;
#include "car.h";

/// Small data structure for a ball
class Ball {
public:
    
    /// The constructor sets the radius and calls Reset() to start the ball at
    /// the center of the field
    Ball() : radius_(2.0) {
        Reset();
    }
    
    /// Nothing special needed in the constructor
    virtual ~Ball() {
		velocity_ = Point3(2, 0, 2);
	}

    
    void Reset() {
        position_ = Point3(0, radius_, 0);
		velocity_ = Point3(rand() % 40 - 20.0, rand() % 20, rand() % 40 - 20.0);
    }

    float radius() { return radius_; }
    
	Point3 position() { return position_; }
	void set_position(const Point3 &p) { position_ = p; }

	Point3 velocity() { return velocity_; }
	void set_velocity(const Point3 &v) { velocity_ = v; }

	void update(double timeStep) { 
		position_ = Point3(velocity_[0] * timeStep + position_[0], velocity_[1] * timeStep + position_[1], velocity_[2] * timeStep + position_[2]);
		velocity_ = Point3(velocity_[0], velocity_[1] - 0.05, velocity_[2]);

		// Keep ball in bounds
		if (position_[1] - radius_ <= -0.01) { // Floor
			position_ = Point3(position_[0], radius_, position_[2]);
			velocity_ = Point3(velocity_[0], -velocity_[1] - 2.0, velocity_[2]);
		}
		if (position_[1] + radius_ >= 35.01) { // Ceiling
			position_ = Point3(position_[0], 35.0 - radius_, position_[2]);
			velocity_ = Point3(velocity_[0], -velocity_[1] - 2.0, velocity_[2]);
		}
		if (position_[0] + radius_ >= 40.01) { // Right Wall
			position_ = Point3(40.0 - radius_, position_[1], position_[2]);
			velocity_ = Point3(-(velocity_[0] - 2.0), velocity_[1], velocity_[2]);
		}
		if (position_[0] - radius_ <= -40.01) { // Left Wall
			position_ = Point3(-40.0 + radius_, position_[1], position_[2]);
			velocity_ = Point3(-velocity_[0] - 2.0, velocity_[1], velocity_[2]);
		}
		if (position_[2] + radius_ >= 50.01) { // Near Wall
			position_ = Point3(position_[0], position_[1], 50.0 - radius_);
			velocity_ = Point3(velocity_[0], velocity_[1], -(velocity_[2] - 2.0));
		}
		if (position_[2] - radius_ <= -50.01) { // Far Wall
			position_ = Point3(position_[0], position_[1], -50.0 + radius_);
			velocity_ = Point3(velocity_[0], velocity_[1], -velocity_[2] - 2.0);
		}

		// Keeps velocity under max_speed_;
		if (velocity_[0] >= max_speed_) {
			velocity_[0] = max_speed_;
		}
		if (velocity_[0] <= -max_speed_) {
			velocity_[0] = -max_speed_;
		}
		if (velocity_[1] >= max_speed_) {
			velocity_[1] = max_speed_;
		}
		if (velocity_[1] <= -max_speed_) {
			velocity_[1] = -max_speed_;
		}
		if (velocity_[2] >= max_speed_) {
			velocity_[2] = max_speed_;
		}
		if (velocity_[2] <= -max_speed_) {
			velocity_[2] = -max_speed_;
		}

	}
    
	// Handel car collision
	void collision(Car c) {
		if (radius_ + c.collision_radius() >= sqrt((position_[0] - c.position()[0]) * (position_[0] - c.position()[0]) + (position_[1] - c.position()[1]) * (position_[1] - c.position()[1]) + (position_[2] - c.position()[2]) * (position_[2] - c.position()[2]))) {

			Point3 vector = Point3(position_[0] - c.position()[0], position_[1] - c.position()[1], position_[2] - c.position()[2]);
			float magnitude = sqrt(vector[0] * vector[0] + vector[1] * vector[1] + vector[2] * vector[2]);
			Point3 unitvec = Point3(vector[0] / magnitude, vector[1] / magnitude, vector[2] / magnitude);
			Point3 relvel = Point3(velocity_[0] - c.velocity()[0], velocity_[1] - c.velocity()[1], velocity_[2] - c.velocity()[2]);
			Point3 reflected = Point3(-(2 * (dot(unitvec, relvel))) * unitvec[0] - relvel[0], -(2 * (dot(unitvec, relvel))) * unitvec[1] - relvel[1], -(2 * (dot(unitvec, relvel))) * unitvec[1] - relvel[1]);
			velocity_ = Point3(reflected[0] + c.velocity()[0], reflected[1] + c.velocity()[1], reflected[2] + c.velocity()[2]);

		}
		
	}

	float dot(Point3 p1, Point3 p2) {
		return (p1[0] * p2[0] + p1[1] * p2[1] + p1[2] * p2[2]);
	}
    
private:
    // You will probably need to store some additional data here, e.g., velocity
    
    Point3 position_;
	Point3 velocity_ = Point3(rand() % 40 - 20.0, rand() % 20, rand() % 40 - 20.0);
	float max_speed_ = 25;
    float radius_;
};

#endif
