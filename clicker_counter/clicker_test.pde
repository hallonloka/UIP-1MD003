ClickArea clickarea;
ProgressBar progressbar;

void setup(){
  size(700, 550);
  clickarea = new ClickArea(210, 120, 250, 400);
  progressbar = new ProgressBar(210, 30, 250, 40);
}

void draw (){
  background(190, 110, 150);
  clickarea.display();
  progressbar.display();
}

void mousePressed(){
  if(clickarea.isClicked()){
    progressbar.registerClick();
  }

}
