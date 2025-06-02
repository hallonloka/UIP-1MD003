/*
  Class. Bean
    This class creates a dancing coffeebean with waving arms.  
*/
class Bean {
  // Angle of the bean
  float beanAngle = 0;

  // Method for drawing the bean
  void draw() {
    pushMatrix();
    // Offset to simulate the movement of the bean
    float xOffset = sin(beanAngle) * 15; 
    translate(width*0.1 + xOffset, height - 100);
    rotate(sin(beanAngle) * 0.1);

    // Scale the bean to fit different screen-sizes
    float scaleFactor = 0.5;
    scale(scaleFactor);
    
    // Draws the bean
    fill(102, 51, 0);
    noStroke();
    ellipse(0, 0, 60, 100);

    stroke(80, 40, 0);
    strokeWeight(3);
    noFill();
    arc(0, 0, 20, 80, -PI/2, PI/2);

    // Bean-arms
    stroke(60, 30, 0);
    strokeWeight(6);
    float armOffset = sin(beanAngle * 2) * 20;
    line(-30, -30, -30 - armOffset, -60);
    line(30, -30, 30 + armOffset, -60);

    // Bean-legs
    line(-15, 50, -15, 70); 
    line(15, 50, 15, 70);  

    beanAngle += 0.1;
    popMatrix();
  }
  
  boolean beanIsClicked(float mx, float my) {
    float xOffset = sin(beanAngle) * 15;
    float beanX = width * 0.1 + xOffset;
    float beanY = height - 100;
  
    // Inverse transform mouse coordinates: move to bean space and scale
    float scaleFactor = 0.5;
    float localX = (mx - beanX) / scaleFactor;
    float localY = (my - beanY) / scaleFactor;
  
    // Check if inside the bean ellipse (60x100 centered at 0,0)
    float rx = 30;  // ellipse width / 2
    float ry = 50;  // ellipse height / 2
    return sq(localX) / sq(rx) + sq(localY) / sq(ry) <= 1;
}

}
