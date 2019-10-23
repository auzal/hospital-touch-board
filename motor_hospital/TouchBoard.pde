import processing.serial.*;

final int baudRate = 57600;
final int numElectrodes = 12;

Serial inPort;  // the serial port
String inString; // input string from serial port
String[] splitString; // input string array after splitting
int[] status, lastStatus;


void initSerial() {
  
  REDIRECT = new int[12];
  
  REDIRECT[0] = 6;
  REDIRECT[1] = 5;
  REDIRECT[2] = 4;
  REDIRECT[3] = 11;
  REDIRECT[4] = 10;
  REDIRECT[5] = 9;
  REDIRECT[6] = 7;
  REDIRECT[7] = 3;
  REDIRECT[8] = 8;
  REDIRECT[9] = 2;
  REDIRECT[10] = 1;
  REDIRECT[11] = 0;
  
  SIMULATORS = new char[12];
  
  SIMULATORS[0] = 'z';
  SIMULATORS[1] = 'x';
  SIMULATORS[2] = 'c';
  SIMULATORS[3] = 'v';
  SIMULATORS[4] = 'b';
  SIMULATORS[5] = 'n';
  SIMULATORS[6] = 'm';
  SIMULATORS[7] = 't';
  SIMULATORS[8] = 'f';
  SIMULATORS[9] = 'g';
  SIMULATORS[10] = 'y';
  SIMULATORS[11] = 'h';


  status = new int[numElectrodes];
  lastStatus = new int[numElectrodes];
  printArray((Object[])Serial.list());
  
  PORTS = Serial.list();

  int port = 0;
  String[] data = null;
  try {
    data = loadStrings("data/portconfig.txt");
  }
  catch(Exception e) {
    println("No config file.");
  }
  if (data!=null) {

    String[] row = splitTokens(data[0], ":");
    port = int(float(row[1]));
    println("load successful, selected port:  " + port);
  }


  // change the 1 below to the number corresponding to the output of the command above
  inPort = null;
  try {
    inPort = new Serial(this, Serial.list()[port], baudRate);
    println("Atempting to open port: " + port);
  }
  catch(Exception   e) {
  }
  if (inPort != null)
    inPort.bufferUntil('\n');
}


void serialEvent(Serial p) {
  inString = p.readString();
  splitString = splitTokens(inString, ": ");
  if (splitString[0].equals("TOUCH")) {
    updateArraySerial(status);
  }

  for (int i = 0; i < numElectrodes; i++) {
    if (lastStatus[i] == 0 && status[i] == 1) {
      // touched
      manager.electrodeTouched(REDIRECT[i]);
      println("Electrode " + i + " was touched");
      println("activating sensor " + REDIRECT[i]);


      lastStatus[i] = 1;
    } else if (lastStatus[i] == 1 && status[i] == 0) {
      // released
      manager.electrodeReleased(REDIRECT[i]);
      println("Electrode " + i + " was released");

      lastStatus[i] = 0;
    }
  }
}

void updateArraySerial(int[] array) {
  if (array == null) {
    return;
  }
  for (int i = 0; i < min(array.length, splitString.length - 1); i++) {
    try {
      array[i] = Integer.parseInt(trim(splitString[i + 1]));
    } 
    catch (NumberFormatException e) {
      array[i] = 0;
    }
  }
}
