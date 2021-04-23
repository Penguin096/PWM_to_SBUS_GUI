import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import controlP5.*; 
import processing.serial.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class PWM_SBUS extends PApplet {

/**
 * ControlP5 Slider set value
 * changes the value of a slider on keyPressed
 *
 * by Andreas Schlegel, 2012
 * www.sojamo.de/libraries/controlP5
 *
 */




ControlP5 cp5;
Serial serial;                   //Define the variable port as a Serial object.
int port;
boolean theFlag = false;
int myColorBackground = 0xff827560;
char[] sbusData = new char[25];
int[] channels = new int[17];

public void setup() {
  
  background(myColorBackground);
  noStroke();
  cp5 = new ControlP5(this);
  InitSerial();
  InitSlider();
}

public void draw() {

  if (serial.available() > 0) {  // If data is available,

    if (theFlag) {
      background(myColorBackground);
      textSize(14);
      text(serial.read() + " mS", 300, 300);
    } else background(myColorBackground);

    if (serial.readChar() == 0x0F) {
      for (int i=1; i<25; i++) {
        sbusData[i] = serial.readChar();
      }

      channels[1]  = ((sbusData[1]|sbusData[2]<< 8) & 0x07FF);
      channels[2]  = ((sbusData[2]>>3|sbusData[3]<<5) & 0x07FF);
      channels[3]  = ((sbusData[3]>>6|sbusData[4]<<2|sbusData[5]<<10) & 0x07FF);
      channels[4]  = ((sbusData[5]>>1|sbusData[6]<<7) & 0x07FF);
      channels[5]  = ((sbusData[6]>>4|sbusData[7]<<4) & 0x07FF);
      channels[6]  = ((sbusData[7]>>7|sbusData[8]<<1|sbusData[9]<<9) & 0x07FF);
      channels[7]  = ((sbusData[9]>>2|sbusData[10]<<6) & 0x07FF);
      channels[8]  = ((sbusData[10]>>5|sbusData[11]<<3) & 0x07FF);
      channels[9]  = ((sbusData[12]|sbusData[13]<< 8) & 0x07FF);
      channels[10] = ((sbusData[13]>>3|sbusData[14]<<5) & 0x07FF);
      channels[11] = ((sbusData[14]>>6|sbusData[15]<<2|sbusData[16]<<10) & 0x07FF);
      channels[12] = ((sbusData[16]>>1|sbusData[17]<<7) & 0x07FF);
      channels[13] = ((sbusData[17]>>4|sbusData[18]<<4) & 0x07FF);
      channels[14] = ((sbusData[18]>>7|sbusData[19]<<1|sbusData[20]<<9) & 0x07FF);
      channels[15] = ((sbusData[20]>>2|sbusData[21]<<6) & 0x07FF);
      channels[16] = ((sbusData[21]>>5|sbusData[22]<<3) & 0x07FF);

      cp5.getController("1 CH").setValue(channels[1]);
      cp5.getController("2 CH").setValue(channels[2]);
      cp5.getController("3 CH").setValue(channels[3]);
      cp5.getController("4 CH").setValue(channels[4]);
      cp5.getController("5 CH").setValue(channels[5]);
      cp5.getController("6 CH").setValue(channels[6]);
      cp5.getController("7 CH").setValue(channels[7]);
      cp5.getController("8 CH").setValue(channels[8]);
      cp5.getController("9 CH").setValue(channels[9]);
      cp5.getController("10 CH").setValue(channels[10]);
      cp5.getController("11 CH").setValue(channels[11]);
      cp5.getController("12 CH").setValue(channels[12]);
      cp5.getController("13 CH").setValue(channels[13]);
      cp5.getController("14 CH").setValue(channels[14]);
      cp5.getController("15 CH").setValue(channels[15]);
      cp5.getController("16 CH").setValue(channels[16]);

      cp5.getController("Digital CH 1").setValue((sbusData[23] & 1));
      cp5.getController("Digital CH 2").setValue((sbusData[23] & 2)>>1);
      cp5.getController("Signal Loss").setValue((sbusData[23] & 4)>>2);
      cp5.getController("Fail safe").setValue((sbusData[23] & 8)>>3);

      serial.clear();
    }
  }
}
public void Debug(boolean Flag) {
  theFlag = Flag;
}

public void InitSerial() {
  String portPos = Serial.list()[1];
  serial = new Serial(this, portPos, 100000);
}

public void InitSlider() {
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
    .setColorBackground(0xff823030)
    .setColorForeground(0xffa82222)
    .setColorActive(0xffbf2222)
    //.setMode(ControlP5.SWITCH)
    ;
}
  public void settings() {  size(380, 360); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "PWM_SBUS" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
