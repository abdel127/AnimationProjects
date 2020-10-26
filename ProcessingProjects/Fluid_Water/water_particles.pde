class water_particles {
 
  int n_particles = 333;
  float dx = 3.003;
  float g = 0.1;
  float damp = 0.08;
  
  float[] h = new float[n_particles]; // height vectors
  float[] uh = new float[n_particles]; // momentum vectors
  
  float[] hm = new float[n_particles]; // midpoint height vectors
  float[] uhm = new float[n_particles]; // midpoint momentum vectors
  
  float total_len = n_particles * dx;
  
  water_particles(int origin) {
    for (int i = 0; i < n_particles; i++) {
      h[i] = origin;
    }
  }
  
  void update(float dt) {
    
    // Half step update
    for (int i = 0; i < n_particles - 1; i++) {
      hm[i] = (h[i]+h[i+1])/2.0 - (dt/2.0)*(uh[i]+uh[i+1]) / dx;
      uhm[i] = (uh[i]+uh[i+1])/2.0 - (dt/2.0)*(sq(uh[i+1]) / h[i+1]
                + .5 * g * sq(h[i+1]) - sq(uh[i]) / h[i] - 0.5 * g * sq(h[i])) / dx;
    }
    
    // Full step update
    for (int i = 0; i < n_particles - 2; i++) {
      h[i+1] -= dt*(uhm[i+1]-uhm[i]) / dx;
      uh[i+1] -= dt*(damp*uh[i+1] +
                  sq(uhm[i+1])/hm[i+1] + 0.5 * g * sq(hm[i+1])
                  - sq(uhm[i]) / hm[i] - 0.5 * g * sq(hm[i])) / dx;
    }
    
    // !!ONLY UNCOMMENT ONE OF THE FOLLOWING BOUNDARIES!!
    
    ////Periodic boundaries
    h[0] = h[n_particles - 2];
    h[n_particles - 1] = h[1];
    uh[0] = uh[n_particles - 2];
    uh[n_particles - 1] = uh[1];
    
    //// Free boundaries
    //h[0] = h[1];
    //h[n_particles - 1] = h[n_particles - 2];
    //uh[0] = uh[1];
    //uh[n_particles - 1] = uh[n_particles - 2];
    
    // Reflective boundaries
    //h[0] = h[1];
    //h[n_particles - 1] = h[n_particles - 2];
    //uh[0] = -uh[1];
    //uh[n_particles - 1] = -uh[n_particles - 2];
  }
  
  void display() {
    
    for (int i = 0; i < n_particles - 1; i++) {
    x1 = i*dx;
    x2 = (i+1)*dx;
    
    v1 = new PVector(x2 - x1, h[i+1] - h[i], 0);
    v2 = new PVector(x1 - x1, h[i] - h[i], -1);
    n = v1.cross(v2);
    
    // The surface of the water
    fill(#287FCE);
    noStroke();
    beginShape();
    texture(img);
    normal(n.x, n.y, n.z);
    vertex(x1, h[i], 300, dx * i, 0);
    vertex(x2, h[i+1], 300, dx * (1+ i), 0);
    vertex(x2, h[i+1], -200, dx * (1 + i), 500);
    vertex(x1, h[i], -200, dx * i, 500);
    endShape();
    
    //This is the bottom of the water
    noStroke();
    beginShape();
    vertex(x1, h[i], 300);
    vertex(x2, h[i+1], 300);
    vertex(x2, 590, 300);
    vertex(x1, 590, 300);
    endShape();
  }
    
  }

}
