class Sensor {
  boolean pressed;
  boolean clicked;
  int id;
  float x;
  float y;
  float diam;
  String state;
  boolean calibrating;
  PFont f;

  Sensor(float x_, float y_) {
    x = x_;
    y = y_;
    pressed = false;
    clicked = false;
    diam = 50;
    id = 0;
    state = "RUNNING";
    calibrating = false;
    f = loadFont("Ping.vlw");
  }

  void render(PGraphics g) {
    g.pushStyle();
    g.stroke(5, 160, 156);
    g.fill(5, 160, 156, 60);
    g.ellipse(x, y, diam, diam);
    g.line(x-5, y, x+5, y);
    g.line(x, y-5, x, y+5);

   g.textFont(f);
    g.fill(5, 160, 156);
    g.text(id, x + diam/2, y+diam/2);
    g.fill(0, 150);
    g.text(id, x + diam/2+1, y+diam/2+1);
    g.popStyle();
  }

  void renderState(PGraphics g) {
    if (clicked || pressed) {
      g.pushStyle();
      g.noStroke();
      g.fill(52, 206, 194);
     g.ellipse(x + diam/2, y-diam/2, 20, 20);
      g.popStyle();
    }
  }

  void renderSelector(PGraphics g) {
    g.pushStyle();
    g.pushMatrix();
    g.strokeWeight(2);
    g.translate(x, y);
    g.rotate(frameCount*0.05);
    g.stroke(255, 217, 0);
    int l = 10;
    g.pushMatrix();
    g.translate(-diam/2, -diam/2);
    g.line(0, 0, l, 0);
    g.line(0, 0, 0, l);
    g.popMatrix();
    g.pushMatrix();
    g.translate(diam/2, -diam/2);
    g.line(0, 0, -l, 0);
    g.line(0, 0, 0, l);
    g.popMatrix();
    g.pushMatrix();
    g.translate(diam/2, diam/2);
    g.line(0, 0, -l, 0);
    g.line(0, 0, 0, -l);
    g.popMatrix();
    g.pushMatrix();
    g.translate(-diam/2, diam/2);
    g.line(0, 0, l, 0);
    g.line(0, 0, 0, -l);
    g.popMatrix();

    g.popMatrix();
    g.popStyle();
  }

  void setPosition(float x_, float y_) {
    x = x_;
    y = y_;
  }

  void move(float dx, float dy) {
    x += dx;
    y += dy;
  };

  void setId(int id_) {
    id = id_;
  }

  void click() {
    clicked = true;
  }

  void unClick() {
    clicked = false;
  }
  
  void touched(){
    pressed = true;
  }
  
  void released(){
    pressed = false;
  }

  boolean checkClick() {
    boolean ret = false;
    if (dist(mouseX, mouseY, x, y) < diam) {
      clicked = true;
      ret = true;
    }
    return ret;
  }
}
