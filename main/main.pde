/*
 File: main.pde
 This is the main file to the game Coffee Clicker. It handles setup, initializing objects, drawing and eventhandling.
 
 Requires the following files:
 drop.svg
 click.mp3
 level_up.mp3
 yummy.mp3
 shop_item_2.mp3
 
 Version 0.1
 Author: Nora Angéus, Maria Eriksson, John McLelland, Tova Radhe
 */

// Importing sounds
import processing.sound.*;
SoundFile file;
SoundFile yummySound;

// Initialize drop variables
PShape drip;
ArrayList<Drop> drops;

// Initialize cup variables
Cup cup;
int clicks = 0;

// Initializing other objects
Bean bean;
ProgressBar progressbar;
Tracker tracker;
PShape shopIcon;
Shop shop;
PauseOverlay pauseOverlay;


// Three different screensizes
PVector smallSize = new PVector(350, 500); // Mobile view
PVector mediumSize = new PVector(700, 550); // Square-like view
PVector largeSize = new PVector(1200, 650); // Computer view
PVector screenSize;


// Method for settings of the game
void settings() {
  // Change to desired screensize: smallSize, mediumSize, largeSize
  screenSize = smallSize;
  size((int)screenSize.x, (int)screenSize.y);
}

// Creating game states and initializing game
final int STATE_START = 0;
final int STATE_TUTORIAL = 1;
final int STATE_GAME = 2;
int gameState = STATE_START;

// Tutorial variables
int tutorialStep = 0;
boolean tutorialComplete = false;

// Method for creating all object instances
void setup() {
  drip = loadShape("drop.svg");
  drops = new ArrayList<Drop>();
  cup = new Cup(width/2, height - height*0.4, height*0.25, height*0.2);
  bean = new Bean();
  progressbar = new ProgressBar(this, 0.27*width, 0.85*height, 0.45*width, 0.07*height);
  tracker = new Tracker(0.06*width, 0.06*height, clicks);

  file = new SoundFile(this, "click.mp3");
  yummySound = new SoundFile(this, "yummy.mp3");

  shopIcon = loadShape("shopIcon.svg");
  ShopItem[] shopItems = createIcons();
  shop = new Shop(this, width * 0.65, height * 0.01, width * 0.40, height * 0.09, shopItems);

  pauseOverlay = new PauseOverlay(width * 0.15, height * 0.1);
}


/* Method for drawing screen, 60 frames per second.
   First the startscreen will be displayed.
   Then if we are in tutorial mode, the tutorial will play out.
   If not, the gameScreen will be drawn as normal.*/
void draw() {
  background(255);

  if (gameState == STATE_START) {
    drawStartScreen();
  } else if (gameState == STATE_GAME) {
    if (!tutorialComplete) {
      drawTutorialScreen();
    } else {
      drawGameScreen();
    }
  }
}

// Method for start screen for the game
void drawStartScreen() {
  background(200, 220, 255);
  textAlign(CENTER, CENTER);
  textSize(height * 0.06); 
  fill(0);
  text(welcomeText, width/2, height/2 - 40);
  textSize(height * 0.05);
  text(pressToStart, width/2, height/2);
}


// Method for drawing the game screen
void drawGameScreen() {
  background(238, 217, 196);
  pushMatrix();

  /*Moving background */
  // Create variable that loops for rotating strokes
  float wave = 300*sin(radians(frameCount));

  // Incrementally redraw strokes to animate
  for (int i = 0; i <500; i++) {
    rotate(50);
    strokeWeight(height * 0.001);
    stroke(250, 240, 230);
    line(2000, i-wave/2, -2000, i++);
  }
  popMatrix();
  /* End of moving background */

  // If game is not paused, display as usual
  if (!pauseOverlay.getPaused()) {

    // Draw objects
    progressbar.display();
    shop.display(clicks);
    bean.beanDisplay();

    // The cup updates before drawing to create the shaking effect. It is then drawn in two steps.
    cup.update();
    cup.displayEllips(); //Cup draw 1: The ellipse displays before the drops to get layering effect

    // Update and draw all drops
    for (Drop d : drops) {
      d.update();
      d.display();
    }
    cup.displayRect(); //Cup draw 2: The cup's "body" is drawn later to make the drops "fall inside" the cup

    strokeWeight(height * 0.001); //Resetting the strokeWeight that the cup altered.

    // Add progressbar and click tracker
    progressbar.display();
    tracker.display();
  }

  // If game is paused, display pause screen
  pauseOverlay.updatePosition();
  // Always draw last to get "on top" of the layering
  pauseOverlay.display();
}

// Method for resetting the game, making new instances of the objects
void resetGame() {
  cup = new Cup(width/2, height - height*0.4, height*0.25, height*0.2);
  bean = new Bean();
  progressbar = new ProgressBar(this, 0.28*width, 0.85*height, 0.5*width, 0.07*height);
  tracker = new Tracker(0.06*width, 0.06*height, clicks);

  clicks = 0;
  tracker.clicks = 0;
  drops.clear();

  ShopItem[] shopItems = createIcons();
  shop = new Shop(this, width * 0.7, height * 0.05, width * 0.25, height * 0.09, shopItems);
}

// Method for getting keyboard inputs, only used in the startscreen
void keyPressed() {
  if (gameState == STATE_START) {
    if (key == ENTER || key == RETURN) {
      gameState = STATE_GAME;
    }
  }
}

// Event handler for when mouse is pressed
void mousePressed() {
  // Check if item was bought with click
  boolean bought = shop.tryPurchaseAt(mouseX, mouseY, clicks);
  if (bought) {
    shop.purchaseSound.play();
    return;
  }
  // Check if game was paused with click
  pauseOverlay.isClicked(mouseX, mouseY);
  if (pauseOverlay.getPaused()) return;

  // Easter egg: Sound if bean is clicked
  if (bean.beanIsClicked(mouseX, mouseY)) {
    yummySound.play();
  }
  // Check if cup was clicked. If so, register click
  if (cup.isClicked(mouseX, mouseY)) {
    float spawnX = cup.x + random(-cup.cupWidth / 4, cup.cupWidth / 4);
    drops.add(new Drop(spawnX));
    cup.shake();
    progressbar.registerClick();
    clicks++;
    tracker.registerClick();
    file.play();
  }
}
