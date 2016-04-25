class Galaxia {
  PVector[] s;
  int[] anios;
  float[] sani;
  float[] tamanio;
  float diam;
  int rot, estre, x, y;
  int brazos;
  int index;

  Galaxia(int rot_, int estre_, int x_, int y_) {
    rot = rot_;
    estre = estre_;
    x = x_;
    y = y_;

    diam = 0.8;

    index = (int)random(1, 4);

    s = new PVector[index];
    sani = new float[index];

    //Estrellas
    anios = new int[index];
    tamanio = new float[index];

    for (int i = 0; i < index; i++) {
      s[i] = new PVector( (int)random(-100, 100), (int)random(-80, 80) );
      anios[i] = (int)random(1, 100);
      tamanio[i] = random(0.25, 1);
    }

    for (int i = 0; i < index; i++) {
      sani[i] = s[i].x+11;
    }

    if (random(0, 10) > 5) {
      brazos = int(random(2, 10));
      if (brazos == 4) {
        brazos = 3;
      } else if (brazos == 7) {
        brazos = 5;
      } else if (brazos == 8) {
        brazos = 10;
      }
    } else {
      brazos = 1;
    }
  }

  void dibujar() {
    pushMatrix();
    translate(x, y);

    pushMatrix();
    pushStyle();
    translate(0, 0, 1); 
    tint(0, 0, 100, random(100, 200));
    imageMode(CENTER);
    image(atms, 0, 0
      , map(zoom, 4900, 800*dist_planeta, 430, 200), map(zoom, 4900, 800*dist_planeta, 430, 200));
    popStyle();
    popMatrix();

    pushMatrix();
    pushStyle();
    colorMode(HSB, 360, 100, 100);
    if (pobjx == x) {
      translate(0, 0, 200);
    } else {
      translate(0, 0, 60);
    }   
    rotateX(radians(rot));
    rotateZ(radians(frameCount/3));
    noStroke();
    for (int i=0; i < 350; i++) {
      fill(0, 0, 100, random(10, 200));

      if (i % brazos == 0) {
        rect((i/2)*sin(i/1.2), (i/2)*cos(i/1.2), map(i, 0, 350, estre, 3), map(i, 0, 350, estre, 3));

        if (i > 120) {
          fill(0, 0, 40, random(20, 90));
          rect((i/2)*sin(i/1.2)-map(i, 0, 350, estre, 3)/2, (i/2)*cos(i/1.2)-map(i, 0, 350, estre, 3)/2, map(i, 0, 350, estre, 3), map(i, 0, 350, estre, 3));
          fill(0, 0, 50, random(30, 80));
          rect((i/2)*sin(i/1.2)+map(i, 0, 350, estre, 3)/2, (i/2)*cos(i/1.2)-map(i, 0, 350, estre, 3)/2, map(i, 0, 350, estre, 3), map(i, 0, 350, estre, 3));
          fill(0, 0, 60, random(20, 60));
          rect((i/2)*sin(i/1.2)+map(i, 0, 350, estre, 3)/2, (i/2)*cos(i/1.2)+map(i, 0, 350, estre, 3)/2, map(i, 0, 350, estre, 3), map(i, 0, 350, estre, 3));
          fill(0, 0, 70, random(15, 70));
          rect((i/2)*sin(i/1.2)-map(i, 0, 350, estre, 3)/2, (i/2)*cos(i/1.2)+map(i, 0, 350, estre, 3)/2, map(i, 0, 350, estre, 3), map(i, 0, 350, estre, 3));
        }
      }
    }
    popStyle();
    popMatrix();

    popMatrix();

    if (zoom <= 800*dist_planeta+10) {
      pushMatrix();
      translate(-pcamx, -pcamy);
      translate(0, 0, 350); 
      pushStyle();

      rectMode(CENTER);
      noFill();
      strokeWeight(3);
      strokeCap(SQUARE);
      textFont(sgk);
      textSize(14);

      for (int i = 0; i < index; i++) {
        if (dist( mouseX, mouseY, width/2+(s[i].x+((80*s[i].x)/100)), height/2+(s[i].y+((80*s[i].y)/100)) ) < 20) {
          noStroke();
          fill(255, random(10, 230));
          rect(s[i].x, s[i].y, 8*tamanio[i], 8*tamanio[i]);
          noFill();
          stroke(255, 255);

          if (mouseClickEstrella) {
            sol = new Estrella(tamanio[i], anios[i]); //Crea estrella "Sol"

            for (int j=0; j < 3; j++) {  //Creador de Planetas
              planetas.add(new Planeta( boolean(int(random(0, 2))), boolean(int(random(0, 2))), boolean(int(random(0, 2)))
                , boolean(int(random(0, 2))), random(0.1, 0.6), (int)random(10, 50), (int)random(1000, 2000), (int)random(10, 360), 
                random(0, 300), (int)random(-1900, -1700)+j*1000 ));
            }

            resetVar();
            dist_planeta = sol.diam;

            alejar = true;
            acercar = false;
            mouseClickEstrella = false;
            sistemaEstelar = true;
          }

          if (s[i].x >= 0) {
            sani[i] = lerp(sani[i], s[i].x+80, 0.4);  //Variables de Animación
            line(s[i].x+11, s[i].y+11, sani[i], s[i].y+11);
            fill(255, map(sani[i], s[i].x+11, s[i].x+80, 0, 255) );
            textAlign(RIGHT);
            text("Edad: "+anios[i]*1000, s[i].x+80, s[i].y+8);
            noFill();
          } else {
            sani[i] = lerp(sani[i], s[i].x-80, 0.4);  //Variables de Animación
            line(s[i].x+11, s[i].y+11, sani[i], s[i].y+11);
            fill(255, map(sani[i], s[i].x+11, s[i].x-80, 0, 255) );
            textAlign(LEFT);
            text("Edad: "+anios[i]*1000, s[i].x-80, s[i].y+8);
            noFill();
          }
        } else {
          stroke(255, sin(frameCount/5)*80+80);
          sani[i] = s[i].x+11; //Resetea Animaciones
        }
        rect(s[i].x, s[i].y, 22, 22);
      }

      popStyle();
      popMatrix();
    }
  }
}