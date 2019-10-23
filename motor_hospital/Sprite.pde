class Sprite {
  PImage img;
  PImage [] imgs;
  PImage text_img;

  String id;
  float x;
  float y;
  boolean show;
  int opacity;
  boolean multiple;
  int index;

  int timer_fired;
  int elapsed_time;
  boolean animating;
  int prev_index;
  float x_anim;

  int w;
  int h;
  int y_clip;

  PGraphics animation;
  PImage gradient;


  Sprite(String filename) {
    img = loadImage(filename);
    img.filter(INVERT);
    show = false;
    x = 0;
    y = 0;
    id = "";
    multiple = false;
    index = 0;
    w = img.width;
    h = img.height;
  }

  Sprite(String filename, int n) {
    multiple = true;
    y_clip = 210;

    gradient = loadImage("data/img/gradient.png");
    imgs = new PImage[n];
    for (int i = 0; i < n; i++) {

      String [] aux =splitTokens(filename, ".");
      String name = aux[0] +"_" + (i+1) + "." + aux[1];
    //  println(name);
      PImage temp = loadImage(name);
    // println(temp.width);
      if (i==0) {
        w = temp.width;
        h = temp.height;
        text_img = createImage(w, h-y_clip, ARGB);
        text_img.copy(temp, 0, y_clip, w, h-y_clip, 0, 0, text_img.width, text_img.height);
        text_img.filter(INVERT);
      }
      imgs[i] = createImage(w, y_clip, ARGB);
      imgs[i].copy(temp, 0, 0, w, y_clip, 0, 0, w, y_clip);
      imgs[i].filter(INVERT);
    }
    animation = createGraphics(w, h);
    show = false;
    x = 0;
    y = 0;
    id = "";
  }

  void setId(String id_) {
    id = id_;
  }

  void update() {
    if (show) {
      if (opacity < 255)
        opacity +=10;
    }
    if (multiple) {
      elapsed_time = millis() - timer_fired;
      if (animating) {
        if (elapsed_time > MISTERY_ANIMATION_TIME) {
          animating = false;
          timer_fired = millis();
        } else {
          float t = map(elapsed_time, 0, MISTERY_ANIMATION_TIME, 0, 1);
          x_anim = map(sinOut(t), 0, 1, imgs[0].width, 0);
        }
      } else {
        if (elapsed_time > MISTERY_TIME) {
          prev_index = index;
          index++;

          animating = true;
          timer_fired = millis();
          x_anim =  imgs[0].width;
          //  timer_fired = millis();
          if (index >= imgs.length)
            index = 0;
        }
      }
    }
  } 

  void activate() {
    show = true;
    opacity = 0;
    if (multiple) {
      x_anim = 0;
      animating = false;
      timer_fired = millis();
    }
  }


  void deActivate() {
    show = false;
    opacity = 0;
  }

  void setPosition(float x_, float y_) {
    x = x_;
    y = y_;
    y += (800-768)/2;
    x_anim = 0;
  }

  void render(PGraphics g) {
    g.pushStyle();

    //   renderBounding(g);

    if (show) {
      g.noTint();
      g.tint(255, opacity);
      if (multiple) {

        animation.beginDraw();
        animation.clear();
        animation.image(imgs[prev_index], x_anim - imgs[0].width, 0);
        animation.image(imgs[index], x_anim, 0);
        animation.image(text_img, 0, y_clip);
        if ( SHOW_MISTERY_GRADIENT)
          animation.image(gradient, 0, 0);

        animation.endDraw();

        g.image(animation, x, y);
      } else
        g.image(img, x, y);
    }

    g.popStyle();
  }

  void renderBounding(PGraphics g) {
    g.pushStyle();
    g.noFill();
    g.stroke(255, 128, 0);
    g.rect(x, y, w, h);
    g.line(x, y+y_clip, x+w, y+y_clip);
    g.popStyle();
  }
}
