/*
  Class Cup
    This class creates a coffeecup. If clicked, the cup shakes back and forth, with a few radians. 
*/
class Cup {
  float x, y;
  float angle = 0;
  boolean shaking = false;
  int shakeFrame = 0;
  float cupWidth, cupHeight;

  // Constructor
  Cup(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.cupWidth = w;
    this.cupHeight = h;
  }

  // Method for handeling shaking the cup and sets the cup-angle to a set amount of radians.
  void update() {
    if (shaking) {
      shakeFrame++;
      if (shakeFrame < 5) {
        angle = radians(5);
      } else if (shakeFrame < 10) {
        angle = radians(-5);
      } else if (shakeFrame < 15) {
        angle = radians(2);
      } else if (shakeFrame < 20) {
        angle = radians(-2);
      } else {
        angle = 0;
        shaking = false;
        shakeFrame = 0;
      }
    }
  }

  // Method for drawing the "body" of the cup as a rectangle
  void displayRect() {
    pushMatrix();
    translate(x, y);
    rotate(angle);

    stroke(0);
    strokeWeight(2);
    fill(85, 125, 170);
    rectMode(CENTER);
    rect(0, cupHeight/2, cupWidth, cupHeight);

    fill(85, 125, 170);
    noStroke();
    rectMode(CORNER);
    rect(-cupWidth / 2, 0, cupWidth, cupHeight);

    stroke(0);
    strokeWeight(3);
    line(-cupWidth / 2, 0, -cupWidth / 2, cupHeight);
    line(cupWidth / 2, 0, cupWidth / 2, cupHeight);

    noStroke();
    fill(85, 125, 170);
    arc(0, cupHeight-1, cupWidth, 20, 0, PI, OPEN);

    noFill();
    stroke(0);
    strokeWeight(3);
    arc(0, cupHeight, cupWidth, 20, 0, PI, OPEN);

    stroke(85, 125, 170);
    strokeWeight(6);
    noFill();
    arc(cupWidth / 2, cupHeight / 2, 30, 50, -HALF_PI, HALF_PI);

    rectMode(CORNER); 
    strokeWeight(1); 
    popMatrix();
  }

  // Method for drawing the top of the cup as an elipse
  void displayEllips() {
    pushMatrix();
    translate(x, y);
    rotate(angle);
    noStroke();
    fill(60, 90, 120);
    ellipse(0, 0, cupWidth, 20);
    popMatrix();
  }

  // Method for checking if the cup is clicked.
  boolean isClicked(float mx, float my) {
    float localX = mx - x;
    float localY = my - y;
    return localX > -cupWidth/2 &&
      localX < cupWidth/2 &&
      localY > 40 - cupHeight/2 &&
      localY < 40 + cupHeight/2;
  }

  // Method for initilating shake-mode for the cup
  void shake() {
    shaking = true;
    shakeFrame = 0;
  }
}
