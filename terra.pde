Estrella sol;
ArrayList<Galaxia> galaxias;
ArrayList<Planeta> planetas;
int[] gpos;
PFont sgk;
PImage masc, zmasc, atms;
float zoom, dist_planeta;
float pcamx, pcamy, apcamx, apcamy, pobjx, pobjy, fondobjx, fondobjy, apobjx, apobjy;
float factor_z;

boolean mouseClickEstrella, mouseClickSatelite;
boolean sistemaEstelar;
boolean acercar, alejar, mover, mover_res;

void setup() {
  size(800, 600, P3D);

  //////SET-UP VISUAL//////

  colorMode(HSB, 360, 100, 100);
  noSmooth();
  noStroke();
  
  sgk = createFont("fuentes/sgk.ttf", 48);
  masc = loadImage("masc.jpg");
  zmasc = loadImage("zmasc.jpg");
  atms = loadImage("atm.png");

  ///////OBJETOS//////
  //Galaxias
  //Rotación, Estrellas, posX, posY
  galaxias = new ArrayList<Galaxia>();
  for(int i=0; i < int(random(4, 9)); i++){
    galaxias.add(new Galaxia( int(random(10, 85)), int(random(10, 30)), int(random(-2000, 2000)), int(random(-2000, 2000)) ));
  }
  
  //Estrellas
  //Diám, Años
  /*
   Diám: 0.2 - 1
   Años: 1 - 100
   */
  
  //Planetas
  //Nubes, Polos, Gaseoso, Agua, Diám, Temp, Atm, Qui, Geo
  /*
   Nubes: Si o No
   Polos: Si o No
   Gaseoso: Si (Gaseoso) o No (Rocoso)
   Agua: Si o No
   Diámetro: 0.1 - 1
   Temp: En valor de Saturación
   Atm: Brillo de Atmósfera
   Qui: Quimica del Planeta (20-360 Hierro, 120-200 Carbon)
   Geo: Geografía (En Rocosos valores de 2 a 16, en Gaseosos valores altos)
   XY: Posición
   */
  planetas = new ArrayList<Planeta>();
  //planetas.add(new Planeta(true, true, false, true, 0.12, 50, 1400, 180, 0.6, 900));
  //planetas.add(new Planeta(false, true, false, false, 0.1, 60, 1350, 360, 0.3));
  //planetas.add(new Planeta(true, false, true, false, 0.35, 78, 1100, 70, 200));
  //planetas.add(new Planeta(true, false, true, false, 0.25, 90, 1200, 220, 600));

  ///////VARIABLES//////
  zoom = 4900;
  dist_planeta = 0.8;
}

void draw() {
  background(0);

  //SET-UPs//
  factor_z = zoom/520;
  //////////

  fondo(5, ceil(factor_z), fondobjx, fondobjy);

  beginCamera(); //CAMARA// 
  camera(0, 0, zoom, 
    0, 0, 0, 
    0, 1, 0);
  translate(pcamx, pcamy);
  endCamera();
  
  if(sistemaEstelar){
    sistema_estelar();
  }else{
    sistema_galaxia();
  }
  
  ////////////ANIMACIONES/////////////

  aniZoom();
  aniMov();
  aniMovObj();

  //////////////DEBUG////////////////
  debug();
}