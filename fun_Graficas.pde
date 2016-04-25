void fondo(int res, int z, float px, float py) {
  if (zoom <= 800*dist_planeta+10) {
    z = z * 2;
  }
  pushMatrix();
  translate(-width*z/2, -height*z/2, -200);
  translate(px, py);
  for (int x = 0; x <= width*z; x+=res*2*z) {
    for (int y = 0; y <= height*z; y+=res*2*z) {
      float r = random(0, 1);
      if (r*4 <= 3) {
        fill(0, 0, 4-(r*4));
        rect(x, y, res*2*z, res*2*z);
      }
    }
  }
  for (int x = 0; x <= width*z; x+=res*z) {
    for (int y = 0; y <= height*z; y+=res*z) {
      float noiseVal = noise(x*0.02, y*0.2);   
      fill(0, 0, (noiseVal*100), random(10, 110));
      if (noiseVal >= 0.83) {
        rect(x, y, res/2*z, res/2*z);
      }
    }
  }
  popMatrix();
}