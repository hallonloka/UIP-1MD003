class Shop{
  float x, y, w, h;
  ShopItem[] items;
  int selectedIndex = 0;
  boolean expanded = false;
  
  Shop(float x, float y, float w, float h, ShopItem[] items){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.items = items;
  }
  
  void display(int playerDrops) {
    fill(255);
    if (mouseOver()) fill(220);
    noStroke();
    rect(x, y + 1, w, h + 40);
    fill(0);
    textAlign(LEFT, CENTER);
    text(items[selectedIndex].name, x + 5, y + 13);

    if (expanded) {
      for (int i = 1; i < items.length; i++) {
        fill(255);
        boolean hovered = mouseX > x && mouseX < x + w && mouseY > y + 25 * i && mouseY < y + 25 * (i + 1);
        boolean affordable = playerDrops >= items[i].price && !items[i].activated;
        items[i].display(x, y + h * i, w, h, affordable, hovered);
      }
    }
  }
  
  boolean mouseOver() {
    return mouseX > x && mouseX < x+w && mouseY > y && mouseY < y+25;
  }
  
  boolean toggle(float mx, float my, int playerDrops) {
    if (mouseOver()) {

      this.expanded = !this.expanded;
    } else if (this.expanded) {
      for (int i = 1; i < items.length; i++) {
        if (mx > x && mx < x+w && my > y + 25*i && my < y + 25*(i+1)) {
          ShopItem item = items[i];
          if(!item.activated && playerDrops >= item.price){
            item.activated = true;
            selectedIndex = i;
            println("Activated item: " + item.name);
            expanded = false;
            return true;
        }
        else{
          println("Not enough money, or already activated.");
        }
        }   
      }
      expanded = false;
  }
  return false;
}
}
