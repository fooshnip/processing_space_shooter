class CircleBeat {
  
  PVector location;
  float size;
  CircleBeat(Player p){
    location = new PVector(p.location.x,p.location.y);
  }
  
  void display(){
    update();
    noFill();
    strokeWeight(4);
    stroke(0,random(200,220),200,400-size);
    ellipse(location.x,location.y,size,size);
  }
  
  void update(){
    size += 10;
  }
}
