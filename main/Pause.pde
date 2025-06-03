/*
  Class: PauseOverlay
    This class pauses the game with a grey overlay on the screen. 
    On pause, the user can choose either to continue playing again, meaning the game will be resumed at the paused possition, 
    or restart the game, meaning the game resets all variables.
*/
class PauseOverlay {
  boolean isPaused = false;
  float btnX, btnY, btnW, btnH;
  
  float resetBtnW = width * 0.35;
  float resetBtnH = height * 0.1;
  float resetBtnX, resetBtnY;

 //Constructor 
  PauseOverlay(float w, float h) {
    btnW = w;
    btnH = h;
    updatePosition();
  }

  // Method for setting button positions
  void updatePosition() {
    btnX = width - btnW - width * 0.05; // ungefär 20 px från högerkanten
    btnY = height - btnH - height * 0.05; // ungefär 20 px från nederkanten
    
    resetBtnX = btnX - resetBtnW - width * 0.05; 
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
    stroke(width * 0.12);
    rect(btnX, btnY, btnW, btnH, height * 0.03);
    fill(0);
    textAlign(CENTER, CENTER);
    textSize(height * 0.04); //roughly equal to size(14)
    text(isPaused ? returnText : pauseText, btnX + btnW/2, btnY + btnH/2);
  }

  // Method for drawing the overlay
  void drawOverlay() {
  fill(255, 255, 255, 180);
  noStroke();
  rect(0, 0, width, height);

  fill(0);
  textAlign(CENTER, CENTER);
  textSize(height * 0.075); //roughly equal to size(32)
  text(pauseText, width/2, height/2);

  fill(200);
  stroke(width * 0.12);
  rect(resetBtnX, resetBtnY, resetBtnW, resetBtnH, 10);
  fill(0);
  textSize(height * 0.04); //roughly equal to size(14)
  text(restartText, resetBtnX + resetBtnW/2, resetBtnY + resetBtnH/2);

  }

  void isClicked(float mx, float my) {
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
