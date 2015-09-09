/*
Sending MIDI messages .
1) Select MIDI device you want to send to.
    - Run the sketch and check console for list of available devices
    - change line 70 of this sketch with the number of device ou want to select:
      e.g. mymididevice = RWMidi.getOutputDevices()[0].createOutput(); // listen to device number 1
      e.g. mymididevice = RWMidi.getOutputDevices()[1].createOutput(); // listen to device number 0

2) Play any MIDI message from you device and see the console output
*/

import rwmidi.*;  

byte mysysexmsg[] = {(byte)240, 127,3, 4, 5, 6, (byte)247};

MidiOutput mymididevice; 
PFont f;

int mboolval;

void setup() { 
  
  size(570, 300); 
  smooth(); 
  background(255); 
  
// Code for creating a nice interface..i.e. color and displyed text  

  f = createFont("Arial",12,true);
  
  fill(200, 0, 0, 150);
  rect(0,50, 140, 150);
  fill(0, 200, 0, 150);
  rect(140,50, 140, 150);
  fill(0, 0, 200, 150);
  rect(280,50, 150, 150);
  fill(210, 200, 0, 150);
  rect(430,50, 140, 150);
  
  textFont(f,12);                 
  fill(0);  
  text("Instructions",20,225);
  text("1)Select MIDI port number in the sketch (line 70)",20,250);
  text("2)Mouse click on a rectangle area above to send a midi message",20,270);
  
  
  textFont(f,16);                 
  fill(0);                        
  text("note on/off",20,130);
  textFont(f,16);                 
  fill(0);                        
  text("control change",160,130);
  textFont(f,16);                 
  fill(0);                        
  text("program change",300,130);
  textFont(f,16);                 
  fill(0);                        
  text("sys exclusive",450,130);

// end of interface....
    
// Show available MIDI output devices in console 
  MidiOutputDevice devices[] = RWMidi.getOutputDevices();
  
    for (int i = 0; i < devices.length; i++) { 
      println(i + ": " + devices[i].getName()); 
    } 

// Currently we assume the first device (#0) is the one we want 
  mymididevice = RWMidi.getOutputDevices()[0].createOutput(); 

} 
void draw(){
 
  if (mouseX < 140 && mouseX > 0 && mboolval == 1){

      mymididevice.sendNoteOn(1,70,1);
      mymididevice.sendNoteOff(1,70,0);
      mboolval = 0;

  } else if (mouseX < 280 && mouseX > 140 && mboolval == 1){
      mymididevice.sendController(1,7,127);
      mboolval = 0;
  } else if (mouseX < 430 && mouseX > 280 && mboolval == 1){
      mymididevice.sendProgramChange(17);
      mboolval = 0;
  } else if (mouseX < 570 && mouseX > 430 && mboolval == 1){
      //mymididevice.sendSysex(mysysexmsg);
      mymididevice.sendSysex(new byte[] {(byte)0xF0, 11, 2, 3, 4, 5, (byte)0xF7});
      mboolval = 0;
  }


}

void mouseClicked(){
  mboolval =1;
  // mymididevice.sendNoteOn(1,70,1);
}
 