PShape createCircle(float x, float y){
  return createShape(ELLIPSE, x, y, 20, 20);
}

PShape createRect(float x, float y){
  return createShape(RECT, x, y, 20, 20);
}

PShape star(float x, float y, float radius1, float radius2, int npoints) {
  float angle = TWO_PI / npoints;
  float halfAngle = angle / 2.0;

  PShape s = createShape();
  s.beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius2;
    float sy = y + sin(a) * radius2;
    s.vertex(sx, sy);

    sx = x + cos(a + halfAngle) * radius1;
    sy = y + sin(a + halfAngle) * radius1;
    s.vertex(sx, sy);
  }
  s.endShape(CLOSE);
  return s;
}







  
