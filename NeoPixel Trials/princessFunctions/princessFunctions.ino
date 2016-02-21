#include <Adafruit_NeoPixel.h>
#ifdef __AVR__
  #include <avr/power.h>
#endif

// Which pin on the Arduino is connected to the NeoPixels?
#define PIN            6

// How many NeoPixels are attached to the Arduino?
#define NUMPIXELS      150


Adafruit_NeoPixel pixels = Adafruit_NeoPixel(NUMPIXELS, PIN, NEO_GRB + NEO_KHZ800);

int delayval = 20; 

//Group Variable Declaration
//Group 1:
uint8_t r1 = 100;
uint8_t g1 = 100;
uint8_t b1 = 100;

//Group 2:
uint8_t r2 = 100;
uint8_t g2 = 100;
uint8_t b2 = 100;

//Group 3:
uint8_t r3 = 100;
uint8_t g3 = 100;
uint8_t b3 = 100;

//Group 4:
uint8_t r4 = 100;
uint8_t g4 = 100;
uint8_t b4 = 100;


void setup() {
  pixels.begin(); // This initializes the NeoPixel library.
}



void loop() {

  for(int i=0;i<NUMPIXELS;i++){
      // pixels.Color takes RGB values, from 0,0,0 up to 255,255,255
      pixels.setPixelColor(i, pixels.Color(0,0,0));
      pixels.show();
      delay(delayval);
    for(int j= 0;j<NUMPIXELS/4;j++){
      pixels.setPixelColor(j, pixels.Color(r1,g1,b1)); 
      pixels.show();
      delay(delayval);
    }
    for(int j= NUMPIXELS/4;j<NUMPIXELS/2;j++){
      pixels.setPixelColor(j, pixels.Color(r2,g2,b2));
      pixels.show(); 
      delay(delayval);
    }
    for(int j= NUMPIXELS/2;j<3*NUMPIXELS/4;j++){
      pixels.setPixelColor(j, pixels.Color(r3,g3,b3)); 
      pixels.show();
      delay(delayval);
    }
    for(int j= 3*NUMPIXELS/4;j<NUMPIXELS;j++){
      pixels.setPixelColor(j, pixels.Color(r4,g4,b4)); 
      pixels.show(); 
      delay(delayval);
    }
  }
}
