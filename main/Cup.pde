class Cup {
  float x, y;
  float angle = 0;
  boolean shaking = false;
  int shakeFrame = 0;
  float width, height;

  Cup(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.width = w;
    this.height = h;
  }

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

void displayRect() {
  pushMatrix();
  translate(x, y);
  rotate(angle);

  noStroke();
  fill(85, 125, 170); // Blue color for the cup

  rectMode(CENTER);
  rect(0, height/2, width, height);  // Positioned so top is open

  // Draw the bottom ellipse
  fill(85, 125, 170); // darker base
  ellipse(0, height, width, 20); // base of the cylinder

  popMatrix();
}

  
void displayEllips() {
  pushMatrix();
  translate(x, y);
  rotate(angle);
  noStroke();
  fill(60, 90, 120); 
  ellipse(0, -3, width, 20); 
  popMatrix();
}


  boolean isClicked(float mx, float my) {
    float localX = mx - x;
    float localY = my - y;
    return localX > -width/2 && 
           localX < width/2 && 
           localY > 40 - height/2 && 
           localY < 40 + height/2;
  }

  void shake() {
    shaking = true;
    shakeFrame = 0;
  }
}
