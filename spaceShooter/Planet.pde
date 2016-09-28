class Planet {
  
  PVector location;
  PVector velocity;
  PImage pnt;
  Planet(){
    location = new PVector(random(width),random(height));
    velocity = new PVector(random(-1,1),random(-0.5,0.5));
    
    pnt=loadImage("Assets/planet_purple.png");
  }
  
  void display(){
    update();
    checkWalls();
    noTint();
    image(pnt,location.x,location.y);
  }
  
  void update(){
    location.add(velocity);
  }
  
  void checkWalls(){
    if(location.x>width+200){
      location.x=-20;
      location.y=random(height);
    }
    if(location.x<-300){
      location.x=width;
      location.y=random(height);
    }
  }
}
