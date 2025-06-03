/*
 File: main.pde
 This is the main file to the game Coffee Clicker. It handles setup, initializing objects, drawing and eventhandling.
 
 Requires the following files:
 drop.svg
 click.mp3
 level_up.mp3
 yummy.mp3
 shop_item1.mp3
 
 Version 0.1
 Author: Group xx
 */

// Importing sounds
import processing.sound.*;
SoundFile file;
SoundFile yummySound;

// Initialize variables
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
PVector smallSize = new PVector(350, 500); //mobile view
PVector mediumSize = new PVector(700, 550); //square-like view
PVector largeSize = new PVector(1200, 650); //Computer view
PVector screenSize;


// Settings of the game
void settings() {
  screenSize = smallSize;
  // Change to desired screensize: smallSize, mediumSize, largeSize
  size((int)screenSize.x, (int)screenSize.y);
}

// Creating game states and initializing game
final int STATE_START = 0;
final int STATE_TUTORIAL = 1;
final int STATE_GAME = 2;
Boolean readyToMoveOn = false;

int gameState = STATE_START;
int tutorialStep = 0;
boolean tutorialComplete = false;

// Creating all object instances
void setup() {
  drip = loadShape("drop.svg");
  drops = new ArrayList<Drop>();
  cup = new Cup(width/2, height - height*0.4, height*0.25, height*0.2);
  bean = new Bean();
  progressbar = new ProgressBar(this, 0.28*width, 0.85*height, 0.5*width, 0.07*height);
  tracker = new Tracker(0.06*width, 0.06*height, clicks);

  file = new SoundFile(this, "click.mp3");
  yummySound = new SoundFile(this, "yummy.mp3");

  shopIcon = loadShape("shopIcon.svg");
  ShopItem[] shopItems = createIcons();
  shop = new Shop(this, width * 0.65, height * 0.05, width * 0.40, height * 0.09, shopItems);

  pauseOverlay = new PauseOverlay(width * 0.2, height * 0.1);
}


// If we are in tutorial mode, the tutorial will play out. If not, the gameScreen will be drawn as normal.
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

// Start screen for the game
void drawStartScreen() {
  background(200, 220, 255);
  textAlign(CENTER, CENTER);
  textSize(height * 0.075); //roughly equal to size(32)
  fill(0);
  text(welcomeText, width/2, height/2 - 40);
  textSize(height * 0.05); //roughly equal to size(20)
  text(pressToStart, width/2, height/2);
}


// Drawing the game screen, 60 frames per second
void drawGameScreen() {
  background(238, 217, 196);
  pushMatrix(); //Save current state to matrix stack

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
  popMatrix(); // Return state from matrix stack
  /* End of moving background */

  // If game is not paused, display as usual
  if (!pauseOverlay.getPaused()) {

    // Draw objects
    progressbar.display();
    shop.display(clicks);
    bean.beanDisplay();

    // The cup updates before drawing due to the shaking effect. It is then drawn in two steps.
    cup.update();
    cup.displayEllips(); //Cup draw 1: The ellipse displays before the drops to get layering effect

    // Update and draw all drops
    for (Drop d : drops) {
      d.update();
      d.display();
    }
    cup.displayRect(); //Cup draw 2: The cups "body" is drawn later to make the drops "fall inside" the cup

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

// Resetting the game, making new instances of the objects
void resetGame() {
  cup = new Cup(width/2, height - height*0.4, 120, 100);
  bean = new Bean();
  progressbar = new ProgressBar(this, 0.28*width, 0.85*height, 0.5*width, 0.07*height);
  tracker = new Tracker(0.06*width, 0.06*height, clicks);

  clicks = 0;
  drops.clear();

  ShopItem[] shopItems = createIcons();
  shop = new Shop(this, width * 0.7, height * 0.05, width * 0.25, height * 0.09, shopItems);
}


void keyPressed() {
  if (gameState == STATE_START) {
    if (key == ENTER || key == RETURN) {
      gameState = STATE_GAME;
    } else if (key == 't' || key == 'T') {
      gameState = STATE_TUTORIAL;
    }
  } else if (gameState == STATE_TUTORIAL) {
    if (key == 'b' || key == 'B') {
      gameState = STATE_START;
    }
  }
}

// Event handler for when mouse is pressed
void mousePressed() {
  
  boolean bought = shop.tryPurchaseAt(mouseX, mouseY, clicks);
  if (bought) {
    shop.purchaseSound.play();
    return;
  }

  pauseOverlay.isClicked(mouseX, mouseY);
  if (pauseOverlay.getPaused()) return;

  if (bean.beanIsClicked(mouseX, mouseY)) {
    yummySound.play();
  }

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
