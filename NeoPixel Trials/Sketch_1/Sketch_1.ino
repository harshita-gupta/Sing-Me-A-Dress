#include <Adafruit_NeoPixel.h>
#ifdef __AVR__
  #include <avr/power.h>
#endif

#define PIN 6

Adafruit_NeoPixel strip = Adafruit_NeoPixel(150, PIN, NEO_GRB + NEO_KHZ800);


void setup() {
  strip.begin();
  strip.show(); // Initialize all pixels to 'off'

}

void loop() {
  strip.setPixelColor(4, 255, 0, 0);
}
