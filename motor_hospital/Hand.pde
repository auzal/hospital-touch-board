class Hand {

  PImage h;
  PImage blip;
  float x;
  float y;
  float y_show;
  float fly_dist = 90;
  boolean show;
  String state;
  int init_blip_dist = 50;
  int end_blip_dist = 80;
  float blip_show_dist;
  float current_dist=0;
  float scale;
  int opacity;

  int elapsed_time;
  int fire_time;

  Hand() {
    h = loadImage("data/img/hand.png");
    h.filter(INVERT);
    blip = loadImage("data/img/blip.png");
    blip.filter(INVERT);
    show = false;
    state = "OFF";
  }

  void update() {

    elapsed_time = millis() - fire_time;



    if (state.equals("FLY")) {

      if (elapsed_time >HAND_FLY_TIME) {
        state = ("WAIT");
        fire_time = millis();
      } else {
        float t = elapsed_time/(HAND_FLY_TIME*1.0);
        float amt = cubicOut(t);
        opacity = int(constrain((255*t*2), 0, 255));
        y_show = map(amt, 0, 1, y + fly_dist, y);
      }
    } else if (state.equals("WAIT")) {

      if (elapsed_time >HAND_IDLE_TIME) {
        state = ("BLIP");
        fire_time = millis();
        blip_show_dist = init_blip_dist;
      }
    } else if (state.equals("BLIP")) {

      if (elapsed_time >HAND_BLIP_TIME) {
        state = ("FADEOUT");
        fire_time = millis();
        scale = 1;
      } else { 
        float t = elapsed_time/(HAND_BLIP_TIME*1.0);
        float amt = cubicOut(t);
        blip_show_dist = map(amt, 0, 1, init_blip_dist, end_blip_dist);
        if (t<.3)
          scale = map(t, 0, 0.3, .9, 1);
        else
          scale = 1;
      }
    } else if (state.equals("FADEOUT")) {

      if (elapsed_time > HAND_FADE_TIME) {
        state = ("OFF");
        fire_time = millis();
        scale = 1;
      }
      else
        opacity = int((1-(elapsed_time/(HAND_FADE_TIME * 1.0)))*255);
    }else if (state.equals("OFF")) {
      opacity = 0;
    
    }
  }

  void render(PGraphics g) {
    if (!state.equals("OFF")) {


      g.pushStyle();
      g.pushMatrix();
      g.translate(x, y_show);
      g.imageMode(CENTER);
      g.tint(opacity);

      g.image(h, 0, 0, h.width*scale, h.height*scale);

      if (state.equals("BLIP") || state.equals("FADEOUT")) {
        int blip_count = 6;
        float ang_off = 20;
       g.pushMatrix();
        for (int i = 0; i < blip_count; i ++) {
          g.pushMatrix();
          g.rotate(radians(map(i, 0, blip_count-1, 180+ang_off, 360-ang_off)));
          g.translate(blip_show_dist, 0);
          g.image(blip, 0, 0);
          g.popMatrix();
        }
        g.popMatrix();
      }
      g.popMatrix();
      g.noTint();
      g.popStyle();
    }
  }


  void activate() {
    show = true;
    state ="FLY";
    fire_time = millis();
    scale = 1;
    opacity = 0;
  }



  void deActivate() {
    show = false;
    state ="OFF";
    fire_time = millis();
    scale = 1;
    opacity = 0;
  }


  void setPosition(float x_, float y_) {
    x = x_;
    y = y_;
  }
}
