class ProgressBar{
  float x, y, w, h;
  float levelProgress = 0;
  int levelLimit = 10;
  int level = 0;
  int clicks = 0;
  
  ProgressBar(float x, float y, float w, float h){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    
  }
  
  void display(){
    drawBar();
    //writeProgress();
    writeLevel();
    
  }
  
  void drawBar(){
    pushMatrix();
    fill(250);
    stroke(0);
    rect(x, y, w*levelProgress, h);
    popMatrix();

  }
  
  void writeLevel(){
    fill(0);
    textAlign(CENTER);
    text("level " + level, x + w / 2, y +0.1*height);
  }
  
  void writeProgress(){
    fill(0);
    textAlign(CENTER);
    text(nf(levelProgress * 100, 0, 1) + "%", x + w / 2, y - 5);
  }
  
  //TODO: Depend on other variable (antal droppar som träffat koppen? eller antal clicks från click_area?
  void registerClick() {
    if(this.clicks == this.levelLimit){
      clicks = 0;
      level++;
      levelLimit += 10;
    }
    
    clicks++;
    calcProgress();
  }
  
  void calcProgress(){
    levelProgress = (float)this.clicks / this.levelLimit;
  }
  
}
