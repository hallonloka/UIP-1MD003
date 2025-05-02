class ClickArea {
  int x, y, w, h;
  int clicks = 0;
  
  ClickArea(int x, int y, int w, int h){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  
  void display(){
    pushMatrix();
    fill(200);
    stroke(0);
    rect(x, y, w, h, 4);
    popMatrix();
    
    fill(0);
    textAlign(CENTER);
    text("clicks: " + clicks, x + w / 2, y - 5);
    
    
  }
  
  void mousePressed() {
  if (mouseX >= x && mouseX <= x + w && mouseY >= y && mouseY <= y + h) {
    clicks++;
  }
}
  
  
    
  
}
  
  
  
  
  
