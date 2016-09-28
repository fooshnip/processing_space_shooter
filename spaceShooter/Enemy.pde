class Enemy{
  
  PVector location;
  PVector velocity;
  PVector acceleration;
  PVector dir;
  PImage ship;
  ArrayList<PVector> trail;
  int h,w;
  float topspeed;
  Enemy(PImage ship){
    int enH = int(random(0,.9999));
    location = new PVector(random(width),height*enH);
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
    w = 30;
    h = 20;
    float add = random(0,4);
    topspeed = 1+add;

    trail = new ArrayList<PVector>();
    this.ship = ship;
  }
  
  void update(Player p){
    PVector mouse = new PVector(p.location.x,p.location.y);
    dir = PVector.sub(mouse,location);
    dir.div(4);
    dir.normalize();
    dir.mult(0.01);
    acceleration = dir;
    velocity.add(acceleration);
    velocity.limit(topspeed);
    location.add(velocity);
  }
  
  void display(){
    float angle = dir.heading();
    noFill();
    strokeWeight(1);
    pushMatrix();
    translate(location.x,location.y);
    rotate(angle);
    image(ship,0,0);
    popMatrix();
  }
  
  boolean isHit(Bullet b){
    if((b.location.x>=location.x-w&&b.location.x<=location.x+w)&&(b.location.y>=location.y-h&&b.location.y<=location.y+h)){
      return true;
    }
    return false;
  }

}
