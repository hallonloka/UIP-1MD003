/*
  Class Cup
    This class creates a coffeecup. If clicked, the cup shakes back and forth, with a few radians. 
*/
class Cup {
  float x, y;
  float angle = 0;
  boolean shaking = false;
  int shakeFrame = 0;
  float width, height;

  // Constructor
  Cup(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.width = w;
    this.height = h;
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
    rect(0, height/2, width, height);

    fill(85, 125, 170);
    noStroke();
    rectMode(CORNER);
    rect(-width / 2, 0, width, height);

    stroke(0);
    strokeWeight(3);
    line(-width / 2, 0, -width / 2, height);
    line(width / 2, 0, width / 2, height);

    noStroke();
    fill(85, 125, 170);
    arc(0, height-1, width, 20, 0, PI, OPEN);

    noFill();
    stroke(0);
    strokeWeight(3);
    arc(0, height, width, 20, 0, PI, OPEN);

    stroke(85, 125, 170);
    strokeWeight(6);
    noFill();
    arc(width / 2, height / 2, 30, 50, -HALF_PI, HALF_PI);

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
    ellipse(0, 0, width, 20);
    popMatrix();
  }

  // Method for checking if the cup is clicked.
  boolean isClicked(float mx, float my) {
    float localX = mx - x;
    float localY = my - y;
    return localX > -width/2 &&
      localX < width/2 &&
      localY > 40 - height/2 &&
      localY < 40 + height/2;
  }

  // Method for initilating shake-mode for the cup
  void shake() {
    shaking = true;
    shakeFrame = 0;
  }
}
