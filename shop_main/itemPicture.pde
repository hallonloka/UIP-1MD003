class ItemPicture {
  PShape cube;
  float cubeSize = 40;
  int circleRes = 40;
  float circleRad = 4;
  float x, y;
  float angle = 0;

  ItemPicture(float x, float y) {
    this.x = x;
    this.y = y;
  }

  void createCube() {
    cube = createShape(GROUP);

    PShape face;

    for (int i = 0; i < 6; i++) {
      face = createShape();
      createFaceWithHole(face);
      cube.addChild(face);
    }

    // Rotate faces
    cube.getChild(1).rotateY(PI);
    cube.getChild(2).rotateY(HALF_PI);
    cube.getChild(3).rotateY(-HALF_PI);
    cube.getChild(4).rotateX(HALF_PI);
    cube.getChild(5).rotateX(-HALF_PI);
  }

  void display() {
    pushMatrix();
    translate(x, y);
    rotateX(angle);
    rotateY(angle);
    shape(cube);
    popMatrix();

    angle += 0.01; // Spin animation
  }

  void createFaceWithHole(PShape face) {
    face.beginShape();
    face.stroke(255, 0, 0);
    face.fill(255);

    // Main square
    face.vertex(-cubeSize / 2, -cubeSize / 2, cubeSize / 2);
    face.vertex(cubeSize / 2, -cubeSize / 2, cubeSize / 2);
    face.vertex(cubeSize / 2, cubeSize / 2, cubeSize / 2);
    face.vertex(-cubeSize / 2, cubeSize / 2, cubeSize / 2);
    
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
}
