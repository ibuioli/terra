void mouseWheel(MouseEvent event) {
  float e = event.getCount();

  if (sistemaEstelar == false && pcamx != 0 && pcamy != 0) {
    if (e >= 1) {
      acercar = false;
      alejar = true;
    } else if (e <= -1) {
      acercar = true;
      alejar = false;
    }
  } else if (sistemaEstelar == true) {
    if (e >= 1) {
      acercar = false;
      alejar = true;
    } else if (e <= -1) {
      acercar = true;
      alejar = false;
    }
  }

  //Positivo se Aleja
  //Negativo se Acerca
}

void mouseClicked() {
  if (mouseButton == RIGHT) {
    if (zoom <= 800*dist_planeta+10) {
      mouseClickSatelite = true;
    }
  }

  if (mouseButton == LEFT) {
    if (zoom <= 800*dist_planeta+10) {
      mouseClickEstrella = true;
    }
  }
}