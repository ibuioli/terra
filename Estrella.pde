class Estrella {
  int x, y, res;
  int anios;
  float diam;
  PGraphics obj;

  Estrella(float diam_, int anios_) {
    diam = diam_;
    anios = anios_;

    obj = createGraphics(800, 800, JAVA2D);
  }

  void dibujar(float x_, float y_) {
    x = (int)x_;
    y = (int)y_;

    if (zoom <= 900) {
      res = 10;
    } else if (zoom > 900) {
      res = 20;
    }

    obj.beginDraw();
    obj.noStroke();
    obj.colorMode(HSB, 360, 100, 100);
    obj.fill(54-anios, 100-map(anios, 1, 100, 40, 0), 98);
    obj.rect(0, 0, 800, 800);
    for (int x = 0; x <= 800; x+=res) {
      for (int y = 0; y <= 800; y+=res) {
        int r = (int)random(0, 10);
        if (r > 5 && r < 8) {
          obj.fill(37-anios, 100-map(anios, 1, 100, 20, 0), 99-anios/4);
          obj.rect(x, y, res, res);
        } else if (r > 8) {
          obj.fill(24-anios, 100-map(anios, 1, 100, 10, 0), 65-anios/4);
          obj.rect(x, y, res, res);
        }
      }
    }
    obj.endDraw();

    if (zoom > 1000) {
      obj.mask(zmasc);
    } else {
      obj.mask(masc);
    }
    pushMatrix();
    scale(diam, diam);
    translate(x, y);

    if (zoom > 2000) {
      pushStyle();
      imageMode(CENTER);
      tint(0, anios, 100, random(100, 255));
      image(atms, 400, 400);
      popStyle();
    }

    image(obj, 0, 0);
    popMatrix();
  }
}