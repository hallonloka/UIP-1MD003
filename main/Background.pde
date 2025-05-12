class Background {
  void draw(){
    background(238,217,196);
    
    float wave = 300*sin(radians(frameCount));
    
    for (int i = 0; i <500; i++){
    rotate(50);
    stroke(250,240,230);
    line(850, i-wave/2, -850, i++);
    }
  }
}
