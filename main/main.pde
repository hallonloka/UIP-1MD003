import processing.sound.*;
SoundFile file;
SoundFile yummySound;

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

PauseOverlay pauseOverlay;

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
  yummySound = new SoundFile(this, "yummy.mp3");

  shopIcon = loadShape("shopIcon.svg");
  ShopItem[] shopItems = createIcons();
  shop = new Shop(499, 10, 200, 50, shopItems);
  
  pauseOverlay = new PauseOverlay(80, 40);
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
    line(2000, i-wave/2, -2000, i++);
  }
  popMatrix(); //Return state from matrix stack

  if (!pauseOverlay.getPaused()) {
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
  pauseOverlay.updatePosition(); 
  pauseOverlay.display(); // alltid sist så den ritas överst
}

void resetGame() {
  cup = new Cup(width/2, height - height*0.4, 120, 100);
  bean = new Bean();
  progressbar = new ProgressBar(0.28*width, 0.85*height, 0.5*width, 0.07*height);
  tracker = new Tracker(0.06*width, 0.06*height, clicks);
  
  clicks = 0;
  playerClicks = 100;
  drops.clear();
  
  ShopItem[] shopItems = createIcons();
  shop = new Shop(499, 10, 200, 50, shopItems);

}

// Event handler for when cup is pressed
void mousePressed() {
  pauseOverlay.isClicked(mouseX, mouseY);
  if (pauseOverlay.getPaused()) return;
  
  if (cup.isClicked(mouseX, mouseY)) {
    float spawnX = cup.x + random(-cup.width/4, cup.width/4);
    drops.add(new Drop(spawnX));
    cup.shake();
    progressbar.registerClick();
    tracker.registerClick();
    file.play();
  }
  
  if (bean.beanIsClicked(mouseX, mouseY)) {
    yummySound.play();
  }
  
  shop.shopClick();
  
}
