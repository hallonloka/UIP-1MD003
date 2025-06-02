class PauseOverlay {
  boolean isPaused = false;
  float btnX, btnY, btnW, btnH;
  
  float resetBtnW = width * 0.35;
  float resetBtnH = height * 0.1;
  float resetBtnX, resetBtnY;


  PauseOverlay(float w, float h) {
    btnW = w;
    btnH = h;
    updatePosition(); // Sätt initial position
  }

  void updatePosition() {
    btnX = width - btnW - width * 0.05; // ungefär 20 px från högerkanten
    btnY = height - btnH - height * 0.05; // ungefär 20 px från nederkanten
    
    resetBtnX = btnX - resetBtnW - width * 0.05; 
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
    stroke(width * 0.12);
    rect(btnX, btnY, btnW, btnH, height * 0.03);
    fill(0);
    textAlign(CENTER, CENTER);
    textSize(height * 0.04); //roughly equal to size(14)
    text(isPaused ? "Return" : "Pause", btnX + btnW/2, btnY + btnH/2);
  }

  void drawOverlay() {
// drawOverlay()
  fill(255, 255, 255, 180);
  noStroke();
  rect(0, 0, width, height);

  fill(0);
  textAlign(CENTER, CENTER);
  textSize(height * 0.075); //roughly equal to size(32)
  text("Game is paused", width/2, height/2);

  fill(200);
  stroke(width * 0.12);
  rect(resetBtnX, resetBtnY, resetBtnW, resetBtnH, 10);
  fill(0);
  textSize(height * 0.04); //roughly equal to size(14)
  text("Restart", resetBtnX + resetBtnW/2, resetBtnY + resetBtnH/2);

  }

  void isClicked(float mx, float my) {
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
