float angle = 0;         // Nuvarande rotationsvinkel för koppen
boolean shaking = false; // Om koppen skakar
int shakeFrame = 0;      // Steg i skakningen

float beanAngle = 0;     // För kaffebönans rörelse

PShape drip;
ArrayList<Drop> drops;

float cupWidth = 120;
float cupHeight = 100;

void setup() {
  size(800, 600);
  drip = loadShape("file.svg");
  drops = new ArrayList<Drop>();
}

void draw() { // 60 frames per sekund
  background(255); // Rensa skärmen

  // Rita kaffebönan
  drawBean();

  // Rita koppen
  drawCup();
  
    // Update and draw all drops
  for (Drop d : drops) {
    d.update();
    d.display();
  }
  
}

void mousePressed() {
 cupPressed(drops); 
 
}
