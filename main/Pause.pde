class PauseOverlay {
  boolean isPaused = false;
  int btnX, btnY, btnW, btnH;
  
  int resetBtnW = 140;
  int resetBtnH = 40;
  int resetBtnX, resetBtnY;


  PauseOverlay(int w, int h) {
    btnW = w;
    btnH = h;
    updatePosition(); // Sätt initial position
  }

  void updatePosition() {
    btnX = width - btnW - 20; // 20 px från högerkanten
    btnY = height - btnH - 20; // 20 px från nederkanten
    
    resetBtnX = btnX - resetBtnW - 20; 
    resetBtnY = btnY;

  }

  void display() {
    if (isPaused) {
      drawOverlay();      // Ritar overlay + text + "starta om"
      drawPauseButton();  // Ritar "Fortsätt" ovanpå allt
    } else {
      drawPauseButton();  // Endast "Pause"-knapp i spel-läge
    }
  }


  void drawPauseButton() {
    fill(180);
    stroke(50);
    rect(btnX, btnY, btnW, btnH, 10);
    fill(0);
    textAlign(CENTER, CENTER);
    textSize(14);
    text(isPaused ? returnText : pauseText, btnX + btnW/2, btnY + btnH/2);
  }

  void drawOverlay() {
// drawOverlay()
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

  void isClicked(int mx, int my) {
    if (mx > btnX && mx < btnX + btnW &&
        my > btnY && my < btnY + btnH) {
      isPaused = !isPaused;
    }
    
    if (isPaused &&
      mx > resetBtnX && mx < resetBtnX + resetBtnW &&
      my > resetBtnY && my < resetBtnY + resetBtnH) {
    resetGame(); 
    isPaused = false;
  }
  }

  boolean getPaused() {
    return isPaused;
  }
}
