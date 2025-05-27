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
int playerClicks = 100; //TODO: Placeholder for clicks

//

//Vi skapar 3 förbestämda skärmstorlekar. Går 100% att ändra
PVector smallSize = new PVector(350, 500); //mobil-vibe
PVector mediumSize = new PVector(700, 550); //det som varit satt i main under development
PVector largeSize = new PVector(1200, 650); //"fullscreen" på datorn   
PVector screenSize;

void settings(){
  screenSize = mediumSize;  //byt till önskad skärmstorlek. small, medium eller large
  size((int)screenSize.x, (int)screenSize.y);
}

void setup() {
  drip = loadShape("drop.svg");
  drops = new ArrayList<Drop>();
  cup = new Cup(width/2, height - height*0.4, 120, 100);
  bean = new Bean();
  progressbar = new ProgressBar(0.28*width, 0.85*height, 0.5*width, 0.07*height);
  tracker = new Tracker(0.06*width, 0.06*height, clicks);

  file = new SoundFile(this, "click.mp3");

  shopIcon = loadShape("shopIcon.svg");
  ShopItem[] shopItems = createIcons();
  shop = new Shop(499, 10, 200, 50, shopItems);
}

void draw() { // 60 frames per second
  background(238, 217, 196);

  drawBackground();

  //Draw Progressbar
  progressbar.display();

  //Draw shop
  shop.display(playerClicks);

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
    tracker.registerClick();
    file.play();
  }
  shop.shopClick();
}
