void drawCup() {

  pushMatrix();
  translate(width/2, height - 120);
  rotate(angle);
  
  noStroke();
  fill(85, 125, 170);
  rectMode(CENTER);
  rect(0, 40, cupWidth - 2, cupHeight);
  ellipse(0, -10, cupWidth, 10);

  stroke(0);
  strokeWeight(2);
  noFill();
  line(-cupWidth / 2, 40 - cupHeight / 2, -cupWidth / 2, 40 + cupHeight / 2);
  line(cupWidth / 2, 40 - cupHeight / 2, cupWidth / 2, 40 + cupHeight / 2);
  line(-cupWidth / 2, 40 + cupHeight / 2, cupWidth / 2, 40 + cupHeight / 2);
  ellipse(0, -10, cupWidth, 10);

  strokeWeight(6);
  arc(cupWidth/2, 40, 30, 50, -HALF_PI, HALF_PI);
  popMatrix();
  
    // Hantera koppens skakning
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

void cupPressed(ArrayList<Drop> drops){
  float mx = mouseX - width/2;
  float my = mouseY - height + 120;

  if (!shaking &&
      mx > -cupWidth/2 && mx < cupWidth/2 &&
      my > 40 - cupHeight/2 && my < 40 + cupHeight/2) {
         float spawnX = width/2 + random(-cupWidth/4, cupWidth/4);
         drops.add(new Drop(spawnX));
         shaking = true;
         shakeFrame = 0;
  }
}
