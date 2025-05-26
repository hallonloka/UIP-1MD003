import processing.sound.*;

class Shop {
  float x, y, w, h;
  ShopItem[] items;
  int selectedIndex = 0;
  boolean expanded = false;

  PApplet parent;
  SoundFile doubleClickSound;

  Shop(PApplet p, float x, float y, float w, float h, ShopItem[] items) {
    this.parent = p;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.items = items;
    doubleClickSound = new SoundFile(parent, "shop_item_6.mp3");
  }

  void display(int playerDrops) {
    // Draw the shop icon as a toggle button
    float iconX = x + 50;
    float iconY = y +10;
    float iconSize = 40;

    // Highlight when hovered
    if (mouseOverIcon()) fill(220);
    else fill(255);

    noStroke();
    shape(shopIcon, iconX, iconY, iconSize, iconSize);

    // Draw the menu only if expanded
    if (expanded) {
      for (int i = 0; i < items.length; i++) {
        boolean hovered = mouseX > x && mouseX < x + w && mouseY > y + 50 * i && mouseY < y + 50 * (i + 1);
        boolean affordable = playerDrops >= items[i].price && !items[i].activated;
        items[i].display(x, y + h * i, w, h, affordable, hovered);
      }
    }
  }

  boolean mouseOverIcon() {
    float iconX = x + 50;
    float iconY = y + 10;
    float iconSize = 40;
    return mouseX > iconX && mouseX < iconX + iconSize && mouseY > iconY && mouseY < iconY + iconSize;
  }

  boolean toggle(float mx, float my, int playerDrops) {
    if (mouseOverIcon()) {

      this.expanded = !this.expanded;
    } else if (this.expanded) {
      for (int i = 1; i < items.length; i++) {
        if (mx > x && mx < x+w && my > y + 25*i && my < y + 50*(i+1)) {
          ShopItem item = items[i];
          if (!item.activated && playerDrops >= item.price) {
            item.activated = true;
            selectedIndex = i;
            println("Activated item: " + item.name);
            expanded = false;
            return true;
          } else {
            println("Not enough money, or already activated.");
          }
        }
      }
      expanded = false;
    }
    return false;
  }

  void shopClick() {
    boolean bought = shop.toggle(mouseX, mouseY, clicks);
    if (bought) {
      print("item is activated");
      doubleClickSound.play();
    }
  }
}
