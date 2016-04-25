class Satelite {
  boolean polar;
  int y, energia;
  int vida;
  float a, b;

  Satelite(int x_, int y_, int energia_, boolean polar_) {
    polar = polar_;

    if (polar) {
      y = int(map(x_, 0, width, -150, 950));
      a = map(y_, 0, height, -1.4, 1.4);
    } else {
      y = int(map(y_, 0, height, -50, 900));
      a = map(x_, 0, width, -1.4, 1.4);
    }

    energia = energia_;

    vida = 1200;
  }

  void dibujar() {
    pushStyle();
    pushMatrix();
    if (polar) {
      translate(y, sin(a)*425+400, cos(a)*2);
    } else {
      translate(sin(a)*425+400, y, cos(a)*2);
    }
    rotateZ(radians(a*150));
    translate(-7.5, -7.5);

    //rectMode(CENTER);

    if (energia >= 1) {
      fill(0, 0, abs(sin(a)*80)-10);
      rect(0, 0, 15, 15);
    }
    if (energia >= 2) {
      fill(0, 0, abs(sin(a)*80)+10);
      rect(-15, 0, 15, 15);
      rect(15, 0, 15, 15);
    }
    if (energia >= 3) {
      rect(0, -15, 15, 15);
    }
    if (energia >= 4) {
      rect(0, 15, 15, 15);
    }

    popMatrix();
    popStyle();
    a+=.1;
  }

  boolean terminar() {
    vida -= map(energia, 1, 4, 4, 1);

    if (vida < 0) {
      return true;
    } else {
      return false;
    }
  }
}