Shop shop;
int playerDrops = 60;
float shopx = width*4;
float shopy = (0.2*height);
float w = 250;
float h = 50;

void setup() {
  size(700, 500, P3D);
  
  ShopItem[] shopItems = createIcons();
  shop = new Shop(shopx, shopy, w, h, shopItems);
  textFont(createFont("Arial", 20));
}

void draw(){
  background(190, 110, 150);
  shop.display(playerDrops);
}

void mousePressed(){
  boolean bought = shop.toggle(mouseX, mouseY, playerDrops);
  if(bought){
    print("item is activated");
}
}
