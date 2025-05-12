PShape drip;
ArrayList<Drop> drops;

Cup cup;
float cupWidth = 120;
float cupHeight = 100;

Bean bean;

ProgressBar progressbar;

void setup() {
  size(700, 550);
  drip = loadShape("file.svg");
  drops = new ArrayList<Drop>();
  cup = new Cup(width/2, height - 120, 120, 100);
  bean = new Bean();
  progressbar = new ProgressBar(100, 30, 200, 40);
}

void draw() { // 60 frames per sekund
  background(255); // Rensa skärmen

  // Draw Bean
  bean.draw();
  
  // Draw Cup
  cup.update();
  cup.display();
  
    // Update and draw all drops
  for (Drop d : drops) {
    d.update();
    d.display();
  }
  
  progressbar.display();
  
}

void mousePressed() {
  if (cup.isClicked(mouseX, mouseY)) {
    float spawnX = cup.x + random(-cup.width/4, cup.width/4);
    drops.add(new Drop(spawnX));
    cup.shake();
    progressbar.registerClick();
  }
}
