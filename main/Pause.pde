class PauseOverlay {
  boolean isPaused = false;
  int btnX, btnY, btnW, btnH;

  PauseOverlay(int w, int h) {
    btnW = w;
    btnH = h;
    updatePosition(); // Sätt initial position
  }

  void updatePosition() {
    btnX = width - btnW - 20; // 20 px från högerkanten
    btnY = height - btnH - 20; // 20 px från nederkanten
  }

  void display() {
    drawPauseButton();
    if (isPaused) {
      drawOverlay();
    }
  }

  void drawPauseButton() {
    fill(180);
    stroke(50);
    rect(btnX, btnY, btnW, btnH, 10);
    fill(0);
    textAlign(CENTER, CENTER);
    textSize(14);
    text(isPaused ? "Fortsätt" : "Pause", btnX + btnW/2, btnY + btnH/2);
  }

  void drawOverlay() {
    fill(255, 255, 255, 180);
    noStroke();
    rect(0, 0, width, height);

    fill(0);
    textAlign(CENTER, CENTER);
    textSize(32);
    text("Spelet är pausat", width/2, height/2);
  }

  void isClicked(int mx, int my) {
    if (mx > btnX && mx < btnX + btnW &&
        my > btnY && my < btnY + btnH) {
      isPaused = !isPaused;
    }
  }

  boolean getPaused() {
    return isPaused;
  }
}
