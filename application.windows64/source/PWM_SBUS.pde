/**
 * ControlP5 Slider set value
 * changes the value of a slider on keyPressed
 *
 * by Andreas Schlegel, 2012
 * www.sojamo.de/libraries/controlP5
 *
 */

import controlP5.*;
import processing.serial.*;

ControlP5 cp5;
Serial serial;                   //Define the variable port as a Serial object.
int port;
boolean theFlag = false;
int myColorBackground = #827560;

void setup() {
  size(380, 360);
  background(myColorBackground);
  noStroke();
  cp5 = new ControlP5(this);
  InitSerial();
  InitSlider();
}

void draw() {

  if (serial.available() > 0) {  // If data is available,
    if (theFlag) {
      background(myColorBackground);
      textSize(14);
      text(serial.read() + " mS", 300, 300);
    }else background(myColorBackground);
    
    if (serial.readChar() == 0x0F) {
      char a = serial.readChar();
      char b = serial.readChar();
      char c;
      cp5.getController("1 CH").setValue(((b & 7) << 8) | a);
      a = serial.readChar();
      cp5.getController("2 CH").setValue(((a & 63) << 5) | ((b & 248) >> 3));
      b = serial.readChar();
      c = serial.readChar();
      cp5.getController("3 CH").setValue(((c & 1) << 10) | (b << 2) | ((a & 192) >> 6));
      a = serial.readChar();
      cp5.getController("4 CH").setValue(((a & 15) << 7) | ((c & 254) >> 1));
      b = serial.readChar();
      cp5.getController("5 CH").setValue(((b & 127) << 4) | ((a & 240) >> 4));
      a = serial.readChar();
      c = serial.readChar();
      cp5.getController("6 CH").setValue(((c & 3) << 9) | (a << 1) | ((b & 128) >> 7));
      b = serial.readChar();
      cp5.getController("7 CH").setValue(((b & 31) << 6) | ((c & 252) >> 2));
      a = serial.readChar();
      cp5.getController("8 CH").setValue((a << 3) | ((b & 224) >> 5));
      a = serial.readChar();
      b = serial.readChar();
      cp5.getController("9 CH").setValue(((b & 7) << 8) | a);
      a = serial.readChar();
      cp5.getController("10 CH").setValue(((a & 63) << 5) | ((b & 248) >> 3));
      b = serial.readChar();
      c = serial.readChar();
      cp5.getController("11 CH").setValue(((c & 1) << 10) | (b << 2) | ((a & 192) >> 6));
      a = serial.readChar();
      cp5.getController("12 CH").setValue(((a & 15) << 7) | ((c & 254) >> 1));
      b = serial.readChar();
      cp5.getController("13 CH").setValue(((b & 127) << 4) | ((a & 240) >> 4));
      a = serial.readChar();
      c = serial.readChar();
      cp5.getController("14 CH").setValue(((c & 3) << 9) | (a << 1) | ((b & 128) >> 7));
      b = serial.readChar();
      cp5.getController("15 CH").setValue(((b & 31) << 6) | ((c & 252) >> 2));
      a = serial.readChar();
      cp5.getController("16 CH").setValue((a << 3) | ((b & 224) >> 5));

      a = serial.readChar(); // FLAGS
      cp5.getController("Digital CH 1").setValue((a & 1));
      cp5.getController("Digital CH 2").setValue((a & 2)>>1);
      cp5.getController("Signal Loss").setValue((a & 4)>>2);
      cp5.getController("Fail safe").setValue((a & 8)>>3);

      b = serial.readChar(); // 00
    }
  }
}
void Debug(boolean Flag) {
  theFlag = Flag;
}

void InitSerial() {
  String portPos = Serial.list()[1];
  serial = new Serial(this, portPos, 100000);
}

void InitSlider() {
  cp5.addSlider("1 CH")
    .setRange(173, 1811)
    .setValue(173)
    .setPosition(20, 20)
    .setSize(200, 10)

    .setSliderMode(Slider.FLEXIBLE)
    .lock();

  cp5.addSlider("2 CH")
    .setRange(173, 1811)
    .setValue(173)
    .setPosition(20, 40)
    .setSize(200, 10)

    .setSliderMode(Slider.FLEXIBLE) 
    .lock();

  cp5.addSlider("3 CH")
    .setRange(173, 1811)
    .setValue(173)
    .setPosition(20, 60)
    .setSize(200, 10)

    .setSliderMode(Slider.FLEXIBLE)   
    .lock();

  cp5.addSlider("4 CH")
    .setRange(173, 1811)
    .setValue(173)
    .setPosition(20, 80)
    .setSize(200, 10)

    .setSliderMode(Slider.FLEXIBLE)  
    .lock();

  cp5.addSlider("5 CH")
    .setRange(173, 1811)
    .setValue(173)
    .setPosition(20, 100)
    .setSize(200, 10)

    .setSliderMode(Slider.FLEXIBLE) 
    .lock();

  cp5.addSlider("6 CH")
    .setRange(173, 1811)
    .setValue(173)
    .setPosition(20, 120)
    .setSize(200, 10)

    .setSliderMode(Slider.FLEXIBLE) 
    .lock();

  cp5.addSlider("7 CH")
    .setRange(173, 1811)
    .setValue(173)
    .setPosition(20, 140)
    .setSize(200, 10)

    .setSliderMode(Slider.FLEXIBLE) 
    .lock();

  cp5.addSlider("8 CH")
    .setRange(173, 1811)
    .setValue(173)
    .setPosition(20, 160)
    .setSize(200, 10)

    .setSliderMode(Slider.FLEXIBLE)
    .lock();

  cp5.addSlider("9 CH")
    .setRange(173, 1811)
    .setValue(173)
    .setPosition(20, 180)
    .setSize(200, 10)

    .setSliderMode(Slider.FLEXIBLE)
    .lock();

  cp5.addSlider("10 CH")
    .setRange(173, 1811)
    .setValue(173)
    .setPosition(20, 200)
    .setSize(200, 10)

    .setSliderMode(Slider.FLEXIBLE)
    .lock();

  cp5.addSlider("11 CH")
    .setRange(173, 1811)
    .setValue(173)
    .setPosition(20, 220)
    .setSize(200, 10)

    .setSliderMode(Slider.FLEXIBLE)
    .lock();

  cp5.addSlider("12 CH")
    .setRange(173, 1811)
    .setValue(173)
    .setPosition(20, 240)
    .setSize(200, 10)

    .setSliderMode(Slider.FLEXIBLE)
    .lock();

  cp5.addSlider("13 CH")
    .setRange(173, 1811)
    .setValue(173)
    .setPosition(20, 260)
    .setSize(200, 10)

    .setSliderMode(Slider.FLEXIBLE)
    .lock();

  cp5.addSlider("14 CH")
    .setRange(173, 1811)
    .setValue(173)
    .setPosition(20, 280)
    .setSize(200, 10)

    .setSliderMode(Slider.FLEXIBLE)
    .lock();

  cp5.addSlider("15 CH")
    .setRange(173, 1811)
    .setValue(173)
    .setPosition(20, 300)
    .setSize(200, 10)

    .setSliderMode(Slider.FLEXIBLE)
    .lock();

  cp5.addSlider("16 CH")
    .setRange(173, 1811)
    .setValue(173)
    .setPosition(20, 320)
    .setSize(200, 10)

    .setSliderMode(Slider.FLEXIBLE)
    .lock();

  cp5.addToggle("Digital CH 1")
    .setPosition(300, 20)
    .setSize(50, 20)
    .lock();

  cp5.addToggle("Digital CH 2")
    .setPosition(300, 70)
    .setSize(50, 20)
    .lock();

  cp5.addToggle("Signal Loss")
    .setPosition(300, 120)
    .setSize(50, 20)
    .lock();

  cp5.addToggle("Fail safe")
    .setPosition(300, 170)
    .setSize(50, 20)
    .lock();

  cp5.addToggle("Debug")
    .setPosition(300, 250)
    .setSize(50, 20)
    .setValue(false)
    .setColorBackground(#823030)
    .setColorForeground(#a82222)
    .setColorActive(#bf2222)
    //.setMode(ControlP5.SWITCH)
    ;
}
