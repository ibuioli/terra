void sistema_galaxia() {
  if (zoom > 4000) {
    for (int i = 0; i < galaxias.size(); i++) {
      galaxias.get(i).dibujar();
    }
  } else {
    for (int i = 0; i < galaxias.size(); i++) {
      if (pobjx == galaxias.get(i).x) {
        galaxias.get(i).dibujar();
      }
    }
  }

  ///INTERACCION//

  if (zoom > 4000) {
    if (mousePressed) {
      for (int i = 0; i < galaxias.size(); i++) {
        if (dist(pobjx+mouseX*factor_z-400*factor_z, pobjy+mouseY*factor_z-300*factor_z, 
          galaxias.get(i).x, galaxias.get(i).y) < 100) {
          pobjx = galaxias.get(i).x;
          pobjy = galaxias.get(i).y;
          apobjx = pobjx;
          apobjy = pobjy;
          apcamx = (-pobjx);
          apcamy = (-pobjy);
          dist_planeta = 0.8;
          mover = true;
        }
      }
    }
  }
}