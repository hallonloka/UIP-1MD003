class ShopItem{
  String name;
  int price;
  boolean activated = false;
  PShape shape;
  float rotateAngle;
  
  ShopItem(String name, int price, PShape shape , float rotateAngle){
    this.name = name;
    this.price = price;
    this.shape = shape;
    this.rotateAngle = rotateAngle;
  }
  
  void display(float x, float y, float w, float h, boolean affordable, boolean hovered){
    if(!affordable){
      fill(180);
    }
    else{
      if(hovered){
        fill(100, 250, 100);
      }
      else{
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
      
      if(rotateAngle != 0){
        rotateAngle += 0.01;
      }
    }
    
    fill(0);
    textAlign(LEFT, CENTER);
    text(name + " ($" + price + ")", x + (w*0.25), y + 20);
    
  }
  
}

//////////////////////Shape functions ////////////////////////
PShape cube;
float cubeSize = 40;
float circleRad = 4;
int circleRes = 40;
float noiseMag = 1;

ShopItem[] createIcons(){
  PShape lightning = createLightning(0,0);
  PShape doubleCircle = doubleCircle(0,0);
  PShape star = star(0, 0, 15, 40, 10); 
 
  
  ShopItem[] shopItems = {
    new ShopItem("Double Click", 50, doubleCircle, 0.6),
    new ShopItem("Mega Boost", 150, lightning, 0),
    new ShopItem("Auto Click", 100, star, 0.1)
  };
  return shopItems;
}

PShape createCircle(float x, float y){
  return createShape(ELLIPSE, x, y, 20, 20);
}

PShape createRect(float x, float y){
  return createShape(RECT, x, y, 20, 20);
}

PShape doubleCircle(float x, float y){
  PShape group = createShape(GROUP);
  PShape circle1 = createShape(ELLIPSE, x, y, 30, 30);
  circle1.setFill(color(255, 0, 0));
  group.addChild(circle1);
  
  PShape circle2 = createShape(ELLIPSE, x + 10, y + 10, 25, 25);
  circle2.setFill(color(0, 0, 255)); // Blue
  group.addChild(circle2);
  
  return group;
}

PShape star(float x, float y, float radius1, float radius2, int npoints) {
  float angle = TWO_PI / npoints;
  float halfAngle = angle / 2.0;

  PShape s = createShape();
  s.beginShape();
  s.fill(100,200,40);
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

PShape createLightning(float x, float y) {
  PShape bolt = createShape();
  bolt.beginShape();
  bolt.fill(255, 215, 0); // Gold/Yellow color
  bolt.stroke(0);
  bolt.strokeWeight(2);

  // Define the vertices of the lightning bolt
  bolt.vertex(x, y-20);
  bolt.vertex(x + 15, y + 10);
  bolt.vertex(x + 5, y + 10);
  bolt.vertex(x + 25, y + 50);
  bolt.vertex(x + 15, y + 45);
  bolt.vertex(x + 30, y + 90);
  bolt.vertex(x + 10, y + 55);
  bolt.vertex(x + 20, y + 55);
  bolt.vertex(x, y + 25);
  bolt.vertex(x + 10, y + 25);
  bolt.endShape(CLOSE);

  return bolt;
}


//Ska va 3d cube men funkar inte om man inte renderar med P3D i setup. Kommer från Example Wiggling
PShape cube() {
  PShape cube = createShape(GROUP);  
  PShape face;

  // Create all faces at front position
  for (int i = 0; i < 6; i++) {
    face = createShape();
    createFaceWithHole(face);
    cube.addChild(face);
  }

  // Rotate all the faces to their positions

  // Front face - already correct
  face = cube.getChild(0);

  // Back face
  face = cube.getChild(1);
  face.rotateY(radians(180));

  // Right face
  face = cube.getChild(2);
  face.rotateY(radians(90));

  // Left face
  face = cube.getChild(3);
  face.rotateY(radians(-90));

  // Top face
  face = cube.getChild(4);
  face.rotateX(radians(90));

  // Bottom face
  face = cube.getChild(5);
  face.rotateX(radians(-90));
  
  return cube;
}

void createFaceWithHole(PShape face) {
  face.beginShape(POLYGON);
  face.stroke(255, 0, 0);
  face.fill(255);

  // Draw main shape Clockwise
  face.vertex(-cubeSize/2, -cubeSize/2, +cubeSize/2);
  face.vertex(+cubeSize/2, -cubeSize/2, +cubeSize/2);
  face.vertex(+cubeSize/2, +cubeSize/2, +cubeSize/2);
  face.vertex(-cubeSize / 2, +cubeSize / 2, +cubeSize / 2);

  // Draw contour (hole) Counter-Clockwise
  face.beginContour();
  for (int i = 0; i < circleRes; i++) {
    float angle = TWO_PI * i / circleRes;
    float x = circleRad * sin(angle);
    float y = circleRad * cos(angle);
    float z = +cubeSize/2;
    face.vertex(x, y, z);
  }
  face.endContour();

  face.endShape(CLOSE);
}








  
