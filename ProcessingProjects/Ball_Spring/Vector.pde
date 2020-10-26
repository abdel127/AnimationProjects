// MY VERSION

class vector{
  float x, y, z;
  
  vector(float x_, float y_, float z_){
    x = x_;
    y = y_;
    z = z_;
  }
  
  vector(float x_, float y_){
    x = x_;
    y = y_;
    z = 0;
  }
  
}

vector addv(vector a, vector b){
  return new vector(a.x + b.x, a.y + b.y, a.z + b.z);
}

vector subv(vector a, vector b){
  return new vector(a.x - b.x, a.y - b.y, a.z - b.z);
}

vector multv(vector a, vector b){
  return new vector(a.x * b.x, a.y * b.y, a.z * b.z);
}

PVector addpv(PVector a, PVector b){
  return new PVector(a.x + b.x, a.y + b.y, a.z + b.z);
}

PVector subpv(PVector a, PVector b){
  return new PVector(a.x - b.x, a.y - b.y, a.z - b.z);
}

float dotpv(PVector a, PVector b){
  return a.x * b.x + a.y * b.y + a.z * b.z;
}

PVector multpv(PVector a, float b){
  return new PVector(a.x * b, a.y * b, a.z * b);
}

float distance(PVector a, PVector b){
  return sqrt(sq(a.x - b.x) + sq(a.y - b.y) + sq(a.z - b.z));
}