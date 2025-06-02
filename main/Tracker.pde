class Tracker{
  float x, y;
  int clicks = 0;
  
  Tracker(float x, float y, int clicks){
    this.x = x;
    this.y = y;
    this.clicks = clicks;
  }

  void display() {
    fill(0);
    textAlign(CENTER);
    text(trackerClicks + clicks, x, y);
  }


  // Function for increasing clicks
  void registerClick() {
    clicks++;
  }
}
