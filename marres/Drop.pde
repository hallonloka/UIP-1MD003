class Drop {
  float x, y;
  float speed;
  float sizeScale;

  Drop(float xPos) {
    x = xPos;
    y = 0;
    speed = random(2, 4);
    sizeScale = random(0.05, 0.12);
  }

  void update() {
    y += speed;
  }

  void display() {
    pushMatrix();
    translate(x, y);
    scale(sizeScale);
    shape(drip, -drip.width/2, -drip.height/2); // Center the shape
    popMatrix();
  }
  
  void dripDrop() {
    float spawnX = width/2 + random(-cupWidth/4, cupWidth/4);
    drops.add(new Drop(spawnX));
  }
 
  
}
