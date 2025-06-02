/*
  Class. Bean
    This class creates a dancing coffeebean with waving arms.  
*/
class Bean {
  // Angle of the bean
  float beanAngle = 0;

  // Ritning av bönan
  void beanDisplay() {
    pushMatrix();
    // Offset to simulate the movement of the bean
    float xOffset = sin(beanAngle) * 15; 
    translate(width * 0.1 + xOffset, height - height * 0.25);
    rotate(sin(beanAngle) * 0.1);

    // Scale the bean to fit different screen-sizes
    float scaleFactor = 0.5;
    scale(scaleFactor);
    
    // Draws the bean
    fill(102, 51, 0);
    noStroke();
    ellipse(0, 0, height * 0.15, height * 0.25);

    stroke(80, 40, 0);
    strokeWeight(height * 0.003);
    noFill();
    arc(0, 0, height * 0.05, height * 0.20, -PI/2, PI/2);

    // Bean-arms
    stroke(60, 30, 0);
    strokeWeight(height * 0.008);
    float armOffset = sin(beanAngle * 2) * 20;
    line(-(height *  0.075), -(height *  0.075), -(height *  0.075) - armOffset, -(height *  0.15));
    line(height *  0.075, -(height *  0.075), height *  0.075 + armOffset, -(height *  0.15));

    // Bean-legs
    line(-(height *  0.0375), height * 0.125, -(height *  0.0375), height * 0.175);
    line(height *  0.0375, height * 0.125, height *  0.0375, height * 0.175);

    beanAngle += 0.1;
    popMatrix();
  }
  
  boolean beanIsClicked(float mx, float my) {
  float xOffset = sin(beanAngle) * 15;
  float beanX = width * 0.1 + xOffset;
  float beanY = height - height * 0.25;

  // Inverse transform mouse coordinates: move to bean space and scale
  float scaleFactor = 0.5;
  float localX = (mx - beanX) / scaleFactor;
  float localY = (my - beanY) / scaleFactor;

  // Check if inside the bean ellipse (15% of height x 25% of height centered at 0,0)
  float rx = height * 0.15 / 2;  // ellipse width / 2
  float ry = height * 0.25 / 2;  // ellipse height / 2
  return sq(localX) / sq(rx) + sq(localY) / sq(ry) <= 1;
}

}
