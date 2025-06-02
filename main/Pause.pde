/*
  Class: PauseOverlay
    This class pauses the game with a grey overlay on the screen. 
    On pause, the user can choose either to continue playing again, meaning the game will be resumed at the paused possition, 
    or restart the game, meaning the game resets all variables.
*/
class PauseOverlay {
  boolean isPaused = false;
  int btnX, btnY, btnW, btnH;
  
  int resetBtnW = 140;
  int resetBtnH = 40;
  int resetBtnX, resetBtnY;

  //Constructor 
  PauseOverlay(int w, int h) {
    btnW = w;
    btnH = h;
    updatePosition();
  }

  // Method for setting button positions
  void updatePosition() {
    btnX = width - btnW - 20; 
    btnY = height - btnH - 20;
    
    resetBtnX = btnX - resetBtnW - 20; 
    resetBtnY = btnY;

  }

  // Method for displaing the overlay and buttons
  void display() {
    if (isPaused) {
      drawOverlay();      
      drawPauseButton();  
    } else {
      drawPauseButton(); 
    }
  }

  // Method for drawing the pause-button as a rectangle 
  void drawPauseButton() {
    fill(180);
    stroke(50);
    rect(btnX, btnY, btnW, btnH, 10);
    fill(0);
    textAlign(CENTER, CENTER);
    textSize(14);
    text(isPaused ? returnText : pauseText, btnX + btnW/2, btnY + btnH/2);
  }

  // Method for drawing the overlay
  void drawOverlay() {
  fill(255, 255, 255, 180);
  noStroke();
  rect(0, 0, width, height);

  fill(0);
  textAlign(CENTER, CENTER);
  textSize(32);
  text(pauseText, width/2, height/2);

  fill(200);
  stroke(50);
  rect(resetBtnX, resetBtnY, resetBtnW, resetBtnH, 10);
  fill(0);
  textSize(14);
  text(restartText, resetBtnX + resetBtnW/2, resetBtnY + resetBtnH/2);

  }

  // Method for mouseclick
  void isClicked(int mx, int my) {
     // Check if mousepress is on pause-button
    if (mx > btnX && mx < btnX + btnW &&
        my > btnY && my < btnY + btnH) {
      isPaused = !isPaused;
    }
     // Check if mousepress is on reset-button
    if (isPaused &&
      mx > resetBtnX && mx < resetBtnX + resetBtnW &&
      my > resetBtnY && my < resetBtnY + resetBtnH) {
    resetGame(); 
    isPaused = false;
    }
  }

  // Method for checking if game is paused
  boolean getPaused() {
    return isPaused;
  }
}
