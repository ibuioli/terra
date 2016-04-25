void sistema_estelar() {
  pushMatrix();
  if (zoom > 4000) {
    sol.dibujar(-400, -400);
    for (int i = 0; i < planetas.size(); i++) {
      planetas.get(i).dibujar(sol.diam);
    }
  } else {
    if (pobjx == 0) {
      sol.dibujar(-400, -400);
    } else {
      for (int i = 0; i < planetas.size(); i++) {
        if (pobjx == planetas.get(i).xy*planetas.get(i).diam) {
          planetas.get(i).dibujar(sol.diam);
        }
      }
    }
  }
  popMatrix();

  ///INTERACCION//

  if (zoom > 4000) {
    if (mousePressed) {
      if (dist(pobjx+mouseX*factor_z-400*factor_z, pobjy+mouseY*factor_z-300*factor_z, 
        0, 0) < 800*sol.diam) {
        pobjx = 0;
        pobjy = 0;
        apobjx = pobjx;
        apobjy = pobjy;
        apcamx = 0;
        apcamy = 0;
        dist_planeta = sol.diam;
        mover = true;
      }

      for (int i = 0; i < planetas.size(); i++) {
        if (dist(pobjx+mouseX*factor_z-400*factor_z, pobjy+mouseY*factor_z-300*factor_z, 
          planetas.get(i).xy*planetas.get(i).diam, planetas.get(i).xy*planetas.get(i).diam) < 800*planetas.get(i).diam) {
          pobjx = planetas.get(i).xy*planetas.get(i).diam;
          pobjy = planetas.get(i).xy*planetas.get(i).diam;
          apobjx = pobjx;
          apobjy = pobjy;
          apcamx = (-pobjx)-800*planetas.get(i).diam/2;
          apcamy = (-pobjy)-800*planetas.get(i).diam/2;
          dist_planeta = planetas.get(i).diam;
          mover = true;
        }
      }
    }
  }
}