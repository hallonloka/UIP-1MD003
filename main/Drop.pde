/*
  Class: Drop
   This class contains the variables and methods needed to display the drops falling when clicking the cup.
 */
class Drop {
  float x, y;
  float speed;
  float sizeScale;

  // Constructor
  Drop(float xPos) {
    x = xPos;
    y = 0;
    // Randomize the speed and size of the drop
    speed = random(2, 4);
    sizeScale = random(0.00006*height, 0.00012*height);
  }
  // Method for incrementing the y-location of the drop
  void update() {
    y += speed;
  }
  // Method for displaying the drop in the right position
  void display() {

    // Display the drop until it is in the cup
    if (y < (height - height*0.35)) {
      pushMatrix();
      translate(x, y);
      scale(sizeScale);
      shape(drip, -drip.width/2, -drip.height/2);
      popMatrix();
    }
  }
}
