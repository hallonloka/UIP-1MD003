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

  void display() {
    pushMatrix();
    translate(x, y);
    rotate(angle);

    noStroke();
    fill(85, 125, 170);
    rectMode(CENTER);
    rect(0, 40, width - 2, height);
    ellipse(0, -10, width, 10);

    stroke(0);
    strokeWeight(2);
    noFill();
    line(-width / 2, 40 - height / 2, -width / 2, 40 + height / 2);
    line(width / 2, 40 - height / 2, width / 2, 40 + height / 2);
    line(-width / 2, 40 + height / 2, width / 2, 40 + height / 2);
    ellipse(0, -10, width, 10);

    strokeWeight(6);
    arc(width/2, 40, 30, 50, -HALF_PI, HALF_PI);
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
