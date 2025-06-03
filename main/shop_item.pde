class ShopItem {
  String name;
  int price;
  boolean activated = false;
  PShape shape;
  float rotateAngle;

  ShopItem(String name, int price, PShape shape, float rotateAngle) {
    this.name = name;
    this.price = price;
    this.shape = shape;
    this.rotateAngle = rotateAngle;
  }

  void display(float x, float y, float w, float h, boolean affordable, boolean hovered) {
    if (!affordable) {
      fill(180);
    } else {
      if (hovered) {
        fill(100, 250, 100);
      } else {
        fill(255);
      }
    }

    stroke(0);
    rect(x, y, w, h);

    // Draw custom shape
    if (shape != null) {
      pushMatrix();
      translate(x + w*0.1, y + h*0.5);
      scale(0.5);
      rotate(rotateAngle);
      shape(shape);
      popMatrix();

      if (rotateAngle != 0) {
        rotateAngle += 0.01;
      }
    }

    fill(0);
    textAlign(LEFT, CENTER);
    if (screenSize == smallSize) {
      textSize(10);
    } else textSize(height * 0.035);
    text(name + " ($" + price + ")", x + w * 0.25, y + 20);
  }
}

//////////////////////Shape functions ////////////////////////
PShape cube;
float cubeSize = 40;
float circleRad = 4;
int circleRes = 40;
float noiseMag = 1;

ShopItem[] createIcons() {
  PShape lightning = createLightning(0, 0);
  PShape doubleCircle = doubleCircle(0, 0);
  PShape star = star(0, 0, width * 0.025, width * 0.05, 10);
  PShape triangle = createTriangle(0, 0, width * 0.08);
  PShape cross = createCross(0, 0, width * 0.09);


  ShopItem[] shopItems = {
    new ShopItem(itemOne, 30, triangle, 0.3),
    new ShopItem(itemTwo, 50, cross, 0.2),
    new ShopItem(itemThree, 75, lightning, 0),
    new ShopItem(itemFour, 100, doubleCircle, 0.6),
    new ShopItem(itemFive, 200, star, 0.1)
  };
  return shopItems;
}

// xFactor and yFactor must be between 0-1
PShape createCircle(float xFactor, float yFactor) {
  return createShape(ELLIPSE, width * xFactor, height * yFactor, width * 0.05, width * 0.05);
}

PShape createRect(float xFactor, float yFactor) {
  return createShape(RECT, width * xFactor, height * yFactor, width * 0.05, width * 0.05);
}

PShape doubleCircle(float xFactor, float yFactor) {
  PShape group = createShape(GROUP);
  PShape circle1 = createShape(ELLIPSE, width * xFactor, height * yFactor, width * 0.075, width * 0.075);
  circle1.setFill(color(255, 0, 0)); // Red
  group.addChild(circle1);

  PShape circle2 = createShape(ELLIPSE, width * xFactor + width * 0.025, height * yFactor + width * 0.025, width * 0.06, width * 0.06);
  circle2.setFill(color(0, 0, 255)); // Blue
  group.addChild(circle2);

  return group;
}

PShape star(float xFactor, float yFactor, float radius1, float radius2, int npoints) {
  float angle = TWO_PI / npoints;
  float halfAngle = angle / 2.0;

  PShape s = createShape();
  s.beginShape();
  s.fill(100, 200, 40);
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = width * xFactor + cos(a) * radius2;
    float sy = height * yFactor + sin(a) * radius2;
    s.vertex(sx, sy);

    sx = width * xFactor + cos(a + halfAngle) * radius1;
    sy = height * yFactor + sin(a + halfAngle) * radius1;
    s.vertex(sx, sy);
  }
  s.endShape(CLOSE);
  return s;
}

PShape createLightning(float xFactor, float yFactor) {
  float x = width * xFactor;
  float y = height * yFactor;
  float scale = height * 0.015;

  PShape bolt = createShape();
  bolt.beginShape();
  bolt.fill(255, 215, 0); // Gold/Yellow color
  bolt.stroke(0);
  bolt.strokeWeight(2);

  // Define the vertices of the lightning bolt
  bolt.vertex(x, y - scale * 2);
  bolt.vertex(x + scale * 1.5, y + scale);
  bolt.vertex(x + scale * 0.5, y + scale);
  bolt.vertex(x + scale * 2.5, y + scale * 5);
  bolt.vertex(x + scale * 1.5, y + scale * 4.5);
  bolt.vertex(x + scale * 3, y + scale * 9);
  bolt.vertex(x + scale, y + scale * 5.5);
  bolt.vertex(x + scale * 2, y + scale * 5.5);
  bolt.vertex(x, y + scale * 2.5);
  bolt.vertex(x + scale, y + scale * 2.5);
  bolt.endShape(CLOSE);

  return bolt;
}

PShape createTriangle(float xFactor, float yFactor, float size) {
  PShape triangle = createShape();
  triangle.beginShape();
  triangle.fill(255, 100, 0); // Orange
  triangle.noStroke();

  float h = size * sqrt(3) / 2; // Height of equilateral triangle

  triangle.vertex(width * xFactor, height * yFactor - h / 2);
  triangle.vertex(width * xFactor - size / 2, height * yFactor + h / 2);
  triangle.vertex(width * xFactor + size / 2, height * yFactor + h / 2);

  triangle.endShape(CLOSE);
  return triangle;
}


PShape createCross(float xFactor, float yFactor, float size) {
  float barWidth = size * 0.2;
  float halfSize = size / 2;

  PShape cross = createShape(GROUP);

  // Vertical
  PShape vertical = createShape(RECT, width * xFactor - barWidth, height * yFactor - halfSize, barWidth, size);
  vertical.setFill(color(200, 50, 50));  // Red
  //vert.setStroke(false);
  cross.addChild(vertical);

  // Horizontal
  PShape horizontal = createShape(RECT, width * xFactor - halfSize, height * yFactor - (barWidth / 2), size, barWidth);
  horizontal.setFill(color(200, 50, 50));  // Red
  //horiz.setStroke(false);
  cross.addChild(horizontal);

  return cross;
}
