void debug() {
  pushMatrix();
  translate(-pcamx, -pcamy);
  translate(10*factor_z, 20*factor_z);
  pushStyle();
  fill(0, 0, 100);
  textSize(14*factor_z);
  text("FPS: "+(int)frameRate, -width/2*factor_z, -height/2*factor_z);
  text("mX: "+mouseX, -width/2*factor_z, (-height/2+15)*factor_z);
  text("mY: "+mouseY, -width/2*factor_z, (-height/2+30)*factor_z);
  text("key: "+key, -width/2*factor_z, (-height/2+45)*factor_z);

  popStyle();
  popMatrix();
}