ClickArea clickarea;
ClickArea clickarea2;

void setup(){
  size(700, 400);
  clickarea = new ClickArea(233, 20, 233, 380);
  clickarea2 = new ClickArea(20, 20, 10, 10);
}

void draw (){
  background(250);
  clickarea.display();
  clickarea2.display();
}

void mousePressed(){
  clickarea.mousePressed();
  clickarea2.mousePressed();
}
