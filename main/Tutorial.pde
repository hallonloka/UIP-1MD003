void drawTutorialScreen() {

  background(238, 217, 196);

  pushMatrix(); //Save current state to matrix stack
  // Create variable that loops for rotating strokes
  float wave = 300*sin(radians(frameCount));

  // Incrementally redraw strokes to animate
  for (int i = 0; i <500; i++) {
    rotate(50);
    strokeWeight(1);
    stroke(250, 240, 230);
    line(850, i-wave/2, -850, i++);
  }
  popMatrix(); //Return state from matrix stack

  //Draw Progressbar
  progressbar.display();

  //Draw shop
  shop.display(clicks);

  // Draw Bean
  bean.draw();

  // Draw Cup
  cup.update();
  cup.displayEllips();
  // Update and draw all drops
  for (Drop d : drops) {
    d.update();
    d.display();
  }
  cup.displayRect();

  strokeWeight(1);
  // Add progressbar and click tracker
  progressbar.display();
  tracker.display();
  fill(255);
  textSize(20);
  textAlign(CENTER, CENTER);

  if (tutorialStep == 0) {
    if (tracker.clicks <= 50) {
      drawArrowToCup(cup.y, cup.x);
      text("Click the cup and reach 30 clicks!", width/2, height/2 - 100);
    }
  } else if (tutorialStep == 1) {
    if (shop.expanded == false) {
      drawArrowToShop(shop.x, shop.y);
      text("Click the shop to buy an upgrade!", width/2, height/2 - 100);
    }
  } else if (tutorialStep == 2) {
    fill(255, 0, 0);
    text("Buy the upgrade!", width/2, height/2 - 100);
    if (shop.checkShopStatus()==true && shop.tutorialBoolean == true) { //TODO
      //arrow to upgrade!!!!!
      drawArrowToCup(cup.y, cup.x); //placeholder
    } else drawArrowToShop(shop.x, shop.y);
  } else if (tutorialStep == 3) {
    if (shop.tutorialBoolean == true) {
      fill(255, 0, 0);
      text("Keep on clicking", width/2, height/2 - 100);
    }
  }

  noStroke();
  tutorialCheck();
}

void drawArrowToCup(float cupX, float cupY) {
  float fromX = cupX+cup.width*2;         
  float fromY = cupY- cup.height;        
  float toX = fromX - cup.width;  
  float toY = cupY;

  stroke(255, 0, 0);
  strokeWeight(4);
  fill(255, 0, 0);

  // Draw line from left to cup
  line(fromX, fromY, toX, toY);

  // Pulse effect
  float baseSize = 12;
  float pulse = sin(frameCount * 0.1) * 3;
  float arrowSize = baseSize + pulse;

  // Calculate angle (should be toward right)
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

void drawArrowToShop(float shopX, float shopY) {
  float fromX = shopX - shop.w ;
  float fromY = shopY + shop.h/2;
  float toX = shopX + shop.w * 0.02;
  float toY = shopY + shop.h/2;

  stroke(255, 0, 0);
  strokeWeight(4);
  fill(255, 0, 0);

  // Draw line from left to cup
  line(fromX, fromY, toX, toY);

  // Pulse effect
  float baseSize = 12;
  float pulse = sin(frameCount * 0.1) * 3;
  float arrowSize = baseSize + pulse;

  // Calculate angle (should be toward right)
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

void tutorialCheck() {
  if (!tutorialComplete) {
    if (tutorialStep == 0) {
      if (tracker.clicks >=30) {
        tutorialStep = 1;
      }
    } else if (tutorialStep == 1) { //click shop step
      if (shop.expanded == true) {
        tutorialStep = 2;
      }
    } else if (tutorialStep == 2) { //buy upgrade step
      if (shop.tutorialBoolean == true) {
        tutorialStep = 3;
      }
    } else if (tutorialStep == 3) {
      if (tracker.clicks > 50) {
        tutorialComplete= true;
      }
    }
  }
}
