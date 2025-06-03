/* 
  This is a separate tab containg the method for drawing the tutorial.
*/
void drawTutorialScreen() {
  /* This part looks like main */ 
  background(238, 217, 196);
  pushMatrix(); 
  float wave = 300*sin(radians(frameCount));

  for (int i = 0; i <500; i++) {
    rotate(50);
    strokeWeight(height * 0.001);
    stroke(250, 240, 230);
    line(2000, i-wave/2, -2000, i++);
  }
  popMatrix(); 
 
  textSize(height * 0.04);
  
  //Draw Progressbar
  progressbar.display();

  //Draw shop
  shop.display(clicks);

  // Draw Bean
  bean.beanDisplay();

  // Draw Cup
  cup.update();
  cup.displayEllips();
  // Update and draw all drops
  for (Drop d : drops) {
    d.update();
    d.display();
  }
  cup.displayRect();

  strokeWeight(height * 0.001);
  // Add progressbar and click tracker
  progressbar.display();
  tracker.display();
  /* End of looking like main */
  
  fill(255);
  textSize(height * 0.05); 
  textAlign(CENTER, CENTER);

  // Drawing different instructions based on what step in the tutorial a player is on
  if (tutorialStep == 0) {
    if (tracker.clicks <= 50) {
      drawArrowToCup(cup.x, cup.y);
      text(stepZeroText, width/2, height/2 - height*0.25);
    }
  } else if (tutorialStep == 1) {
    if (shop.expanded == false) {
      drawArrowToShop(shop.x, shop.y);
      text(stepOneText, width/2, height/2 - height*0.25);
    }
  } else if (tutorialStep == 2) {
    fill(255, 0, 0);
    text(stepTwoText, width/2, height/2 - height*0.25);
    if (shop.checkShopStatus()== true && shop.tutorialBoolean == true) {
      drawArrowToCup(cup.x, cup.y);
    } else drawArrowToShop(shop.x, shop.y);
  } else if (tutorialStep == 3) {
    if (shop.tutorialBoolean == true) {
      fill(255, 0, 0);
      text(stepThreeText, width/2, height/2 - height*0.25);
    }
  }
  noStroke();
  
  tutorialCheck();
}

// Method for drawing arrow to cup
void drawArrowToCup(float cupX, float cupY) {
  float fromX = cupX + cup.cupWidth;         
  float fromY = cupY - cup.cupHeight;        
  float toX = fromX - cup.cupWidth;       
  float toY = cupY + cupY/6;

  stroke(255, 0, 0);
  strokeWeight(height * 0.004);
  fill(255, 0, 0);

  // Draw line from left to cup
  line(fromX, fromY, toX, toY);

  // Pulse effect
  float baseSize = height * 0.03;
  float pulse = sin(frameCount * 0.1) * 3;
  float arrowSize = baseSize + pulse;

  // Calculate angle
  float angle = atan2(toY - fromY, toX - fromX);

  // Draw arrowhead at end
  pushMatrix();
  translate(toX, toY);
  rotate(angle);
  beginShape();
  vertex(0, 0);
  vertex(-arrowSize, -arrowSize / 2);
  vertex(-arrowSize, arrowSize / 2);
  endShape(CLOSE);
  popMatrix();
}

// Method for drawing arrow to shop
void drawArrowToShop(float shopX, float shopY) {
  float fromX = shopX - shop.w ;
  float fromY = shopY + shop.h/2;
  float toX = shopX + shop.w * 0.02;
  float toY = shopY + shop.h/2;

  stroke(255, 0, 0);
  strokeWeight(height * 0.004);
  fill(255, 0, 0);

  // Draw line from left to cup
  line(fromX, fromY, toX, toY);

  // Pulse effect
  float baseSize = height * 0.03;
  float pulse = sin(frameCount * 0.1) * 3;
  float arrowSize = baseSize + pulse;

  // Calculate angle 
  float angle = atan2(toY - fromY, toX - fromX);

  // Draw arrowhead at end
  pushMatrix();
  translate(toX, toY);
  rotate(angle);
  beginShape();
  vertex(0, 0);
  vertex(-arrowSize, -arrowSize / 2);
  vertex(-arrowSize, arrowSize / 2);
  endShape(CLOSE);
  popMatrix();
}

// Method for handling tutorial steps
void tutorialCheck() {
  if (!tutorialComplete) {
    if (tutorialStep == 0) {
      if (tracker.clicks >=30) {
        tutorialStep = 1;
      }
    } else if (tutorialStep == 1) { 
      if (shop.expanded == true) {
        tutorialStep = 2;
      }
    } else if (tutorialStep == 2) { 
      if (shop.tutorialBoolean == true) {
        tutorialStep = 3;
      }
    } else if (tutorialStep == 3) {
      if (tracker.clicks > 50) {
        tutorialComplete = true;
      }
    }
  }
}
