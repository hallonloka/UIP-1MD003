/*
  Class: Tracker
  This class enables tracking of the clicks and displays the clicks
 */
class Tracker {
  float x, y;
  int clicks = 0;

  // Constructor
  Tracker(float x, float y, int clicks) {
    this.x = x;
    this.y = y;
    this.clicks = clicks;
  }
  // Method for drawig the amount of clicks
  void display() {
    fill(0);
    textAlign(CENTER);
    text("Clicks: " + clicks, width / 8, y); //TODO: externalize string
  }


  // Method for incrementing the click counter
  void registerClick() {
    clicks++;
  }
}
