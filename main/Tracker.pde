class Tracker{
  int x, y;
  int clicks = 0;
  
  Tracker(int x, int y, int clicks){
    this.x = x;
    this.y = y;
    this.clicks = clicks;
  }
  
  void display(){
    fill(0);
    textAlign(CENTER);
    text("Clicks: " + clicks, x, y);
  }
  
  // Function for increasing clicks
  void registerClick() {
    clicks++;
  }
}
