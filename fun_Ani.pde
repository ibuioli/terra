void aniZoom() {
  if (acercar == true && alejar == false) {
    zoom = lerp(zoom, 800*dist_planeta, 0.15);
  } else if (alejar == true && acercar == false) {
    zoom = lerp(zoom, 4900, 0.15);
  }
}

void aniMov() {
  if (mover == true) {
    pcamx = lerp(pcamx, apcamx, 0.4);
    pcamy = lerp(pcamy, apcamy, 0.4);
    if (pcamx == apcamx) {
      mover = false;
    }
  }
}

void aniMovObj() {
  if (mover == true) {
    fondobjx = lerp(fondobjx, apobjx, 0.4);
    fondobjy = lerp(fondobjy, apobjy, 0.4);
  }
}