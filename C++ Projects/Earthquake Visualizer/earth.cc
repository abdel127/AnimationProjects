/** CSci-4611 Assignment 3:  Earthquake
 */

#include "earth.h"
#include "config.h"

#include <vector>

// for M_PI constant
#define _USE_MATH_DEFINES
#include <math.h>


Earth::Earth() {
}

Earth::~Earth() {
}

void Earth::Init(const std::vector<std::string> &search_path) {
    // init shader program
    shader_.Init();
    
    // init texture: you can change to a lower-res texture here if needed
    earth_tex_.InitFromFile(Platform::FindFile("earth-2k.png", search_path));

    // init geometry
    const int nslices = 10;
    const int nstacks = 10;

    // TODO: This is where you need to set the vertices and indiceds for earth_mesh_.

	std::vector<unsigned int> indices;
    std::vector<Point3> vertices;
	std::vector<Point2> texcoords;


    // vertices
	vertices.push_back(Point3(-3.14159, 3.14159 / 2, 0));
	vertices.push_back(Point3(-3.14159 * 4 / 5, 3.14159 / 2, 0));
	vertices.push_back(Point3(-3.14159 * 3 / 5, 3.14159 / 2, 0));
	vertices.push_back(Point3(-3.14159 * 2 / 5, 3.14159 / 2, 0));
	vertices.push_back(Point3(-3.14159 / 5, 3.14159 / 2, 0));
	vertices.push_back(Point3(0, 3.14159 / 2, 0));
	vertices.push_back(Point3(3.14159 / 5, 3.14159 / 2, 0));
	vertices.push_back(Point3(3.14159 * 2 / 5, 3.14159 / 2, 0));
	vertices.push_back(Point3(3.14159 * 3 / 5, 3.14159 / 2, 0));
	vertices.push_back(Point3(3.14159 * 4 / 5, 3.14159 / 2, 0));
	vertices.push_back(Point3(3.14159, 3.14159 / 2, 0));
	vertices.push_back(Point3(-3.14159, 3.14159 * 4 / 5 / 2, 0));
	vertices.push_back(Point3(-3.14159 * 4 / 5, 3.14159 * 4 / 5 / 2, 0));
	vertices.push_back(Point3(-3.14159 * 3 / 5, 3.14159 * 4 / 5 / 2, 0));
	vertices.push_back(Point3(-3.14159 * 2 / 5, 3.14159 * 4 / 5 / 2, 0));
	vertices.push_back(Point3(-3.14159 / 5, 3.14159 * 4 / 5 / 2, 0));
	vertices.push_back(Point3(0, 3.14159 * 4 / 5 / 2, 0));
	vertices.push_back(Point3(3.14159 / 5, 3.14159 * 4 / 5 / 2, 0));
	vertices.push_back(Point3(3.14159 * 2 / 5, 3.14159 * 4 / 5 / 2, 0));
	vertices.push_back(Point3(3.14159 * 3 / 5, 3.14159 * 4 / 5 / 2, 0));
	vertices.push_back(Point3(3.14159 * 4 / 5, 3.14159 * 4 / 5 / 2, 0));
	vertices.push_back(Point3(3.14159, 3.14159 * 4 / 5 / 2, 0));
	vertices.push_back(Point3(-3.14159, 3.14159 * 3 / 5 / 2, 0));
	vertices.push_back(Point3(-3.14159 * 4 / 5, 3.14159 * 3 / 5 / 2, 0));
	vertices.push_back(Point3(-3.14159 * 3 / 5, 3.14159 * 3 / 5 / 2, 0));
	vertices.push_back(Point3(-3.14159 * 2 / 5, 3.14159 * 3 / 5 / 2, 0));
	vertices.push_back(Point3(-3.14159 / 5, 3.14159 * 3 / 5 / 2, 0));
	vertices.push_back(Point3(0, 3.14159 * 3 / 5 / 2, 0));
	vertices.push_back(Point3(3.14159 / 5, 3.14159 * 3 / 5 / 2, 0));
	vertices.push_back(Point3(3.14159 * 2 / 5, 3.14159 * 3 / 5 / 2, 0));
	vertices.push_back(Point3(3.14159 * 3 / 5, 3.14159 * 3 / 5 / 2, 0));
	vertices.push_back(Point3(3.14159 * 4 / 5, 3.14159 * 3 / 5 / 2, 0));
	vertices.push_back(Point3(3.14159, 3.14159 * 3 / 5 / 2, 0));
	vertices.push_back(Point3(-3.14159, 3.14159 * 2 / 5 / 2, 0));
	vertices.push_back(Point3(-3.14159 * 4 / 5, 3.14159 * 2 / 5 / 2, 0));
	vertices.push_back(Point3(-3.14159 * 3 / 5, 3.14159 * 2 / 5 / 2, 0));
	vertices.push_back(Point3(-3.14159 * 2 / 5, 3.14159 * 2 / 5 / 2, 0));
	vertices.push_back(Point3(-3.14159 / 5, 3.14159 * 2 / 5 / 2, 0));
	vertices.push_back(Point3(0, 3.14159 * 2 / 5 / 2, 0));
	vertices.push_back(Point3(3.14159 / 5, 3.14159 * 2 / 5 / 2, 0));
	vertices.push_back(Point3(3.14159 * 2 / 5, 3.14159 * 2 / 5 / 2, 0));
	vertices.push_back(Point3(3.14159 * 3 / 5, 3.14159 * 2 / 5 / 2, 0));
	vertices.push_back(Point3(3.14159 * 4 / 5, 3.14159 * 2 / 5 / 2, 0));
	vertices.push_back(Point3(3.14159, 3.14159 * 2 / 5 / 2, 0));
	vertices.push_back(Point3(-3.14159, 3.14159 * 1 / 5 / 2, 0));
	vertices.push_back(Point3(-3.14159 * 4 / 5, 3.14159 * 1 / 5 / 2, 0));
	vertices.push_back(Point3(-3.14159 * 3 / 5, 3.14159 * 1 / 5 / 2, 0));
	vertices.push_back(Point3(-3.14159 * 2 / 5, 3.14159 * 1 / 5 / 2, 0));
	vertices.push_back(Point3(-3.14159 / 5, 3.14159 * 1 / 5 / 2, 0));
	vertices.push_back(Point3(0, 3.14159 * 1 / 5 / 2, 0));
	vertices.push_back(Point3(3.14159 / 5, 3.14159 * 1 / 5 / 2, 0));
	vertices.push_back(Point3(3.14159 * 2 / 5, 3.14159 * 1 / 5 / 2, 0));
	vertices.push_back(Point3(3.14159 * 3 / 5, 3.14159 * 1 / 5 / 2, 0));
	vertices.push_back(Point3(3.14159 * 4 / 5, 3.14159 * 1 / 5 / 2, 0));
	vertices.push_back(Point3(3.14159, 3.14159 * 1 / 5 / 2, 0));
	vertices.push_back(Point3(-3.14159, 0, 0));
	vertices.push_back(Point3(-3.14159 * 4 / 5, 0, 0));
	vertices.push_back(Point3(-3.14159 * 3 / 5, 0, 0));
	vertices.push_back(Point3(-3.14159 * 2 / 5, 0, 0));
	vertices.push_back(Point3(-3.14159 / 5, 0, 0));
	vertices.push_back(Point3(0, 0, 0));
	vertices.push_back(Point3(3.14159 / 5, 0, 0));
	vertices.push_back(Point3(3.14159 * 2 / 5, 0, 0));
	vertices.push_back(Point3(3.14159 * 3 / 5, 0, 0));
	vertices.push_back(Point3(3.14159 * 4 / 5, 0, 0));
	vertices.push_back(Point3(3.14159, 0, 0));
	vertices.push_back(Point3(-3.14159, -3.14159 * 1 / 5 / 2, 0));
	vertices.push_back(Point3(-3.14159 * 4 / 5, -3.14159 * 1 / 5 / 2, 0));
	vertices.push_back(Point3(-3.14159 * 3 / 5, -3.14159 * 1 / 5 / 2, 0));
	vertices.push_back(Point3(-3.14159 * 2 / 5, -3.14159 * 1 / 5 / 2, 0));
	vertices.push_back(Point3(-3.14159 / 5, -3.14159 * 1 / 5 / 2, 0));
	vertices.push_back(Point3(0, -3.14159 * 1 / 5 / 2, 0));
	vertices.push_back(Point3(3.14159 / 5, -3.14159 * 1 / 5 / 2, 0));
	vertices.push_back(Point3(3.14159 * 2 / 5, -3.14159 * 1 / 5 / 2, 0));
	vertices.push_back(Point3(3.14159 * 3 / 5, -3.14159 * 1 / 5 / 2, 0));
	vertices.push_back(Point3(3.14159 * 4 / 5, -3.14159 * 1 / 5 / 2, 0));
	vertices.push_back(Point3(3.14159, -3.14159 * 1 / 5 / 2, 0));
	vertices.push_back(Point3(-3.14159, -3.14159 * 2 / 5 / 2, 0));
	vertices.push_back(Point3(-3.14159 * 4 / 5, -3.14159 * 2 / 5 / 2, 0));
	vertices.push_back(Point3(-3.14159 * 3 / 5, -3.14159 * 2 / 5 / 2, 0));
	vertices.push_back(Point3(-3.14159 * 2 / 5, -3.14159 * 2 / 5 / 2, 0));
	vertices.push_back(Point3(-3.14159 / 5, -3.14159 * 2 / 5 / 2, 0));
	vertices.push_back(Point3(0, -3.14159 * 2 / 5 / 2, 0));
	vertices.push_back(Point3(3.14159 / 5, -3.14159 * 2 / 5 / 2, 0));
	vertices.push_back(Point3(3.14159 * 2 / 5, -3.14159 * 2 / 5 / 2, 0));
	vertices.push_back(Point3(3.14159 * 3 / 5, -3.14159 * 2 / 5 / 2, 0));
	vertices.push_back(Point3(3.14159 * 4 / 5, -3.14159 * 2 / 5 / 2, 0));
	vertices.push_back(Point3(3.14159, -3.14159 * 2 / 5 / 2, 0));
	vertices.push_back(Point3(-3.14159, -3.14159 * 3 / 5 / 2, 0));
	vertices.push_back(Point3(-3.14159 * 4 / 5, -3.14159 * 3 / 5 / 2, 0));
	vertices.push_back(Point3(-3.14159 * 3 / 5, -3.14159 * 3 / 5 / 2, 0));
	vertices.push_back(Point3(-3.14159 * 2 / 5, -3.14159 * 3 / 5 / 2, 0));
	vertices.push_back(Point3(-3.14159 / 5, -3.14159 * 3 / 5 / 2, 0));
	vertices.push_back(Point3(0, -3.14159 * 3 / 5 / 2, 0));
	vertices.push_back(Point3(3.14159 / 5, -3.14159 * 3 / 5 / 2, 0));
	vertices.push_back(Point3(3.14159 * 2 / 5, -3.14159 * 3 / 5 / 2, 0));
	vertices.push_back(Point3(3.14159 * 3 / 5, -3.14159 * 3 / 5 / 2, 0));
	vertices.push_back(Point3(3.14159 * 4 / 5, -3.14159 * 3 / 5 / 2, 0));
	vertices.push_back(Point3(3.14159, -3.14159 * 3 / 5 / 2, 0));
	vertices.push_back(Point3(-3.14159, -3.14159 * 4 / 5 / 2, 0));
	vertices.push_back(Point3(-3.14159 * 4 / 5, -3.14159 * 4 / 5 / 2, 0));
	vertices.push_back(Point3(-3.14159 * 3 / 5, -3.14159 * 4 / 5 / 2, 0));
	vertices.push_back(Point3(-3.14159 * 2 / 5, -3.14159 * 4 / 5 / 2, 0));
	vertices.push_back(Point3(-3.14159 / 5, -3.14159 * 4 / 5 / 2, 0));
	vertices.push_back(Point3(0, -3.14159 * 4 / 5 / 2, 0));
	vertices.push_back(Point3(3.14159 / 5, -3.14159 * 4 / 5 / 2, 0));
	vertices.push_back(Point3(3.14159 * 2 / 5, -3.14159 * 4 / 5 / 2, 0));
	vertices.push_back(Point3(3.14159 * 3 / 5, -3.14159 * 4 / 5 / 2, 0));
	vertices.push_back(Point3(3.14159 * 4 / 5, -3.14159 * 4 / 5 / 2, 0));
	vertices.push_back(Point3(3.14159, -3.14159 * 4 / 5 / 2, 0));
	vertices.push_back(Point3(-3.14159, -3.14159 / 2, 0));
	vertices.push_back(Point3(-3.14159 * 4 / 5, -3.14159 / 2, 0));
	vertices.push_back(Point3(-3.14159 * 3 / 5, -3.14159 / 2, 0));
	vertices.push_back(Point3(-3.14159 * 2 / 5, -3.14159 / 2, 0));
	vertices.push_back(Point3(-3.14159 / 5, -3.14159 / 2, 0));
	vertices.push_back(Point3(0, -3.14159 / 2, 0));
	vertices.push_back(Point3(3.14159 / 5, -3.14159 / 2, 0));
	vertices.push_back(Point3(3.14159 * 2 / 5, -3.14159 / 2, 0));
	vertices.push_back(Point3(3.14159 * 3 / 5, -3.14159 / 2, 0));
	vertices.push_back(Point3(3.14159 * 4 / 5, -3.14159 / 2, 0));
	vertices.push_back(Point3(3.14159, -3.14159 / 2, 0));


	// Texture coordinates
	texcoords.push_back(Point2(0, 0));
	texcoords.push_back(Point2(1 / 10.0, 0));
	texcoords.push_back(Point2(2 / 10.0, 0));
	texcoords.push_back(Point2(3 / 10.0, 0));
	texcoords.push_back(Point2(4 / 10.0, 0));
	texcoords.push_back(Point2(5 / 10.0, 0));
	texcoords.push_back(Point2(6 / 10.0, 0));
	texcoords.push_back(Point2(7 / 10.0, 0));
	texcoords.push_back(Point2(8 / 10.0, 0));
	texcoords.push_back(Point2(9 / 10.0, 0));
	texcoords.push_back(Point2(1, 0));
	texcoords.push_back(Point2(0, 1 / 10.0));
	texcoords.push_back(Point2(1 / 10.0, 1 / 10.0));
	texcoords.push_back(Point2(2 / 10.0, 1 / 10.0));
	texcoords.push_back(Point2(3 / 10.0, 1 / 10.0));
	texcoords.push_back(Point2(4 / 10.0, 1 / 10.0));
	texcoords.push_back(Point2(5 / 10.0, 1 / 10.0));
	texcoords.push_back(Point2(6 / 10.0, 1 / 10.0));
	texcoords.push_back(Point2(7 / 10.0, 1 / 10.0));
	texcoords.push_back(Point2(8 / 10.0, 1 / 10.0));
	texcoords.push_back(Point2(9 / 10.0, 1 / 10.0));
	texcoords.push_back(Point2(1, 1 / 10.0));
	texcoords.push_back(Point2(0, 2 / 10.0));
	texcoords.push_back(Point2(1 / 10.0, 2 / 10.0));
	texcoords.push_back(Point2(2 / 10.0, 2 / 10.0));
	texcoords.push_back(Point2(3 / 10.0, 2 / 10.0));
	texcoords.push_back(Point2(4 / 10.0, 2 / 10.0));
	texcoords.push_back(Point2(5 / 10.0, 2 / 10.0));
	texcoords.push_back(Point2(6 / 10.0, 2 / 10.0));
	texcoords.push_back(Point2(7 / 10.0, 2 / 10.0));
	texcoords.push_back(Point2(8 / 10.0, 2 / 10.0));
	texcoords.push_back(Point2(9 / 10.0, 2 / 10.0));
	texcoords.push_back(Point2(1, 2 / 10.0));
	texcoords.push_back(Point2(0, 3 / 10.0));
	texcoords.push_back(Point2(1 / 10.0, 3 / 10.0));
	texcoords.push_back(Point2(2 / 10.0, 3 / 10.0));
	texcoords.push_back(Point2(3 / 10.0, 3 / 10.0));
	texcoords.push_back(Point2(4 / 10.0, 3 / 10.0));
	texcoords.push_back(Point2(5 / 10.0, 3 / 10.0));
	texcoords.push_back(Point2(6 / 10.0, 3 / 10.0));
	texcoords.push_back(Point2(7 / 10.0, 3 / 10.0));
	texcoords.push_back(Point2(8 / 10.0, 3 / 10.0));
	texcoords.push_back(Point2(9 / 10.0, 3 / 10.0));
	texcoords.push_back(Point2(1, 3 / 10.0));
	texcoords.push_back(Point2(0, 4 / 10.0));
	texcoords.push_back(Point2(1 / 10.0, 4 / 10.0));
	texcoords.push_back(Point2(2 / 10.0, 4 / 10.0));
	texcoords.push_back(Point2(3 / 10.0, 4 / 10.0));
	texcoords.push_back(Point2(4 / 10.0, 4 / 10.0));
	texcoords.push_back(Point2(5 / 10.0, 4 / 10.0));
	texcoords.push_back(Point2(6 / 10.0, 4 / 10.0));
	texcoords.push_back(Point2(7 / 10.0, 4 / 10.0));
	texcoords.push_back(Point2(8 / 10.0, 4 / 10.0));
	texcoords.push_back(Point2(9 / 10.0, 4 / 10.0));
	texcoords.push_back(Point2(1, 4 / 10.0));
	texcoords.push_back(Point2(0, 5 / 10.0));
	texcoords.push_back(Point2(1 / 10.0, 5 / 10.0));
	texcoords.push_back(Point2(2 / 10.0, 5 / 10.0));
	texcoords.push_back(Point2(3 / 10.0, 5 / 10.0));
	texcoords.push_back(Point2(4 / 10.0, 5 / 10.0));
	texcoords.push_back(Point2(5 / 10.0, 5 / 10.0));
	texcoords.push_back(Point2(6 / 10.0, 5 / 10.0));
	texcoords.push_back(Point2(7 / 10.0, 5 / 10.0));
	texcoords.push_back(Point2(8 / 10.0, 5 / 10.0));
	texcoords.push_back(Point2(9 / 10.0, 5 / 10.0));
	texcoords.push_back(Point2(1, 5 / 10.0));
	texcoords.push_back(Point2(0, 6 / 10.0));
	texcoords.push_back(Point2(1 / 10.0, 6 / 10.0));
	texcoords.push_back(Point2(2 / 10.0, 6 / 10.0));
	texcoords.push_back(Point2(3 / 10.0, 6 / 10.0));
	texcoords.push_back(Point2(4 / 10.0, 6 / 10.0));
	texcoords.push_back(Point2(5 / 10.0, 6 / 10.0));
	texcoords.push_back(Point2(6 / 10.0, 6 / 10.0));
	texcoords.push_back(Point2(7 / 10.0, 6 / 10.0));
	texcoords.push_back(Point2(8 / 10.0, 6 / 10.0));
	texcoords.push_back(Point2(9 / 10.0, 6 / 10.0));
	texcoords.push_back(Point2(1, 6 / 10.0));
	texcoords.push_back(Point2(0, 7 / 10.0));
	texcoords.push_back(Point2(1 / 10.0, 7 / 10.0));
	texcoords.push_back(Point2(2 / 10.0, 7 / 10.0));
	texcoords.push_back(Point2(3 / 10.0, 7 / 10.0));
	texcoords.push_back(Point2(4 / 10.0, 7 / 10.0));
	texcoords.push_back(Point2(5 / 10.0, 7 / 10.0));
	texcoords.push_back(Point2(6 / 10.0, 7 / 10.0));
	texcoords.push_back(Point2(7 / 10.0, 7 / 10.0));
	texcoords.push_back(Point2(8 / 10.0, 7 / 10.0));
	texcoords.push_back(Point2(9 / 10.0, 7 / 10.0));
	texcoords.push_back(Point2(1, 7 / 10.0));
	texcoords.push_back(Point2(0, 8 / 10.0));
	texcoords.push_back(Point2(1 / 10.0, 8 / 10.0));
	texcoords.push_back(Point2(2 / 10.0, 8 / 10.0));
	texcoords.push_back(Point2(3 / 10.0, 8 / 10.0));
	texcoords.push_back(Point2(4 / 10.0, 8 / 10.0));
	texcoords.push_back(Point2(5 / 10.0, 8 / 10.0));
	texcoords.push_back(Point2(6 / 10.0, 8 / 10.0));
	texcoords.push_back(Point2(7 / 10.0, 8 / 10.0));
	texcoords.push_back(Point2(8 / 10.0, 8 / 10.0));
	texcoords.push_back(Point2(9 / 10.0, 8 / 10.0));
	texcoords.push_back(Point2(1, 8 / 10.0));
	texcoords.push_back(Point2(0, 9 / 10.0));
	texcoords.push_back(Point2(1 / 10.0, 9 / 10.0));
	texcoords.push_back(Point2(2 / 10.0, 9 / 10.0));
	texcoords.push_back(Point2(3 / 10.0, 9 / 10.0));
	texcoords.push_back(Point2(4 / 10.0, 9 / 10.0));
	texcoords.push_back(Point2(5 / 10.0, 9 / 10.0));
	texcoords.push_back(Point2(6 / 10.0, 9 / 10.0));
	texcoords.push_back(Point2(7 / 10.0, 9 / 10.0));
	texcoords.push_back(Point2(8 / 10.0, 9 / 10.0));
	texcoords.push_back(Point2(9 / 10.0, 9 / 10.0));
	texcoords.push_back(Point2(1, 9 / 10.0));
	texcoords.push_back(Point2(0, 1));
	texcoords.push_back(Point2(1 / 10.0, 1));
	texcoords.push_back(Point2(2 / 10.0, 1));
	texcoords.push_back(Point2(3 / 10.0, 1));
	texcoords.push_back(Point2(4 / 10.0, 1));
	texcoords.push_back(Point2(5 / 10.0, 1));
	texcoords.push_back(Point2(6 / 10.0, 1));
	texcoords.push_back(Point2(7 / 10.0, 1));
	texcoords.push_back(Point2(8 / 10.0, 1));
	texcoords.push_back(Point2(9 / 10.0, 1));
	texcoords.push_back(Point2(1, 1));


	// loop to push back indices into the arrays above for the triangles
	for (int i = 0; i <= 9; i++) {
		indices.push_back(i);
		indices.push_back(i+11);
		indices.push_back(i+12);

		indices.push_back(i);
		indices.push_back(i+12);
		indices.push_back(i+1);
	}

	for (int i = 11; i <= 20; i++) {
		indices.push_back(i);
		indices.push_back(i + 11);
		indices.push_back(i + 12);

		indices.push_back(i);
		indices.push_back(i + 12);
		indices.push_back(i + 1);
	}

	for (int i = 22; i <= 31; i++) {
		indices.push_back(i);
		indices.push_back(i + 11);
		indices.push_back(i + 12);

		indices.push_back(i);
		indices.push_back(i + 12);
		indices.push_back(i + 1);
	}

	for (int i = 33; i <= 42; i++) {
		indices.push_back(i);
		indices.push_back(i + 11);
		indices.push_back(i + 12);

		indices.push_back(i);
		indices.push_back(i + 12);
		indices.push_back(i + 1);
	}

	for (int i = 44; i <= 53; i++) {
		indices.push_back(i);
		indices.push_back(i + 11);
		indices.push_back(i + 12);

		indices.push_back(i);
		indices.push_back(i + 12);
		indices.push_back(i + 1);
	}

	for (int i = 55; i <= 64; i++) {
		indices.push_back(i);
		indices.push_back(i + 11);
		indices.push_back(i + 12);

		indices.push_back(i);
		indices.push_back(i + 12);
		indices.push_back(i + 1);
	}

	for (int i = 66; i <= 75; i++) {
		indices.push_back(i);
		indices.push_back(i + 11);
		indices.push_back(i + 12);

		indices.push_back(i);
		indices.push_back(i + 12);
		indices.push_back(i + 1);
	}

	for (int i = 77; i <= 86; i++) {
		indices.push_back(i);
		indices.push_back(i + 11);
		indices.push_back(i + 12);

		indices.push_back(i);
		indices.push_back(i + 12);
		indices.push_back(i + 1);
	}

	for (int i = 88; i <= 97; i++) {
		indices.push_back(i);
		indices.push_back(i + 11);
		indices.push_back(i + 12);

		indices.push_back(i);
		indices.push_back(i + 12);
		indices.push_back(i + 1);
	}

	for (int i = 99; i <= 108; i++) {
		indices.push_back(i);
		indices.push_back(i + 11);
		indices.push_back(i + 12);

		indices.push_back(i);
		indices.push_back(i + 12);
		indices.push_back(i + 1);
	}


    earth_mesh_.SetVertices(vertices);
	earth_mesh_.SetTexCoords(0, texcoords);
    earth_mesh_.SetIndices(indices);
    earth_mesh_.UpdateGPUMemory();
}



void Earth::Draw(const Matrix4 &model_matrix, const Matrix4 &view_matrix, const Matrix4 &proj_matrix) {
    // Define a really bright white light.  Lighting is a property of the "shader"
    DefaultShader::LightProperties light;
    light.position = Point3(10,10,10);
    light.ambient_intensity = Color(1,1,1);
    light.diffuse_intensity = Color(1,1,1);
    light.specular_intensity = Color(1,1,1);
    shader_.SetLight(0, light);

    // Adust the material properties, material is a property of the thing
    // (e.g., a mesh) that we draw with the shader.  The reflectance properties
    // affect the lighting.  The surface texture is the key for getting the
    // image of the earth to show up.
    DefaultShader::MaterialProperties mat;
    mat.ambient_reflectance = Color(0.5, 0.5, 0.5);
    mat.diffuse_reflectance = Color(0.75, 0.75, 0.75);
    mat.specular_reflectance = Color(0.75, 0.75, 0.75);
    mat.surface_texture = earth_tex_;

    // Draw the earth mesh using these settings
    if (earth_mesh_.num_triangles() > 0) {
        shader_.Draw(model_matrix, view_matrix, proj_matrix, &earth_mesh_, mat);
    }
}


Point3 Earth::LatLongToSphere(double latitude, double longitude) const {
    // TODO: We recommend filling in this function to put all your
    // lat,long --> sphere calculations in one place.
    return Point3(0,0,0);
}

Point3 Earth::LatLongToPlane(double latitude, double longitude) const {
    // TODO: We recommend filling in this function to put all your
    // lat,long --> plane calculations in one place.
    return Point3(0,0,0);
}



void Earth::DrawDebugInfo(const Matrix4 &model_matrix, const Matrix4 &view_matrix, const Matrix4 &proj_matrix) {
    // This draws a cylinder for each line segment on each edge of each triangle in your mesh.
    // So it will be very slow if you have a large mesh, but it's quite useful when you are
    // debugging your mesh code, especially if you start with a small mesh.
    for (int t=0; t<earth_mesh_.num_triangles(); t++) {
        std::vector<unsigned int> indices = earth_mesh_.triangle_vertices(t);
        std::vector<Point3> loop;
        loop.push_back(earth_mesh_.vertex(indices[0]));
        loop.push_back(earth_mesh_.vertex(indices[1]));
        loop.push_back(earth_mesh_.vertex(indices[2]));
        quick_shapes_.DrawLines(model_matrix, view_matrix, proj_matrix,
            Color(1,1,0), loop, QuickShapes::LinesType::LINE_LOOP, 0.005);
    }
}

