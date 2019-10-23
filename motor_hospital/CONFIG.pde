int SENSORS = 12;
int SENSOR_PRESSED_TIMEOUT = 250;

PVector LEFT_ZONE = new PVector(30, 257);
PVector LEFT_ZONE_DIM = new PVector(350, 395);

PVector RIGHT_ZONE = new PVector(899, 257);
PVector RIGHT_ZONE_DIM = new PVector(348, 395);

PVector FOOTPRINT_ZONE = new PVector(899, 30);
PVector FOOTPRINT_ZONE_DIM = new PVector(348, 196);  

PVector MISTERY_ZONE = new PVector(410, 30);
PVector MISTERY_ZONE_DIM = new PVector(458, 310);

int MISTERY_TIME = 2000;
int MISTERY_ANIMATION_TIME = 1000;

boolean SHOW_MISTERY_GRADIENT = false;

int HAND_FLY_TIME = 2000;
int HAND_IDLE_TIME = 500;
int HAND_BLIP_TIME = 700;
int HAND_FADE_TIME = 300;
int HAND_Y_OFFSET = 30;

int HAND_IDLE_TIMEOUT = 15000;

String [] PORTS;
int [] REDIRECT;
char [] SIMULATORS;
