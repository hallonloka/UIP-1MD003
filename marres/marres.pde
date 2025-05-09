float angle = 0;         // Nuvarande rotationsvinkel för koppen
boolean shaking = false; // Om koppen skakar
int shakeFrame = 0;      // Steg i skakningen

float beanAngle = 0;     // För kaffebönans rörelse

PShape drip;
ArrayList<Drop> drops;

Cup cup;
float cupWidth = 120;
float cupHeight = 100;

void setup() {
  size(800, 600);
  drip = loadShape("file.svg");
  drops = new ArrayList<Drop>();
  cup = new Cup(width/2, height - 120, 120, 100);
}

void draw() { // 60 frames per sekund
  background(255); // Rensa skärmen

  // Rita kaffebönan
  drawBean();
  
  cup.update();
  cup.display();
  
    // Update and draw all drops
  for (Drop d : drops) {
    d.update();
    d.display();
  }
  
}

void mousePressed() {
  if (cup.isClicked(mouseX, mouseY) && !cup.shaking) {
    float spawnX = cup.x + random(-cup.width/4, cup.width/4);
    drops.add(new Drop(spawnX));
    cup.shake();
  }
}
