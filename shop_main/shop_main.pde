Shop shop;
int playerDrops = 60;
float shopx = width*4;
float shopy = (0.2*height);
float w = 250;
float h = 50;

void setup() {
  size(700, 500, P3D);
  
  PShape icon1 = createCircle(0,0);
  PShape icon2 = createRect(-10,-5);
  PShape icon3 = star(0, 0, 15, 40, 10); 
  
  ShopItem[] shopItems = {
    new ShopItem("Shop", 0, icon1, 0),
    new ShopItem("Double Click", 50, icon1, 0),
    new ShopItem("Auto Click", 100,icon3, 0.1),
    new ShopItem("Mega Boost", 150, icon2, 0.5)
  };
  
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
