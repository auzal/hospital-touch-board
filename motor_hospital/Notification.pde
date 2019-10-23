class Notification {

  String text;
  float x;
  float y;
  float w;
  float h;

  float opacity;
  PFont font;
  float fade_rate;
  float initial_opacity;

  //••••••••••••••••••••••••••••••••••••••••••••••••••••••

  Notification() {

    text = "";
    x = 0; 
    y = 0;
    w = 0;
    h = 0;
    fade_rate = 3;
    initial_opacity = 200;
  }

  //••••••••••••••••••••••••••••••••••••••••••••••••••••••

  void createNotification() {
    text = "empty notification";
    x = 0; 
    y = 0;
    resetOpacity();
  }

  //••••••••••••••••••••••••••••••••••••••••••••••••••••••

  void createNotification(String t) {
    text = t;
    resetOpacity();
  }

  //••••••••••••••••••••••••••••••••••••••••••••••••••••••

  void createNotification(String t, float x_, float y_) {
    text = t;
    x = x_;
    y = y_;
    resetOpacity();
  }

  //••••••••••••••••••••••••••••••••••••••••••••••••••••••

  void render(PGraphics g) {

    g.pushStyle();

    if (font!=null)
      g.textFont(font);

    w = textWidth(text)   + 20;
    h = textAscent() + textDescent() + 20;

    g.rectMode(CENTER);
    g.textAlign(CENTER, CENTER);
    g.pushMatrix();

    g.translate(x + w/2, y + h/2);

    g.noStroke();
    g.fill(3, 126, 131, opacity);
    g.rect(0, 0, w, h);
    g.fill(255, opacity);
    g.text(text, 0, 0);
    g.popMatrix();

    g.popStyle();
  }

  //••••••••••••••••••••••••••••••••••••••••••••••••••••••

  void update() {

    opacity -= fade_rate;
    opacity = constrain(opacity, 0, 255);
  }

  //••••••••••••••••••••••••••••••••••••••••••••••••••••••

  void resetOpacity() {

    opacity = initial_opacity;
  }

  //••••••••••••••••••••••••••••••••••••••••••••••••••••••

  void setFont(PFont f) {

    font = f;
  }

  //••••••••••••••••••••••••••••••••••••••••••••••••••••••

  void setPosition(float x_, float y_) {

    x = x_;
    y = y_;
  }
}
