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

    //fyrkanten run koppen
    stroke(0);
    strokeWeight(2);
    fill(85, 125, 170);
    rectMode(CENTER);
    rect(0, height/2, width, height);

    // blåa delen av koppen
    fill(85, 125, 170);
    noStroke();
    rectMode(CORNER);
    rect(-width / 2, 0, width, height);

    // kanterna svarta streck
    stroke(0);
    strokeWeight(3);
    line(-width / 2, 0, -width / 2, height);
    line(width / 2, 0, width / 2, height);

    // runda av bottendelen av ikoppeb
    noStroke();
    fill(85, 125, 170);
    arc(0, height-1, width, 20, 0, PI, OPEN);

    // linjen vid botten
    noFill();
    stroke(0);
    strokeWeight(3);
    arc(0, height, width, 20, 0, PI, OPEN);

    // Handtag
    stroke(85, 125, 170);
    strokeWeight(6);
    noFill();
    arc(width / 2, height / 2, 30, 50, -HALF_PI, HALF_PI);

    rectMode(CORNER); //Den måste resettas till corner för att det andra ska bli snyggt
    strokeWeight(1); //Den här med

    popMatrix();
  }


  void displayEllips() {
    pushMatrix();
    translate(x, y);
    rotate(angle);
    noStroke();
    fill(60, 90, 120);
    ellipse(0, 0, width, 20);
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
