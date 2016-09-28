class Player {
  
  PVector location;
  PVector velocity;
  PVector acceleration;
  PVector dir;
  PImage ship;
  ArrayList<PVector> trail;
  //ArrayList<PVector> pTrail;
  int h,w;
  float topspeed;
  boolean moveToggle;
  float targx,targy;
  Player(){
    location = new PVector(width/2,height/2);
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
    //pTrail = new ArrayList<PVector>();
    //pTrail.add(new PVector(mouseX,mouseY));
    w = 30;
    h = 20;
    topspeed = 4;

    trail = new ArrayList<PVector>();
    ship = loadImage("Assets/blueship.png");
    ship.resize(50,0);
    moveToggle=false;

//    targx = pTrail[0].getX();
//    targy = pTrail[0].getY();
  }
  
  void updatePlayer(){
    PVector mouse = new PVector(mouseX,mouseY);
    dir = PVector.sub(mouse,location);
    dir.div(4);
    dir.normalize();
    dir.mult(0.6);
    if(keyPressed){
      if(key=='s'){
        moveToggle=true;
        velocity.mult(10);
      }
      if(key=='d'){
        moveToggle=false;
      }
    }
    if(moveToggle==true){
      acceleration = dir;
    } else {
      acceleration.mult(0);
      velocity.mult(0);
    }
    velocity.add(acceleration);
    velocity.limit(topspeed);
    location.add(velocity);
  }
  
  void updateTrail(){
      //pTrail.add(new PVector(mouseX,mouseY));
      //if(pTrail.size()>60){
      //  pTrail.remove(0);
      //}
      //beginShape();
      //stroke(random(255),random(255),random(255));
      //strokeWeight(5);
      //strokeCap(PROJECT);
      //curveTightness(0);
      //for(PVector p:pTrail){
      //  curveVertex(p.x,p.y);
      //}
      //endShape(OPEN);
    
    trail.add(new PVector(location.x,location.y));
    if(trail.size()>5){
      trail.remove(0);
    }
  }
  
  void display(){
    updatePlayer();
    float angle = dir.heading();
    noFill();
    strokeWeight(1);
    updateTrail();
    pushMatrix();
    translate(location.x,location.y);
    rotate(angle);
    for(int i=0;i<trail.size();i++){
      stroke(255,i*20);
      float tx = trail.get(i).x;
      float ty = trail.get(i).y;
      tint(255, i*50);
      float dx,dy;
      if(velocity.x>0){
        dx = tx-location.x;
      } else {
        dx = location.x-tx;
      }
      if(velocity.y>0){
        dy = ty-location.y;
      } else {
        dy = location.y-ty;
      }
      image(ship,dx+(dy)/2-ship.width/2,-ship.height/2);
    }
    popMatrix();
  }
  
}