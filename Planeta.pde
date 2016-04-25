class Planeta {
  ArrayList<Satelite> satelites;

  boolean b; 
  boolean nubes, polos, gaseoso, agua;
  int temp, atm, quimica;
  float geo;
  int xy, res;
  float diam;
  PGraphics obj;

  Planeta(boolean nubes_, boolean polos_, boolean gaseoso_, boolean agua_, 
    float diam_, int temp_, int atm_, int quimica_, float geo_, int xy_) {
    nubes = nubes_;
    polos = polos_;
    gaseoso = gaseoso_;
    agua = agua_;
    diam = diam_;
    temp = temp_;
    atm = atm_;
    quimica = quimica_;
    geo = geo_;
    
    xy = int(xy_ / diam);

    if (xy >= 0 && xy <= 1000) {
      xy = 1000;
    } else if (xy <= 0 && xy >= -1000) {
      xy = -1000;
    }
    
    if(abs(xy) <= 1500){
      temp = (int)map(xy_, 1000, 1500, 60, 10);
    }
    
    if(diam > 0.25){
      gaseoso = true;
      nubes = true;
      agua = false;
    }else{
      gaseoso = false;
    }

    println(xy);
    
    obj = createGraphics(800, 800, JAVA2D);

    ////////////////////////////////////////

    satelites = new ArrayList<Satelite>();
  }

  void dibujar(float est_d) {

    if (zoom <= 800*dist_planeta+10) {
      res = 10;
    } else if (zoom > 800*dist_planeta+10 && zoom <= 1000) {
      res = 20;
    } else if (zoom > 1000 && zoom <= 2000) {
      res = 40;
    } else if (zoom > 2000) {
      res = 80;
    }

    obj.beginDraw();
    obj.background(0);
    obj.noStroke();
    obj.colorMode(HSB, 360, 100, 100, 255);

    if (agua) {
      for (int x = 0; x <= 800; x+=res) {
        for (int y = 0; y <= 800; y+=res) {
          if (b) {
            obj.fill(220, 99, 90);
          } else {
            obj.fill(168, 70, 69);
          } 
          obj.rect(x, y, res, res);
          b = !b;
        }
      }
    } else if (!agua && !gaseoso) {
      for (int x = 0; x <= 800; x+=res) {
        for (int y = 0; y <= 800; y+=res) {
          if (b) {
            obj.fill(quimica-10, 90, 80);
          } else {
            obj.fill(quimica-10, 80, 60);
          } 
          obj.rect(x, y, res, res);
          b = !b;
        }
      }
    }

    if (!gaseoso) {  //Planeta ROCOSO
      for (int x = 0; x <= 800; x+=res) {
        for (int y = 0; y <= 800; y+=res) {
          float r = random(0.026, 0.03);
          float noiseVal = noise(frameCount+x*r, y*r);
          if (agua) {
            if (noiseVal >= geo) {
              obj.fill(quimica-noiseVal*100, 70, noiseVal*40, noiseVal*340);
              obj.rect(x, y, res, res);
            }
          } else {
            if (noiseVal >= geo) {
              obj.fill(quimica-noiseVal*10, 90, noiseVal*99);
              obj.rect(x, y, res, res);
            }
          }
        }
      }
    }


    if (polos) {  //Planeta con Polos de Hielo
      if (zoom < 1000) {
        for (int x = 0; x <= 800; x+=res) {
          for (int y = 0; y <= 800; y+=res) {
            if (y <= 30) {
              if (b) {
                obj.fill(185, 12, 99, 255-y*5);
              } else {
                obj.fill(200, 9, 90, 255-y*5);
              }
              obj.rect(x, y, res, res);
            }
            if (y >= 770) {
              if (b) {
                obj.fill(185, 12, 99, 255-(800-y)*5);
              } else {
                obj.fill(200, 9, 90, 255-(800-y)*5);
              }
              obj.rect(x, y, res, res);
            }
            b = !b;
          }
        }
      }
    }

    if (nubes) {  //Nubes del Planeta
      if (!gaseoso) {  //Nubes del Planeta ROCOSO
        for (int x = 0; x <= 800; x+=res*2) {
          for (int y = 0; y <= 800; y+=res*2) {
            float r = random(0.016, 0.02);
            float noiseVal = noise(frameCount/2+x*r, y*r);
            if (noiseVal >= 0.55) {
              obj.fill(0, 0, 99, (noiseVal*255)+20);
            } else {
              obj.fill(0, 0, 0, 0);
            }
            obj.rect(x, y, res*2, res*2);
          }
        }
      } else {  //Planeta GASEOSO
        for (int x = 0; x <= 800; x+=res) {
          for (int y = 0; y <= 800; y+=res) {
            float r = random(0.018, 0.02);
            float noiseVal = noise(geo+y*r);
            obj.fill(quimica-(noiseVal*65), 100-(noiseVal*temp), 100, (noiseVal*255)+55);
            obj.rect(x, y, res, res);
          }
        }
      }
    }

    /*TERMINAR DE DIBUJAR*/
    obj.endDraw();

    if (zoom > 1000) {
      obj.mask(zmasc);
    } else {
      obj.mask(masc);
    }

    pushStyle();
    pushMatrix();
    scale(diam, diam);
    translate((((diam*100)*100)/1600000)*est_d, (((diam*100)*100)/16000000)*est_d);
    translate(xy, xy);

    if (zoom > 3000) {
      pushStyle();
      imageMode(CENTER);
      tint(0, 0, 99, random(100, 255));
      image(atms, 400, 400);
      popStyle();
    }

    image(obj, 0, 0);

    pushMatrix();
    translate(0, 0, 1);
    if (zoom <= 800*dist_planeta+10) {
      if (satelites.size() >= 0) {
        for (int i = 0; i < satelites.size(); i++) {
          satelites.get(i).dibujar();
          if (satelites.get(i).terminar()) {
            satelites.remove(i);
          }
        }
      }
    }
    popMatrix();

    popMatrix();
    popStyle();

    if (dist(mouseX, mouseY, width/2, height/2) < 262) {
      if (mouseClickSatelite) {
        satelites.add(new Satelite(mouseX, mouseY, 2, false));
        mouseClickSatelite = false;
      } else {
        if (mouseClickSatelite) {
          mouseClickSatelite = false;
        }
      }
    }
  }
}