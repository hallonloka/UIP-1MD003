/*
  Class: Shop
 Handles all functionality regarding the shop, including the icon, menu expansion, and item interaction
 */
class Shop {
  float x, y, w, h;
  ShopItem[] items;
  int selectedIndex = -1;
  boolean expanded = false;
  boolean tutorialBoolean = false;

  // Reffering to parent (main) in order to access sound file.
  PApplet parent;
  SoundFile purchaseSound;

  // Constructor
  Shop(PApplet p, float x, float y, float w, float h, ShopItem[] items) {
    this.parent = p;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.items = items;
    this.purchaseSound = new SoundFile(parent, "shop_item_2.mp3");
  }

  // Method for displaying shop
  void display(int playerDrops) {
    drawShopIcon();

    if (expanded) {
      for (int i = 0; i < items.length; i++) {
        float itemY = y + height * 0.15 + h * i;
        boolean hovered = isMouseOverItem(i);
        boolean affordable = playerDrops >= items[i].price && !items[i].activated;
        items[i].display(x, itemY, w, h, affordable, hovered);
      }
    }
  }

  // Method for drawing shop icon
  void drawShopIcon() {
    float iconX = x + width*0.04;
    float iconY = y + height*0.025;
    float iconSize = height*0.1;

    fill(mouseOverIcon() ? 220 : 255);
    noStroke();
    shape(shopIcon, iconX, iconY, iconSize, iconSize);
  }
  
  // Method for checking if cursor is over shop icon
  boolean mouseOverIcon() {
    float iconX = x + width*0.04;
    float iconY = y + height*0.025;
    float iconSize = height*0.1;
    return mouseX > iconX && mouseX < iconX + iconSize &&
      mouseY > iconY && mouseY < iconY + iconSize;
  }
  
  // Method for checking if cursor is over item in shop
  boolean isMouseOverItem(int index) {
    float itemY = y + height * 0.15 + h * index;
    return mouseX > x && mouseX < x + w &&
      mouseY > itemY && mouseY < itemY + h;
  }

  // Method for checking if item was bought 
  // Returns true if an item was successfully purchased
  boolean tryPurchaseAt(float mx, float my, int playerDrops) {
    // Toggle shop
    if (mouseOverIcon()) {
      expanded = !expanded;
      return false;
    }
    
    if (!expanded) return false;

    // Loop for checking if item can be bought
    for (int i = 0; i < items.length; i++) {
      if (isMouseOverItem(i)) {
        ShopItem item = items[i];

        if (!item.activated && playerDrops >= item.price) {
          item.activated = true;
          selectedIndex = i;
          println(printActItemText + item.name);
          tutorialBoolean = true;
          expanded = false;
          return true;
        } else {
          println(printNotValidShop);
          expanded = false;
          return false;
        }
      }
    }
    expanded = false;
    return false;
  }

  // Method for checking if shop is expanded 
  boolean checkShopStatus() {
    return expanded;
  }
}
