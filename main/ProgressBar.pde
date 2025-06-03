/*
  Class: ProgressBar
    This class enables a progress bar to be animated based on user interaction.
    The amount of clicks is tracked and increments the progressbar that is animated. 
    At certain milestones the game increments the level and resets the progressbar.
*/
class ProgressBar{
  float x, y, w, h;
  float levelProgress = 0;
  int levelLimit = 10;
  int level = 0;
  int clicks = 0;
  
  // Reffering to parent (main) in order to access sound file.
  PApplet parent;
  SoundFile levelUpSound;
  
  // Constructor
  ProgressBar(PApplet p, float x, float y, float w, float h){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    levelUpSound = new SoundFile(p, "level_up.mp3");
  }
  
  // Method for displaying the progressbar
  void display() {
    drawBar();
    writeLevel();
  }
  
  // Method for drawing the progress bar
  void drawBar() {
    pushMatrix();
    fill(250);
    stroke(0);
    rect(x, y, w * levelProgress, h);
    popMatrix();
  }
  
  // Method for displaying the current level
  void writeLevel() {
    fill(0);
    textAlign(CENTER);
    text(progressBarLevel + level, width / 2, y +0.1 * height);
  }
  
  // Method for proccessing a registered click 
  void registerClick() {
    // Check if the level-limit is reached
    if (this.clicks == this.levelLimit) {
      clicks = 0;
      level++;
      // Increase the amount of clicks needed to level up
      levelLimit += 10;
      levelUpSound.play();
    }
    clicks++;
    calcProgress();
  }

  // Method for calculating the progress of the clicks in accordance to level-limit
  void calcProgress() {
    levelProgress = (float) this.clicks / this.levelLimit;
  }
}
