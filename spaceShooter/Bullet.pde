class Bullet{
  
  PVector location;
  PVector velocity;
  ArrayList<PVector> trail;
  int h,w;
  float accuracy;
  String keyStroke;
  color bulletCol;
  PVector shootDirection;
  
  Bullet(Player p){
    location = new PVector(p.location.x+(p.dir.x),p.location.y+(p.dir.y));
    velocity = new PVector(0,0);
    h=2;
    w=10;
    trail = new ArrayList<PVector>();
    accuracy = random(-0.5,0.5);
    bulletCol = color(0,220,200);
    fill(bulletCol,150);
    noStroke();
    //arc(p.location.x,p.location.y,10,10,PI,2*PI);
    shootDirection = new PVector(p.dir.x,p.dir.y);
    shootDirection.mult(6);
    shootDirection.x+=accuracy;
    shootDirection.y+=accuracy;

//    sound.setGain(-50);
//    sound.trigger();
  }
  
  void updateTrail(){
    trail.add(new PVector(location.x,location.y));
    if(trail.size()>3){
      trail.remove(0);
    }
  }
  
  void display(){
    //updateTrail();
    update();
    float angle = velocity.heading();
    pushMatrix();
    rectMode(CENTER);
    translate(location.x,location.y);
    text(angle,100,100);
    rotate(angle);
    //for(int i=0;i<trail.size();i++){
    //  float tx = trail.get(i).x-5;
    //  float ty = trail.get(i).y;
      //fill(bulletCol,300-i*50);
      fill(bulletCol);
      noStroke();
      rect(0,0,w,h);
    //}
    popMatrix();
  }
  
  void update(){
    velocity.add(shootDirection);
    location.add(velocity);
  }
}
