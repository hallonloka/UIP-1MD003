import processing.sound.*;
SoundFile file;

PShape drip;
ArrayList<Drop> drops;

Cup cup;
float cupWidth = 120;
float cupHeight = 100;
int clicks = 0;

Bean bean;

ProgressBar progressbar;

Tracker tracker;

PShape shopIcon;
Shop shop;

void setup() {
  size(700, 550);
  drip = loadShape("drop.svg");
  drops = new ArrayList<Drop>();
  cup = new Cup(width/2, height - 120, 120, 100);
  bean = new Bean();
  progressbar = new ProgressBar(this, 30, 100, 200, 40);
  tracker = new Tracker(100, 120, clicks);

  file = new SoundFile(this, "click.mp3");

  shopIcon = loadShape("shopIcon.svg");
  ShopItem[] shopItems = createIcons();
  shop = new Shop(this, 499, 10, 200, 50, shopItems);
}

void draw() { // 60 frames per second
  background(238, 217, 196);

  pushMatrix(); //Save current state to matrix stack
  // Create variable that loops for rotating strokes
  float wave = 300*sin(radians(frameCount));

  // Incrementally redraw strokes to animate
  for (int i = 0; i <500; i++) {
    rotate(50);
    strokeWeight(1);
    stroke(250, 240, 230);
    line(850, i-wave/2, -850, i++);
  }
  popMatrix(); //Return state from matrix stack

  //Draw Progressbar
  progressbar.display();

  //Draw shop
  shop.display(clicks);

  // Draw Bean
  bean.draw();

  // Draw Cup
  cup.update();
  cup.displayEllips();
  // Update and draw all drops
  for (Drop d : drops) {
    d.update();
    d.display();
  }
  cup.displayRect();

  strokeWeight(1);
  // Add progressbar and click tracker
  progressbar.display();
  tracker.display();
}

// Event handler for when cup is pressed
void mousePressed() {
  if (cup.isClicked(mouseX, mouseY)) {
    float spawnX = cup.x + random(-cup.width/4, cup.width/4);
    drops.add(new Drop(spawnX));
    cup.shake();
    progressbar.registerClick();
    clicks++;
    tracker.registerClick();
    file.play();
  }
  shop.shopClick();
}
