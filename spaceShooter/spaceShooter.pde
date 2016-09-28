import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;


import java.util.Iterator;
import java.util.Random;

Minim minim;
BeatDetect beat;
BeatListener bl;
AudioInput lineIn;
FFT         fft;

Player p;
ParticleField pf;
Planet pnt;
ArrayList<Bullet> bullets;
ArrayList<Enemy> enemies;
ArrayList<CircleBeat> circles;
//ArrayList<Point> mouseTrail;
int startTime;
int score;
int topSession = 0;
int topEnemies = 0;

AudioSample file;

PImage ship;
PImage earth;
PImage shipUI;

void setup(){
 size(1200,900);
 //size(displayWidth,displayHeight);
 minim = new Minim(this);
 
 lineIn = minim.getLineIn(Minim.STEREO, 2048);
 beat = new BeatDetect(lineIn.bufferSize(), lineIn.sampleRate());
 fft = new FFT(lineIn.bufferSize(), lineIn.sampleRate());
 fft.logAverages(30, 5);
 
 beat.setSensitivity(10);  
 bl = new BeatListener(beat, lineIn); 

 background(0);
 pf = new ParticleField(width/2);
 pnt = new Planet();
 p = new Player();
 bullets = new ArrayList<Bullet>();
 enemies = new ArrayList<Enemy>();
 circles = new ArrayList<CircleBeat>();
 startTime=millis();
 score = 0;
 
 ship = loadImage("Assets/enemy1.png");
 earth = loadImage("Assets/earf.png");
 shipUI = loadImage("Assets/blueshipUp.png");
    ship.resize(50,0);
    earth.resize(75,0);
    shipUI.resize(25,0);
}

void draw(){
  
  frameRate(60);
  background(0);
  fft.forward(lineIn.mix);
  if((millis()-startTime)<2000){
    fill(255);
    text("Loading...",100,100);
  } else {
  strokeWeight(1);
  stroke(0,220,200);
  float progressRate = height-150-(millis()-startTime)/300;
  float progression = (height-150-progressRate)/(height-300);
  fill(255);
  text(round(progression*100) + "%",65,progressRate+20);
  line(100,150,100,progressRate);
  stroke(220,200,0);
  line(100,progressRate,100,height-150);
  noTint();
  image(earth,62.5,100);
  if(progression<=1){
    image(shipUI,88,progressRate);
  } else {
    background(random(0,25));
    if(score>topSession){
        topSession = score;
    }
  }
  fill(255);
  text("fps: " + int(frameRate),20,30);
  text("MOST ENEMIES PUT TO REST: " + topSession,100,15);
  text("MOST ENEMIES ON SCREEN: " + topEnemies,100,35);
  text("CURRENT ENEMIES SLEEPING: " + score,100,55);
  text("CURRENT ENEMIES ATTACKING: " + enemies.size(),100,75);
  noCursor();
  pf.update(p);
  int bd = 2;
  int numSpawns = 0;
  if(progression<0.10){
    numSpawns = 2;
  } else if(progression>=0.1&&progression<0.25){
    numSpawns = 3;
  } else if(progression>=0.25&&progression<0.50){
    numSpawns = 4;
  } else if(progression>=0.5&&progression<0.75){
    numSpawns = 4;
  } else if(progression>=0.9&&progression<=1){
    numSpawns = 5;
  }
  if(beat.isKick()){
    if(int(random(0,numSpawns))>0){
      for(int i=0;i<numSpawns;i++){
        enemies.add(new Enemy(ship));
      }
    }
    bd = 1;
    circles.add(new CircleBeat(p));
  }
  ArrayList<Enemy> eCopy = new ArrayList<Enemy>(enemies);
  ArrayList<CircleBeat> cCopy = new ArrayList<CircleBeat>(circles);
  for(CircleBeat c:cCopy){
    if(c.size>300){
      circles.remove(c);
    }
    for(Enemy e:eCopy){
      float dx = abs(e.location.x-c.location.x);
      float dy = abs(e.location.y-c.location.y);
      if(dx<=c.size-50&&dy<=c.size-50){
        text(e.location.x,e.location.x,e.location.y);
        enemies.remove(e);
        score+=1;
      }
    }
    c.display();
  }
  p.display();
  pf.display(bd);
  pnt.display();
  if(enemies.size()>topEnemies){
    topEnemies = enemies.size();
  }
  
  ArrayList<Bullet> bCopy = new ArrayList<Bullet>(bullets);
  if(enemies.size()>150){
    enemies.remove(0);
  }
  for(Enemy e:eCopy){
    e.update(p);
    e.display();
    for(Bullet b:bCopy){
      if(e.isHit(b)){
        text(e.location.x,e.location.x,e.location.y);
        bullets.remove(b);
        enemies.remove(e);
        score+=1;
      }
    }
   if((e.location.x>=p.location.x-p.w&&e.location.x<=p.location.x+p.w)&&(e.location.y>=p.location.y-p.h&&e.location.y<=p.location.y+p.h)){
      background(255);
      bullets = null;
      lineIn.close();
      minim.stop();
      if(score>topSession){
        topSession = score;
      }
      setup();
      score = 0;
    }
  }
  
  for(Bullet b:bCopy){
    b.display();
    if(b.location.y>height){
      bullets.remove(b);
    }
  }
  
  strokeWeight(5);
  stroke(255,0,0);
  point(mouseX,mouseY);
  }
}

//void mouseClicked(){
//  startTime = millis();
//  delay(200);
//  setup();
//}

void keyReleased(){
  if(key=='f'){
    if(p!=null){
      bullets.add(new Bullet(p));
      bullets.add(new Bullet(p));
      bullets.add(new Bullet(p));
      bullets.add(new Bullet(p));
      bullets.add(new Bullet(p));
      bullets.add(new Bullet(p));
    }
  }
}