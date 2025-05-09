void drawBean() {
  pushMatrix();
  float xOffset = sin(beanAngle) * 15; // sidledsrörelse
  translate(100 + xOffset, height - 100);
  rotate(sin(beanAngle) * 0.1);

  float scaleFactor = 0.5; // minska storlek
  scale(scaleFactor);

  // Rita själva bönan
  fill(102, 51, 0);
  noStroke();
  ellipse(0, 0, 60, 100);

  // Inre spricka
  stroke(80, 40, 0);
  strokeWeight(3);
  noFill();
  arc(0, 0, 20, 80, -PI/2, PI/2);

  // Armar
  stroke(60, 30, 0);
  strokeWeight(6);
  float armOffset = sin(beanAngle * 2) * 20;
  line(-30, -30, -30 - armOffset, -60);
  line(30, -30, 30 + armOffset, -60);

  // Ben
  line(-15, 50, -15, 70); // Vänster ben stilla
  line(15, 50, 15, 70);   // Höger ben stilla

  beanAngle += 0.1;

  popMatrix();
}
