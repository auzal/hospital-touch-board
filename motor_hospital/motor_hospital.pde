// VERSION 6
// ************************************
// BUGS DE SUPERPOSICION ARREGLADOS
// FADES SENCILLOS INCORPORADOS
// INCORPORA MULTIPLES IMAGENES MISTERIOSAS
// IMAGENES MISTERIOSAS ANIMADAS
// MANO CADA TANTO
// SIMULACION POR TECLADO


ArrayList <Sensor> sensors;
StateManager manager;

void setup() {
  size(1280, 800, P2D);
  manager = new StateManager();
  initSerial();
  noCursor();
}

void draw() {
  surface.setTitle(str(manager.idle_time));
  background(0);

  manager.render();
  manager.update();

}

void mousePressed() {
  manager.mousePressed();
}

void mouseReleased() {
  manager.mouseReleased();
}

void mouseClicked() {
  manager.mouseClicked();
}

void mouseDragged() {
  manager.mouseDragged();
}

void keyPressed() {
  manager.keyPressed();
}

void keyReleased(){
  manager.keyReleased();
}
