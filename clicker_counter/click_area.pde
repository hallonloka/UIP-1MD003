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
    fill(255, 255, 255, 100);
    stroke(0);
    rect(x, y, w, h, 4);
    popMatrix();

    
    
  }
  
  boolean isClicked() {
    return(mouseX >= x && mouseX <= x + w && mouseY >= y && mouseY <= y + h);
  }
    

}
  
  
    

  
  
  
  
  
