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
boolean theSBUS = false;
int myColorBackground = #827560;
char[] sbusData = new char[25];
int[] channels = new int[17];

// #PS
// Выбор портов ---------------------------------------------------

// Номер выбранного порта
int selectedPortNum = 0;

// Флаг Порт выбран
boolean portSelected = false;

// Предыдущее количество портов
// нужно для автоматического обновления списков
int currentCountOfPorts = Serial.list().length;
int prevCountOfPorts = currentCountOfPorts;

// координаты меню селектора
int portListX = 50;
int portListY = 50;
int refreshBtnX = portListX + 250;
int refreshBtnY = portListY;

void setup() {
  size(380, 360);
  background(myColorBackground);
  noStroke();
  cp5 = new ControlP5(this);
  InitSlider();
}

void draw() {

  background(myColorBackground);

  // Если порт выбран 
  if (portSelected) {

    if (theSBUS) {
      sbusData = null;
      char[] sbusData = new char[25];//Zero out packet data

      sbusData[0] = 0x0F;          //Header
      sbusData[24] = 0x00;         //Footer 0x00 for SBUS

      int SBUS_Current_Packet_Bit = 0;
      int SBUS_Packet_Position = 1;

      for (int SBUS_Current_Channel = 1; SBUS_Current_Channel < 17; SBUS_Current_Channel++) {

        int sbusval;
        sbusval =  (int)cp5.getController(SBUS_Current_Channel + " CH").getValue();

        for (int SBUS_Current_Channel_Bit = 0; SBUS_Current_Channel_Bit < 11; SBUS_Current_Channel_Bit++) {
          if (SBUS_Current_Packet_Bit > 7) {
            SBUS_Current_Packet_Bit = 0;  //If we just set bit 7 in a previous step, reset the packet bit to 0 and
            SBUS_Packet_Position++;       //Move to the next packet uint8_t
          }
          sbusData[SBUS_Packet_Position] |= (((sbusval >> SBUS_Current_Channel_Bit) & 0x1) << SBUS_Current_Packet_Bit);  //Downshift the channel data bit, then upshift it to set the packet data uint8_t
          SBUS_Current_Packet_Bit++;
        }
      }

      if (0==1) sbusData[23] |= (1 << 0);
      if (1==1) sbusData[23] |= (1 << 1);
      if (0==1) sbusData[23] |= (1 << 2);
      if (0==1) sbusData[23] |= (1 << 3);

      if (cp5.getController("Digital CH 1").getValue() >= 1) sbusData[23] |= (1 << 0);
      if (cp5.getController("Digital CH 2").getValue() >= 1) sbusData[23] |= (1 << 1);
      if (cp5.getController("Signal Loss").getValue() >= 1)  sbusData[23] |= (1 << 2);
      if (cp5.getController("Fail safe").getValue() >= 1)    sbusData[23] |= (1 << 3);

      for (int i = 0; i < 25; i++) {
        serial.write(sbusData[i]);
      }
      delay(14);
    } else {
      if (serial.available() > 0) {  // If data is available,

        if (theFlag) {        
          textSize(14);
          text(serial.read() + " mS", 310, 270);
        } //else background(myColorBackground);

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
        }
        serial.clear();
      }
    }
  } else {
    // сравнение числа портов
    currentCountOfPorts = Serial.list().length;
    if (prevCountOfPorts != currentCountOfPorts) {
      // Обновление списка портов
      cp5.get(ScrollableList.class, "Select COM port").clear();
      cp5.get(ScrollableList.class, "Select COM port").setItems(Serial.list());
      prevCountOfPorts = currentCountOfPorts;
    }
  }
}

void controlEvent(ControlEvent theEvent) {
  // Выбор порта
  if (theEvent.getController().getId() == 1) {
    selectedPortNum = (int)theEvent.getController().getValue();
    // остановка ранее подключенного порта
    if (serial != null)
      serial.stop();
    // подключение к выбранному порту
    serial = new Serial(this, Serial.list()[selectedPortNum], 100000, 'E', 8, 1.0);
    //serial = new Serial(this, Serial.list()[selectedPortNum], 100000);
    portSelected = true;
    cp5.get(ScrollableList.class, "Select COM port").close();
  }
} // Конец controlEvent

void Debug(boolean Flag) {
  theFlag = Flag;
}

void SBUS_IN_OUT(boolean SBUS) {
  theSBUS = SBUS;
}

void InitSlider() {
  cp5.addSlider("1 CH")
    .setRange(173, 1811)
    .setValue(173)
    .setPosition(20, 20)
    .setSize(200, 10)

    .setSliderMode(Slider.FLEXIBLE)
    //.lock();
    ;

  cp5.addSlider("2 CH")
    .setRange(173, 1811)
    .setValue(173)
    .setPosition(20, 40)
    .setSize(200, 10)

    .setSliderMode(Slider.FLEXIBLE) 
    //.lock();
    ;

  cp5.addSlider("3 CH")
    .setRange(173, 1811)
    .setValue(173)
    .setPosition(20, 60)
    .setSize(200, 10)

    .setSliderMode(Slider.FLEXIBLE)   
    //.lock();
    ;

  cp5.addSlider("4 CH")
    .setRange(173, 1811)
    .setValue(173)
    .setPosition(20, 80)
    .setSize(200, 10)

    .setSliderMode(Slider.FLEXIBLE)  
    //.lock();
    ;

  cp5.addSlider("5 CH")
    .setRange(173, 1811)
    .setValue(173)
    .setPosition(20, 100)
    .setSize(200, 10)

    .setSliderMode(Slider.FLEXIBLE) 
    //.lock();
    ;

  cp5.addSlider("6 CH")
    .setRange(173, 1811)
    .setValue(173)
    .setPosition(20, 120)
    .setSize(200, 10)

    .setSliderMode(Slider.FLEXIBLE) 
    //.lock();
    ;

  cp5.addSlider("7 CH")
    .setRange(173, 1811)
    .setValue(173)
    .setPosition(20, 140)
    .setSize(200, 10)

    .setSliderMode(Slider.FLEXIBLE) 
    //.lock();
    ;

  cp5.addSlider("8 CH")
    .setRange(173, 1811)
    .setValue(173)
    .setPosition(20, 160)
    .setSize(200, 10)

    .setSliderMode(Slider.FLEXIBLE)
    //.lock();
    ;

  cp5.addSlider("9 CH")
    .setRange(173, 1811)
    .setValue(173)
    .setPosition(20, 180)
    .setSize(200, 10)

    .setSliderMode(Slider.FLEXIBLE)
    //.lock();
    ;

  cp5.addSlider("10 CH")
    .setRange(173, 1811)
    .setValue(173)
    .setPosition(20, 200)
    .setSize(200, 10)

    .setSliderMode(Slider.FLEXIBLE)
    //.lock();
    ;

  cp5.addSlider("11 CH")
    .setRange(173, 1811)
    .setValue(173)
    .setPosition(20, 220)
    .setSize(200, 10)

    .setSliderMode(Slider.FLEXIBLE)
    //.lock();
    ;

  cp5.addSlider("12 CH")
    .setRange(173, 1811)
    .setValue(173)
    .setPosition(20, 240)
    .setSize(200, 10)

    .setSliderMode(Slider.FLEXIBLE)
    //.lock();
    ;

  cp5.addSlider("13 CH")
    .setRange(173, 1811)
    .setValue(173)
    .setPosition(20, 260)
    .setSize(200, 10)

    .setSliderMode(Slider.FLEXIBLE)
    //.lock();
    ;

  cp5.addSlider("14 CH")
    .setRange(173, 1811)
    .setValue(173)
    .setPosition(20, 280)
    .setSize(200, 10)

    .setSliderMode(Slider.FLEXIBLE)
    //.lock();
    ;

  cp5.addSlider("15 CH")
    .setRange(173, 1811)
    .setValue(173)
    .setPosition(20, 300)
    .setSize(200, 10)

    .setSliderMode(Slider.FLEXIBLE)
    //.lock();
    ;

  cp5.addSlider("16 CH")
    .setRange(173, 1811)
    .setValue(173)
    .setPosition(20, 320)
    .setSize(200, 10)

    .setSliderMode(Slider.FLEXIBLE)
    //.lock();
    ;

  cp5.addToggle("Digital CH 1")
    .setPosition(300, 60)
    .setSize(50, 20)
    //.lock();
    ;

  cp5.addToggle("Digital CH 2")
    .setPosition(300, 110)
    .setSize(50, 20)
    //.lock();
    ;

  cp5.addToggle("Signal Loss")
    .setPosition(300, 160)
    .setSize(50, 20)
    //.lock();
    ;

  cp5.addToggle("Fail safe")
    .setPosition(300, 210)
    .setSize(50, 20)
    //.lock();
    ;

  cp5.addToggle("Debug")
    .setPosition(300, 260)
    .setSize(50, 20)
    .setValue(false)
    .setColorBackground(#823030)
    .setColorForeground(#a82222)
    .setColorActive(#bf2222)
    //.setMode(ControlP5.SWITCH)
    ;

  cp5.addToggle("SBUS_IN_OUT")
    .setPosition(300, 295)
    .setSize(50, 20)
    .setValue(false)
    .setColorBackground(#823030)
    .setColorForeground(#a82222)
    .setColorActive(#bf2222)
    //.setMode(ControlP5.SWITCH)
    ;

  // #ID1
  // Меню с выбором из списка доступных портов
  cp5.addScrollableList("Select COM port")
    .setPosition(280, 20)
    .setSize(85, 100)
    .setBarHeight(20)
    .setItemHeight(20)
    .addItems(Serial.list())
    .setId(1)
    .setType(ScrollableList.LIST) // currently supported DROPDOWN and LIST
    .close();
  ;
}
