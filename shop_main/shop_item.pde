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
