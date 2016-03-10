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
int princessName = 3;

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


//Princess Numbers
// ariel = 1;
// jasmine = 2;
// rapunzel = 3;
// belle = 4;
// tiana = 5;
// elsa = 6;
// esmeralda = 7;
// pocahontas = 8;
// meg = 9;

void setup() {
  pixels.begin(); // This initializes the NeoPixel library.
}


uint8_t ariel[4][3] = {
  {50, 0, 100},
  {0, 0, 0},
  {10, 50, 17},
  {100, 100, 100}
};

uint8_t jasmine[4][3] = {
  {10, 30, 17},
  {0, 0, 0},
  {10, 30, 17},
  {100, 100, 100}
};

uint8_t rapunzel[4][3] = {
  {70, 0, 70},
  {70, 0, 70},
  {70, 0, 70},
  {100, 100, 100}
};

uint8_t belle[4][3] = {
  {100, 70, 10},
  {100, 70, 10},
  {100, 70, 0},
  {100, 100, 100}
};

uint8_t tiana[4][3] = {
  {140, 255, 0},
  {140, 255, 0},
  {140, 255, 0},
  {100, 100, 100}
};

uint8_t elsa[4][3] = { //this is special redo this later
  {50, 0, 100},
  {0, 0, 0},
  {10, 50, 17},
  {100, 100, 100}
};

uint8_t esmeralda[4][3] = { //need to input values
  {100, 100, 100},
  {100, 100, 100},
  {100, 100, 100},
  {100, 100, 100}
};

uint8_t pocahontas[4][3] = { //need to input values
  {100, 100, 100},
  {100, 100, 100},
  {100, 100, 100},
  {100, 100, 100}
};

uint8_t meg[4][3] = { //need to input values
  {100, 100, 100},
  {100, 100, 100},
  {100, 100, 100},
  {100, 100, 100}
};



void loop() {

  if (princessName == 1) { //ariel
     r1 = ariel[0][0];
     g1 = ariel[0][1];
     b1 = ariel[0][2];

    //Group 2:
     r2 = ariel[1][0];
     g2 = ariel[1][1];
     b2 = ariel[1][2];

    //Group 3:
     r3 = ariel[2][0];
     g3 = ariel[2][1];
     b3 = ariel[2][2];

    //Group 4:
     r4 = ariel[3][0];
     g4 = ariel[3][1];
     b4 = ariel[3][2];
  }
  if (princessName == 2) {
     r1 = jasmine[0][0];
     g1 = jasmine[0][1];
     b1 = jasmine[0][2];

    //Group 2:
     r2 = jasmine[1][0];
     g2 = jasmine[1][1];
     b2 = ariel[1][2];

    //Group 3:
     r3 = jasmine[2][0];
     g3 = jasmine[2][1];
     b3 = jasmine[2][2];

    //Group 4:
     r4 = jasmine[3][0];
     g4 = jasmine[3][1];
     b4 = jasmine[3][2];
  }
  if (princessName == 3) {
     r1 = rapunzel[0][0];
     g1 = rapunzel[0][1];
     b1 = rapunzel[0][2];

    //Group 2:
     r2 = rapunzel[1][0];
     g2 = rapunzel[1][1];
     b2 = rapunzel[1][2];

    //Group 3:
     r3 = rapunzel[2][0];
     g3 = rapunzel[2][1];
     b3 = rapunzel[2][2];

    //Group 4:
     r4 = rapunzel[3][0];
     g4 = rapunzel[3][1];
     b4 = rapunzel[3][2];
  }
  if (princessName == 4) {
     r1 = belle[0][0];
     g1 = belle[0][1];
     b1 = belle[0][2];

    //Group 2:
     r2 = belle[1][0];
     g2 = belle[1][1];
     b2 = belle[1][2];

    //Group 3:
     r3 = belle[2][0];
     g3 = belle[2][1];
     b3 = belle[2][2];

    //Group 4:
     r4 = belle[3][0];
     g4 = belle[3][1];
     b4 = belle[3][2];
  }
  if (princessName == 5) {
     r1 = tiana[0][0];
     g1 = tiana[0][1];
     b1 = tiana[0][2];

    //Group 2:
     r2 = tiana[1][0];
     g2 = tiana[1][1];
     b2 = tiana[1][2];

    //Group 3:
     r3 = tiana[2][0];
     g3 = tiana[2][1];
     b3 = tiana[2][2];

    //Group 4:
     r4 = tiana[3][0];
     g4 = tiana[3][1];
     b4 = tiana[3][2];
  }
  if (princessName == 6) { //ELSA IS SPESHUL
  
  }
  if (princessName == 7) {
     r1 = esmeralda[0][0];
     g1 = esmeralda[0][1];
     b1 = esmeralda[0][2];

    //Group 2:
     r2 = esmeralda[1][0];
     g2 = esmeralda[1][1];
     b2 = esmeralda[1][2];

    //Group 3:
     r3 = esmeralda[2][0];
     g3 = esmeralda[2][1];
     b3 = esmeralda[2][2];

    //Group 4:
     r4 = esmeralda[3][0];
     g4 = esmeralda[3][1];
     b4 = esmeralda[3][2];
  }
  if (princessName == 8) {
     r1 = pocahontas[0][0];
     g1 = pocahontas[0][1];
     b1 = pocahontas[0][2];

    //Group 2:
     r2 = pocahontas[1][0];
     g2 = pocahontas[1][1];
     b2 = pocahontas[1][2];

    //Group 3:
     r3 = pocahontas[2][0];
     g3 = pocahontas[2][1];
     b3 = pocahontas[2][2];

    //Group 4:
     r4 = pocahontas[3][0];
     g4 = pocahontas[3][1];
     b4 = pocahontas[3][2];
  }
  if (princessName == 9) {
     r1 = meg[0][0];
     g1 = meg[0][1];
     b1 = meg[0][2];

    //Group 2:
     r2 = meg[1][0];
     g2 = meg[1][1];
     b2 = meg[1][2];

    //Group 3:
     r3 = meg[2][0];
     g3 = meg[2][1];
     b3 = meg[2][2];

    //Group 4:
     r4 = meg[3][0];
     g4 = meg[3][1];
     b4 = meg[3][2];
  }

  princessRGB();

  
}


//princess split function
void princessRGB() {
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




