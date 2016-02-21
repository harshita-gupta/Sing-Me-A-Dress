#include <Adafruit_NeoPixel.h>
#ifdef __AVR__
  #include <avr/power.h>
#endif

#define PIN 6

Adafruit_NeoPixel strip = Adafruit_NeoPixel(150, PIN, NEO_GRB + NEO_KHZ800);

//uint8_t diff[] = {25, 25, -75}; 
//uint16_t r = 25, g = 75, b = 50;
//uint8_t elsaTop[]= {25, 75, 50};
//uint8_t elsaBottom[] = {0, 50, 125};
//uint8_t elsaGradient[] = {r, g, b};

uint8_t numPixels = 150;


uint8_t rStart = 255;
uint8_t gStart = 255;
uint8_t bStart = 255;
uint8_t rEnd = 0;
uint8_t gEnd = 100;
uint8_t bEnd = 255;
double rInc = (rStart - rEnd)/numPixels;
double gInc =  (gStart - gEnd)/numPixels;
double bInc =  (bStart - bEnd)/numPixels;




void setup() {
  strip.begin();
//  strip.show(); // Initialize all pixels to 'off'

}

void loop() {

double rCurr = rStart;
double gCurr = gStart;
double bCurr = bStart;

uint16_t i;



for (i=0; i<150; i++) {
  strip.setPixelColor(i, uint8_t(rCurr), uint8_t(gCurr), uint8_t(bCurr));
  rCurr = rCurr + rInc;
  gCurr = gCurr + gInc;
  bCurr = bCurr + bInc;
  strip.show();
}

//  for (int j = 0; j < strip.numPixels(); j = j + (strip.numPixels() / diff[i])) {
//   elsaGradient[1] = elsaGradient[1] + 1;
//   elsaGradient[2] = elsaGradient[2] + 1;
//   elsaGradient[3] = elsaGradient[3] + 1;
//
//   }
//   strip.setPixelColor(strip.numPixels(), elsaGradient[1], elsaGradient[2], elsaGradient[3]);
//  }
    delay(500);
    
}

