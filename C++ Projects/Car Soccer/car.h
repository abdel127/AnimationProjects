/** CSci-4611 Assignment 2:  Car Soccer
 */

#ifndef CAR_H_
#define CAR_H_

#include <mingfx.h>

/// Small data structure for a car
class Car {
public:
    
    /// The constructor sets the static properties of the car, like its size,
    /// and then calls Reset() to reset the position, velocity, and any other
    /// dynamic variables that change during game play.
	Car (int pn) : size_(3, 2, 4), collision_radius_(2.5) {
		player_num_ = pn;
		Reset();
	}

    /// Nothing special needed in the constructor
	virtual ~Car() {}

    /// Resets all the dynamic variables, so if you call this after a goal, the
    /// car will go back to its starting position.
    void Reset() {
        velocity_ = Point3(0, 0, 0);
		speed_ = 0;
		if (player_num_ == 1) {
			position_ = Point3(0, size_[1] / 2, 45);
			heading_angle_ = 0;
		}
		else {
			position_ = Point3(0, size_[1] / 2, -45);
			heading_angle_ = 3.14159;
		}

    }
    
    float collision_radius() { return collision_radius_; }
    
    Vector3 size() { return size_; }
    
    Point3 position() { return position_; }
    void set_position(const Point3 &p) { position_ = p; }

	Point3 velocity() { return velocity_; }
	void set_velocity(const Point3 &v) { velocity_ = v; }

	float speed() { return speed_; }
	void set_speed(const float &s) { speed_ = s; }
	
	float heading_angle() { return heading_angle_; }
	void set_heading_angle(const float &ha) { heading_angle_ = ha; }

	void update(double timeStep) {
		if (speed_ != 0) {
			position_ = Point3(velocity_[0] * timeStep + position_[0], velocity_[1] * timeStep + position_[1], velocity_[2] * timeStep + position_[2]);
			velocity_ = Point3(speed_ * sin(heading_angle_), 0, speed_ * cos(heading_angle_));
		}

		// Keep car in bounds
		if (position_[0] + collision_radius_ >= 40.01) { // Right Wall
			position_ = Point3(40.0 - collision_radius_ - 1.0, position_[1], position_[2]);
			heading_angle_ = -heading_angle_;
		}
		if (position_[0] - collision_radius_ <= -40.01) { // Left Wall
			position_ = Point3(-40.0 + collision_radius_ + 1.0, position_[1], position_[2]);
			heading_angle_ = - heading_angle_;
		}
		if (position_[2] + size_[2] >= 50.01) { // Near Wall
			position_ = Point3(position_[0], position_[1], 50.0 - size_[2] - 1.0);
			heading_angle_ = 3.14159 - heading_angle_;
		}
		if (position_[2] - size_[2] <= -50.01) { // Far Wall
			position_ = Point3(position_[0], position_[1], -50.0 + size_[2] + 1.0);
			heading_angle_ = 3.14159 - heading_angle_;
		}

		// Keeps speed under max_speed_
		if (speed_ >= max_speed_) {
			speed_ = max_speed_;
		}
		if (speed_ <= -max_speed_) {
			speed_ = -max_speed_;
		}
	}
    
private:
    // You will probably need to store some additional data here, e.g., speed.
    
    Vector3 size_;
    float collision_radius_;
    Point3 position_;
	Point3 velocity_;
	float speed_ = 0;
	float heading_angle_;
	float max_speed_ = 30.0;
	int player_num_;
};

#endif
