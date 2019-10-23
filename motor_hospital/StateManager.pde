class StateManager {

  PImage lona;

  String state="RUNNING";
  Notification notif;
  int selected_sensor;
  boolean render_debug;

  int idle_time;
  int idle_fire;

  ArrayList <Sprite> mistery;
  ArrayList <Sprite> footprints;
  ArrayList <Sprite> composites;
  ArrayList <Sprite> highlights;
  ArrayList <Sprite> a;
  ArrayList <Sprite> s;
  ArrayList <Sprite> e;
  ArrayList <Sprite> m;
  ArrayList <Sprite> t;

  PGraphics render;
  MappedPoly mapping;
  PFont debug_font;

  boolean shift;


  Hand hand;

  //••••••••••••••••••••••••••••••••
  StateManager() {
    notif = new Notification();
    notif.setPosition(50, 50);
    notif.setFont(loadFont("DIN-24.vlw"));
    debug_font = loadFont("DIN-24.vlw");
    notif.createNotification(state);
    selected_sensor = 0;
    lona = loadImage("LONA_FINAL-01.png");

    initSensors();
    loadSensorConfig();
    render_debug = false;
    loadMistery();
    loadFootprints();
    loadComposites();
    loadHighlights();
    loadObjects();

    hand = new Hand();

    render = createGraphics(width, height);
    mapping = new MappedPoly();
    mapping.setFont(loadFont("quick10.vlw"));
    mapping.setId("hospital");

    shift = false;
  }

  //••••••••••••••••••••••••••••••••

  void update() {
    hand.update();
    notif.update();


    idle_time = millis() - idle_fire;
    for (int i = 0; i < sensors.size(); i ++) {
      if (sensors.get(i).pressed) {
        idle_fire = millis();
        hand.deActivate();
      }
    }

    if (idle_time > HAND_IDLE_TIMEOUT) {

      int index = int(random(sensors.size()));
      hand.setPosition(sensors.get(index).x, sensors.get(index).y + HAND_Y_OFFSET);


      hand.activate();
      idle_fire = millis();
    }

    updateSprites();
  }

  //••••••••••••••••••••••••••••••••

  void render() {
    render.beginDraw();
    render.background(0);


    if (state.equals("CALIBRATING_SENSORS")) {
      render.image(lona, 0, (height - lona.height )/ 2);      
      for (int i = 0; i < sensors.size(); i ++) {
        sensors.get(i).render(render);
        if (i == selected_sensor) {
          sensors.get(i).renderSelector(render);
          render.pushStyle();
          render.stroke(5, 160, 156, 90);          
          render.line(sensors.get(selected_sensor).x, sensors.get(selected_sensor).y, mouseX, mouseY);
          render.popStyle();
        }
      }
    } else if (state.equals("RUNNING")) {
      for (int i = 0; i < mistery.size(); i++) {
        mistery.get(i).render(render);
        footprints.get(i).render(render);
      }
      for (int i = 0; i <composites.size(); i++) {
        composites.get(i).render(render);
      }
      for (int i = 0; i <highlights.size(); i++) {
        highlights.get(i).render(render);
      }

      for (int i = 0; i <a.size(); i++) {
        a.get(i).render(render);
        e.get(i).render(render);
        s.get(i).render(render);
        m.get(i).render(render);
        t.get(i).render(render);
      }

      if (render_debug) {
        render.pushStyle();
        render.tint(255, 90);
        render.image(lona, 0, (height - lona.height )/ 2);
        render.popStyle();

        render.fill(255);

        render.textFont(debug_font);
        render.textSize(20);
        render.text("PUERTOS: ", 30, 50);
        for (int i = 0; i < PORTS.length; i ++)
          render.text("[" + i + "] " +PORTS[i], 30, 70 + i * 30);
        //  renderZones(render);

        for (int i = 0; i < sensors.size(); i ++) {
          sensors.get(i).renderState(render);
        }
      }
    } else if (state.equals("MAPPING")) {
      render.pushStyle();
      render.image(lona, 0, (height - lona.height )/ 2);
      render.popStyle();
    }
    notif.render(render);

    hand.render(render);

    render.endDraw();



    mapping.updateTexture(render);
    mapping.render();
    mapping.update();
  }

  //••••••••••••••••••••••••••••••••

  void renderZones(PGraphics g) {
    g.pushStyle();
    g.pushMatrix();
    g.translate(0, (800-768)/2);
    g.fill(255, 0, 0, 40);
    g.noStroke();
    g.rect(LEFT_ZONE.x, LEFT_ZONE.y, LEFT_ZONE_DIM.x, LEFT_ZONE_DIM.y);
    g.rect(RIGHT_ZONE.x, RIGHT_ZONE.y, RIGHT_ZONE_DIM.x, RIGHT_ZONE_DIM.y);
    g.rect(MISTERY_ZONE.x, MISTERY_ZONE.y, MISTERY_ZONE_DIM.x, MISTERY_ZONE_DIM.y );
    g.rect(FOOTPRINT_ZONE.x, FOOTPRINT_ZONE.y, FOOTPRINT_ZONE_DIM.x, FOOTPRINT_ZONE_DIM.y );
    g.popStyle();
    g.popMatrix();
  }

  //••••••••••••••••••••••••••••••••

  void saveSensorConfig() {
    String[] output = new String[sensors.size()];
    for (int i = 0; i < sensors.size(); i ++) {
      output[i] = sensors.get(i).x + "," + sensors.get(i).y + "," + sensors.get(i).id;
    }
    saveStrings("data/sensorsconfig.txt", output);
  }

  //••••••••••••••••••••••••••••••••

  void loadSensorConfig() {
    String[] data = null;
    try {
      data = loadStrings("data/sensorsconfig.txt");
    }
    catch(Exception e) {
      println("No config file.");
    }
    if (data!=null) {
      for (int i = 0; i < data.length; i ++) {
        String[] row = splitTokens(data[i], ",");
        sensors.get(i).setPosition( float(row[0]), float(row[1]) );
        sensors.get(i).setId( int(row[2]));
      }
    }
  }

  //••••••••••••••••••••••••••••••••

  void mousePressed() {
    if (state.equals("MAPPING")) {
      mapping.mousePressed();
    }
    if (state.equals("RUNNING")) {
      for (int i = 0; i < sensors.size(); i ++) {
        if (sensors.get(i).checkClick()) {
          sensorActivated(i);
        }
      }
    }
  }
  //••••••••••••••••••••••••••••••••

  void mouseReleased() {
    if (state.equals("MAPPING")) {
      mapping.mouseReleased();
    }
    if (state.equals("RUNNING")) {
      for (int i = 0; i < sensors.size(); i ++) {
        sensors.get(i).unClick();
      }
    }
  }

  //••••••••••••••••••••••••••••••••

  void mouseClicked() {
    mapping.mouseClicked();
  }

  //••••••••••••••••••••••••••••••••
  void mouseDragged() {
    if (state.equals("MAPPING")) {
      mapping.checkDrag();
    }
    if (state.equals("CALIBRATING_SENSORS")) {
      sensors.get(selected_sensor).move(mouseX-pmouseX, mouseY-pmouseY);
    }
  }

  //••••••••••••••••••••••••••••••••

  void keyPressed() {

    if (keyCode == SHIFT) {
      shift = true;
    }

    if (state.equals("MAPPING")) {
      mapping.checkKeys();
    }
    if (state.equals("RUNNING")) {
      checkSimulatedPress();
      if (key == 'D') {
        render_debug = !render_debug;
        if (render_debug) {
          notif.createNotification("debug on");
        } else {
          notif.createNotification("debug off");
        }
      }
    } else if (state.equals("CALIBRATING_SENSORS")) {
      if (keyCode == LEFT)
        sensors.get(selected_sensor).move(-10, 0);
      else if (keyCode == RIGHT)
        sensors.get(selected_sensor).move(10, 0);
      else if (keyCode == UP)
        sensors.get(selected_sensor).move(0, -10);
      else if (keyCode == DOWN)
        sensors.get(selected_sensor).move(0, 10);
      else if (keyCode == TAB) {
        selected_sensor ++ ;
        if (selected_sensor > sensors.size()-1)
          selected_sensor =0;
      }
    }

    if (key == RETURN || key == ENTER) {
      if (state.equals("CALIBRATING_SENSORS")) {
        saveSensorConfig();
        state = "RUNNING"; 
        notif.createNotification(state);
      } else if (state.equals("RUNNING")) {
        state = "MAPPING"; 
        mapping.calibrating=true;
        notif.createNotification(state);
      } else if (state.equals("MAPPING")) {
        if (shift)
          state = "CALIBRATING_SENSORS"; 
        else
          state = "RUNNING"; 

          notif.createNotification(state);
      }
    }
  }
  //••••••••••••••••••••••••••••••••

  void keyReleased() {
    if (keyCode == SHIFT) {
      shift = false;
    }
    if (state.equals("RUNNING")) {
      checkSimulatedRelease();
    }
  }


  //••••••••••••••••••••••••••••••••

  void initSensors() {
    sensors = new ArrayList();
    for (int i = 0; i < SENSORS; i++) {
      float x = random(width);
      float y = random(height);
      Sensor aux = new Sensor(x, y);
      aux.setId(i+1);
      sensors.add(aux);
    }
  }

  //••••••••••••••••••••••••••••••••

  void electrodeTouched(int index) {
    handleSensorActivation(index);
    sensorActivated(index);
  }

  void handleSensorActivation(int index) {
    if (index < 7) {
      for (int i = 0; i < 7; i ++) {
        sensors.get(i).released();
        sensors.get(i).unClick();
        highlights.get(i).deActivate();
      }
      sensors.get(index).touched();
      highlights.get(index).activate();
    } else if (index < 10) {
      for (int i = 7; i < 10; i ++) {
        sensors.get(i).released();
        sensors.get(i).unClick();
        highlights.get(i).deActivate();
      }
      sensors.get(index).touched();
      highlights.get(index).activate();
    } else if (index < 12) {
      for (int i = 10; i < 12; i ++) {
        sensors.get(i).released();
        sensors.get(i).unClick();
        highlights.get(i).deActivate();
      }
      sensors.get(index).touched();
      highlights.get(index).activate();
    }
  }

  //••••••••••••••••••••••••••••••••

  void electrodeReleased(int index) {
    sensors.get(index).released();
    highlights.get(index).deActivate();
    sensorReleased(index);
  }

  //••••••••••••••••••••••••••••••••

  void loadMistery() {
    mistery = new ArrayList();
    for (int i = 0; i < 7; i++) {
      Sprite aux;
      if (i == 0 || i == 1) {
        aux = new Sprite("img/mistery/" + MISTERY[i], 2);
      } else if (i == 6 ) {
        aux = new Sprite("img/mistery/" + MISTERY[i], 3);
      } else {
        aux = new Sprite("img/mistery/" + MISTERY[i]);
      }
      aux.setPosition(MISTERY_ZONE.x, MISTERY_ZONE.y);
      aux.setId(str(i));
      mistery.add(aux);
    }
  }

  //••••••••••••••••••••••••••••••••

  void loadFootprints() {
    footprints = new ArrayList();
    for (int i = 0; i < 7; i++) {
      Sprite aux = new Sprite("img/footprints/" + FOOTPRINTS[i]);
      aux.setPosition(FOOTPRINT_ZONE.x, FOOTPRINT_ZONE.y);
      aux.setId(str(i));
      footprints.add(aux);
    }
  }

  //••••••••••••••••••••••••••••••••

  void loadComposites() {
    composites = new ArrayList();
    for (int i = 0; i < 5; i++) {
      Sprite aux = new Sprite("img/composites/" + COMPOSITES[i]);
      if (i < 3)
        aux.setPosition(LEFT_ZONE.x, LEFT_ZONE.y);
      else
        aux.setPosition(RIGHT_ZONE.x, RIGHT_ZONE.y);
      aux.setId(str(i));
      composites.add(aux);
    }
  }

  //••••••••••••••••••••••••••••••••

  void loadHighlights() {

    highlights = new ArrayList();
    String[] data = null;

    data = loadStrings("data/highlights.txt");

    for (int i = 0; i < data.length; i ++) {
      String[] row = splitTokens(data[i], ",");
      Sprite aux = new Sprite("img/highlights/" + (i+1) + ".png");
      aux.setPosition(float(row[0]), float(row[1]) - ((800-768)/2));
      aux.setId(str(i));
      highlights.add(aux);
    }
  }

  //••••••••••••••••••••••••••••••••

  void sensorActivated(int i) {
    if (i>6) {
      objectActivated(i);
    } else {
      timeActivated(i);
    }
  }

  //••••••••••••••••••••••••••••••••

  void timeActivated(int i) {
    for (int j = 0; j < footprints.size(); j++) { // si hay otro tiempo presionado
      footprints.get(j).deActivate(); // lo apago
      mistery.get(j).deActivate();
    }
    footprints.get(i).activate();
    mistery.get(i).activate();

    for (int j = 0; j < composites.size(); j ++) {
      composites.get(j).deActivate();
    }

    for (int j = 0; j < a.size(); j++) {//apago todos los del izquierdo
      a.get(j).deActivate();
      s.get(j).deActivate();
      e.get(j).deActivate();
      m.get(j).deActivate();
      t.get(j).deActivate();
    }

    if (sensors.get(7).pressed == true) {
      e.get(i).activate();
    }  
    if (sensors.get(8).pressed == true) {
      s.get(i).activate();
    }  
    if (sensors.get(9).pressed == true) {
      a.get(i).activate();
    }  
    if (sensors.get(10).pressed == true) {
      t.get(i).activate();
    }  
    if (sensors.get(11).pressed == true) {
      m.get(i).activate();
    }
  }

  void objectActivated(int i) {
    if (i<10) { // si lado izquierdo
      for (int j = 0; j < 3; j++) {//apago todos los del izquierdo
        composites.get(j).deActivate();
      }
      for (int j = 0; j < a.size(); j++) {//apago todos los del izquierdo
        a.get(j).deActivate();
        s.get(j).deActivate();
        e.get(j).deActivate();
      }
    } else { // si lado derecho
      for (int j = 3; j < 5; j++) {//apago todos los del derecho
        composites.get(j).deActivate();
      }
      for (int j = 0; j < t.size(); j++) {//apago todos los del derecho
        t.get(j).deActivate();
        m.get(j).deActivate();
      }
    }

    boolean time_pressed = false;
    for (int j = 0; j < 7; j ++) { // si hay una fecha encendida
      if (sensors.get(j).pressed || sensors.get(j).clicked) {
        time_pressed = true;
        if (i == 7) {// enciendo vista detalle
          e.get(j).activate();
        } else if (i == 8) {
          s.get(j).activate();
        } else if (i == 9) {
          a.get(j).activate();
        } else if (i == 10) {
          t.get(j).activate();
        } else if (i == 11) {
          m.get(j).activate();
        }
      }
    }
    if (!time_pressed) {//sino
      composites.get(i-7).activate(); // enciendo vista general
    }
  }

  //••••••••••••••••••••••••••••••••

  void sensorReleased(int i) {

    if (i>6) {
      objectReleased(i);
    } else {
      timeReleased(i);
    }
  }

  //••••••••••••••••••••••••••••••••

  void timeReleased(int i) {
    mistery.get(i).deActivate();
    footprints.get(i).deActivate();

    for (int j = 0; j < e.size(); j ++) {
      e.get(j).deActivate();
      a.get(j).deActivate();
      t.get(j).deActivate();
      s.get(j).deActivate();
      m.get(j).deActivate();
    }

    for (int j = 7; j < sensors.size(); j ++ ) {
      if (sensors.get(j).pressed || sensors.get(j).clicked) {
        composites.get(j-7).activate();
      }
    }
  }

  //••••••••••••••••••••••••••••••••
  void objectReleased(int i) {
    if (i == 7) {
      for (int j = 0; j < e.size(); j++) {
        e.get(j).deActivate();
      }
      composites.get(0).deActivate();
    } else if (i == 8) {
      for (int j = 0; j < e.size(); j++) {
        s.get(j).deActivate();
      }
      composites.get(1).deActivate();
    } else if (i == 9) {
      for (int j = 0; j < e.size(); j++) {
        a.get(j).deActivate();
      }
      composites.get(2).deActivate();
    } else if (i == 10) {
      for (int j = 0; j < e.size(); j++) {
        t.get(j).deActivate();
      }
      composites.get(3).deActivate();
    } else if (i == 11) {
      for (int j = 0; j < e.size(); j++) {
        m.get(j).deActivate();
      }
      composites.get(4).deActivate();
    }
  }

  //••••••••••••••••••••••••••••••••

  void updateSprites() {
    for (int i = 0; i < mistery.size(); i++) {
      mistery.get(i).update();
      footprints.get(i).update();
    }

    for (int i = 0; i < composites.size(); i++) {
      composites.get(i).update();
      composites.get(i).update();
    }

    for (int i = 0; i < highlights.size(); i++) {
      highlights.get(i).update();
    }

    for (int j = 0; j < e.size(); j ++) {
      e.get(j).update();
      a.get(j).update();
      t.get(j).update();
      s.get(j).update();
      m.get(j).update();
    }
  }

  //••••••••••••••••••••••••••••••••

  void loadObjects() {

    a = new ArrayList();
    s = new ArrayList();
    e = new ArrayList();
    m = new ArrayList();
    t = new ArrayList();

    for (int i = 0; i < 7; i++) {
      Sprite aux = new Sprite("img/ambulancias/" + AMBULANCIAS[i]);
      aux.setPosition(LEFT_ZONE.x, LEFT_ZONE.y);
      aux.setId(str(i));
      a.add(aux);
      aux = new Sprite("img/estetoscopios/" + ESTETOSCOPIOS[i]);
      aux.setPosition(LEFT_ZONE.x, LEFT_ZONE.y);
      aux.setId(str(i));
      e.add(aux);
      aux = new Sprite("img/jeringas/" + JERINGAS[i]);
      aux.setPosition(LEFT_ZONE.x, LEFT_ZONE.y);
      aux.setId(str(i));
      s.add(aux);
      aux = new Sprite("img/tensiometros/" + TENSIOMETROS[i]);
      aux.setPosition(RIGHT_ZONE.x, RIGHT_ZONE.y);
      aux.setId(str(i));
      t.add(aux);
      aux = new Sprite("img/aspirinas/" + ASPIRINAS[i]);
      aux.setPosition(RIGHT_ZONE.x, RIGHT_ZONE.y);
      aux.setId(str(i));
      m.add(aux);
    }
  }

  //••••••••••••••••••••••••••••••••

  void checkSimulatedPress() {
    for (int i = 0; i < SIMULATORS.length; i++) {
      if (key == SIMULATORS[i] || key == SIMULATORS[i] - 32) {
        electrodeTouched(i);
      }
    }
  }

  //••••••••••••••••••••••••••••••••

  void checkSimulatedRelease() {
    for (int i = 0; i < SIMULATORS.length; i++) {
      if (key == SIMULATORS[i] || key == SIMULATORS[i] - 32) {
        electrodeReleased(i);
      }
    }
  }
}