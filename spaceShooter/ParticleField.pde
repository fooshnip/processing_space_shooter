class ParticleField {
  
  Particle[] pfield;
  
  ParticleField(int numParticles){
    pfield = new Particle[numParticles];
    for(int i=0;i<numParticles;i++){
      pfield[i] = new Particle();
    }
  }
  
  void update(Player p){
    for(int i=0;i<pfield.length;i++){
       pfield[i].x -= (pfield[i].z/100)*p.velocity.x/50*6;
       pfield[i].y += (pfield[i].z/150);
       //pfield[i].y += 2;
       pfield[i].x += 0.1;
    }
  }
  
  void display(int isBeat){
    for(int i=0;i<pfield.length;i++){
      float x = random(0,2);
      if(x>1.5){
        strokeWeight(pfield[i].z/(300));
      } else {
        strokeWeight(pfield[i].z/(isBeat*80));
      }
      pfield[i].display();
    }
  }
}
