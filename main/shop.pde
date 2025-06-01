import processing.sound.*;

class Shop {
  float x, y, w, h;
  ShopItem[] items;
  int selectedIndex = -1;
  boolean expanded = false;

  PApplet parent;
  SoundFile purchaseSound;

  Shop(PApplet p, float x, float y, float w, float h, ShopItem[] items) {
    this.parent = p;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.items = items;
    this.purchaseSound = new SoundFile(parent, "shop_item_6.mp3");
  }

  void display(int playerDrops) {
    drawShopIcon();

    if (expanded) {
      for (int i = 0; i < items.length; i++) {
        float itemY = y + h * i;
        boolean hovered = isMouseOverItem(i);
        boolean affordable = playerDrops >= items[i].price && !items[i].activated;
        items[i].display(x, itemY, w, h, affordable, hovered);
      }
    }
  }

  void drawShopIcon() {
    float iconX = x + 50;
    float iconY = y + 10;
    float iconSize = 40;

    fill(mouseOverIcon() ? 220 : 255);
    noStroke();
    shape(shopIcon, iconX, iconY, iconSize, iconSize);
  }

  boolean mouseOverIcon() {
    float iconX = x + 50;
    float iconY = y + 10;
    float iconSize = 40;
    return mouseX > iconX && mouseX < iconX + iconSize &&
      mouseY > iconY && mouseY < iconY + iconSize;
  }

  boolean isMouseOverItem(int index) {
    float itemY = y + h * index;
    return mouseX > x && mouseX < x + w &&
      mouseY > itemY && mouseY < itemY + h;
  }

  // Returns true if an item was successfully purchased
  boolean tryPurchaseAt(float mx, float my, int playerDrops) {
    if (mouseOverIcon()) {
      expanded = !expanded;
      return false;
    }

    if (!expanded) return false;

    for (int i = 0; i < items.length; i++) {
      if (isMouseOverItem(i)) {
        ShopItem item = items[i];

        if (!item.activated && playerDrops >= item.price) {
          item.activated = true;
          selectedIndex = i;
          expanded = false;
          println("Activated item: " + item.name);
          return true;
        } else {
          println("Not enough drops or item already activated.");
          expanded = false;
          return false;
        }
      }
    }

    expanded = false;
    return false;
  }

  void handleClick(int playerDrops) {
    boolean bought = tryPurchaseAt(mouseX, mouseY, playerDrops);
    if (bought) {
      purchaseSound.play();
    }
  }
  
  boolean checkShopStatus(){
  return expanded;
  }
}
