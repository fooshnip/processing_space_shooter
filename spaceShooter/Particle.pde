class Particle {
  
  float x,y,z;
  Particle(){
    x = random(width);
    y = random(height);
    z = random(50,200);
  }
  
  void display(){
    checkWall();
    //fill(255);
    stroke(255,z);
    point(x,y);
  }
  
  void checkWall(){
    if(x>width+10){
      x = 0;
      y = random(height);
    }
    if(x<-10){
      x = width;
      y = random(height);
    }
    if(y>height+10){
      x = random(width);
      y = 0;
    }
    if(y<0){
      x = random(width);
      y = height;
    }
  }
  
}
