class Point {
 
  float x,y;
  Point(float x, float y, int wt){
    this.x = x;
    this.y = y;
    strokeWeight(wt);
    noFill();
    stroke(random(255),random(255),random(255));
    strokeJoin(MITER);
    strokeCap(PROJECT);
  }
  
  public float getX(){
    return x;
  }
  
  public float getY(){
    return y;
  }
  
  void display(){
    point(x,y);
  }
  
}
