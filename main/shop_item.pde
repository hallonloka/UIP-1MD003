/*
  Class: ShopItem
    Create all items in shop with accompanying icons and info.
*/
class ShopItem {
  String name;
  int price;
  boolean activated = false;
  PShape shape;
  float rotateAngle;

  // Constructor
  ShopItem(String name, int price, PShape shape, float rotateAngle) {
    this.name = name;
    this.price = price;
    this.shape = shape;
    this.rotateAngle = rotateAngle;
  }
  
  // Method for displaying item specifics
  void display(float x, float y, float w, float h, boolean affordable, boolean hovered) {
    // Changes background colors for items
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

    // Draws custom shape and rotates
    if (shape != null) {
      pushMatrix();
      translate(x + w*0.1, y + h*0.5);
      scale(0.5);
      rotate(rotateAngle);
      shape(shape);
      popMatrix();
      
      // If item does not have rotate angle, it stays still
      if (rotateAngle != 0) {
        rotateAngle += 0.01;
      }
    }
    
    // Text for item
    fill(0);
    textAlign(LEFT, CENTER);
    // Custom size for small screen proportions
    if (screenSize == smallSize) {
      textSize(height * 0.02);
    } else textSize(height * 0.035);
    text(name + " ($" + price + ")", x + w * 0.25, y + width*0.05);
    textSize(height * 0.04);
  }
}

//////////////////////Shape functions ////////////////////////

// Method for creating an array of items for shop
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

// Method for creating a circular PShape
// xFactor and yFactor must be between 0-1
PShape createCircle(float xFactor, float yFactor) {
  return createShape(ELLIPSE, width * xFactor, height * yFactor, width * 0.05, width * 0.05);
}
// Method for creating a rectangular PShape
PShape createRect(float xFactor, float yFactor) {
  return createShape(RECT, width * xFactor, height * yFactor, width * 0.05, width * 0.05);
}

// Method for creating a double circular PShape
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

// Method for creating a star PShape
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

// Method for creating a lightning PShape
PShape createLightning(float xFactor, float yFactor) {
  float x = width * xFactor;
  float y = height * yFactor;
  float scale = height * 0.015;

  PShape bolt = createShape();
  bolt.beginShape();
  bolt.fill(255, 215, 0); 
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

// Method for creating a triangular PShape
PShape createTriangle(float xFactor, float yFactor, float size) {
  PShape triangle = createShape();
  triangle.beginShape();
  triangle.fill(255, 100, 0); 
  triangle.noStroke();

  float h = size * sqrt(3) / 2; 

  triangle.vertex(width * xFactor, height * yFactor - h / 2);
  triangle.vertex(width * xFactor - size / 2, height * yFactor + h / 2);
  triangle.vertex(width * xFactor + size / 2, height * yFactor + h / 2);

  triangle.endShape(CLOSE);
  return triangle;
}

// Method for creating a cross shaped PShape
PShape createCross(float xFactor, float yFactor, float size) {
  float barWidth = size * 0.2;
  float halfSize = size / 2;

  PShape cross = createShape(GROUP);

  // Vertical
  PShape vertical = createShape(RECT, width * xFactor - barWidth, height * yFactor - halfSize, barWidth, size);
  vertical.setFill(color(200, 50, 50));  
  cross.addChild(vertical);

  // Horizontal
  PShape horizontal = createShape(RECT, width * xFactor - halfSize, height * yFactor - (barWidth / 2), size, barWidth);
  horizontal.setFill(color(200, 50, 50)); 
  cross.addChild(horizontal);

  return cross;
}
