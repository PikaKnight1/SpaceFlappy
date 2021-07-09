void setup()
{
 size(1280, 720);
}

int highScore = 0;

// tło
void DrawBackground() {
int x =0, y=0;
  do { 
    stroke(0,0, y/10);
    line(x,y,1280,y);  
     y++;
  } while (y < 720);   
}

void DrawRandomStars() {
    for (int i = 0; i < 500; i++) {  
    stroke(255,255,random(255)); 
    point(random(1280),random(720));  
  }   
}

//gracz

class Player {
   public float y;
   public boolean direction; //true = down, false = up
   public float speed;
   public int points;
   
   public void addPoint() {
    this.points++; 
   }
   
   public void addToY(float y) {
       this.y += y;
   }
   public void setDirection(boolean dir) {
    this.direction = dir; 
   }  
   public void setSpeed(float speed) {
    this.speed = speed; 
   }
   Player() {
   this.y = 360;
   this.direction = true;
   this.speed = 0.2;
   }
      
}

//rury

class Obstacle {
  public float x;
  public float yLow;
  public float yHigh;
  
  void moveObstacle() {
   this.x -= 5; 
  }
  
  public Obstacle() { 
   this.x = 1400;
   this.yHigh = random(800);
   this.yLow = yHigh + 300;
  }
    public Obstacle(int x) { 
   this.x = x;
   this.yHigh = random(400);
   this.yLow = yHigh + 200;
  }
}

Player player = new Player();
Obstacle obs1 = new Obstacle(1000);
Obstacle obs2 = new Obstacle(1320);
Obstacle obs3 = new Obstacle(1640);
Obstacle obs4 = new Obstacle(1960);

  boolean play = false;
  int game = 0;

//pętla
void draw()
{ 
  if(!play) {
    if(player.points > highScore) highScore = player.points;
    play = menu();
    game = 0;
  }
  if(play) {
        if(game == 0) {  
      player = new Player();
   obs1 = new Obstacle(1000);
   obs2 = new Obstacle(1400);
   obs3 = new Obstacle(1800);
   obs4 = new Obstacle(2200);
   game = 1; }

    play = gameplay(); 
    
}
  }
//menu

boolean menu() {
   DrawBackground();
   DrawRandomStars();
textSize(72);
textAlign(CENTER);
fill(255,255,255);
text("Space Flappy Bird", 640, 220); 
textSize(48);
text("Najlepszy wynik:", 640, 320); 
textSize(48);
text(highScore, 640, 370); 
textSize(12);
text("Instrukcja:", 300, 580); 

text("Dowolny przycisk na klawiaturze: skok", 300, 600); 
textSize(48);

if(dist(mouseX,mouseY,640,500)<80) fill(255,0,0);
if (dist(mouseX,mouseY,640,500)<80 && mousePressed == true) return true;
text("Play", 640, 500);
fill(255,255,255);

return false;
}

//gameplay
boolean gameplay(){
  int i = 0;
  DrawBackground();
  if (i%100 == 0) DrawRandomStars();
  drawPlayerOne(player.y);
  drawObstacle(obs1) ;
  drawObstacle(obs2) ;
  drawObstacle(obs3) ;
  drawObstacle(obs4) ;

  obs1.moveObstacle();
  if (obs1.x < 0) { obs1 = new Obstacle(1600); player.addPoint();}
  obs2.moveObstacle();
   if (obs2.x < 0){ obs2 = new Obstacle(1600);player.addPoint();}
  obs3.moveObstacle();
   if (obs3.x < 0) {obs3 = new Obstacle(1600);player.addPoint();}
     obs4.moveObstacle();
   if (obs4.x < 0){ obs4 = new Obstacle(1600);player.addPoint();}

textSize(72);
textAlign(CENTER);
fill(255,255,255);
text(player.points, 640, 220); 

  movePlayer();
  if (gameOver()) return false;
   i++;
   return true;
   

 
}

void drawPlayerOne(float y){
  fill(230,230,0);
  ellipse(150, y, 100, 80);
  fill(0,0,0);
  circle(180,y-10,15);
    fill(255,255,255);

    circle(180,y-12,3);
    noFill();
    stroke(0,0,0);
    fill(128,128,0);
    ellipse(130, y+10, 70, 40);

}

void drawObstacle(Obstacle obs) {
     
  fill(0,200,0);
   rect(obs.x, 0,50 ,obs.yHigh-20);
   rect(obs.x, obs.yLow+10,50, 1000);

        fill(0,170,0);
   rect(obs.x+10, 0,35 ,obs.yHigh-20);
   rect(obs.x+10, obs.yLow+10, 35, 1000);

        fill(0,140,0);
   rect(obs.x+20, 0,25 ,obs.yHigh-20);
   rect(obs.x+20, obs.yLow+10, 25, 1000);

  rect(obs.x-10, obs.yHigh-30,70 ,30);
  

  rect(obs.x-10, obs.yLow-10,70 ,30);

}


void keyPressed()
{
  player.setDirection(false);
  player.setSpeed(-10);
  
}

void movePlayer() {
  player.addToY(player.speed);
  player.setSpeed(player.speed+abs(player.speed/8));
  if(player.speed > -0.2 && player.speed < 0.2)player.setSpeed(0.2);
}

boolean gameOver() {
   if(player.y > 690 || player.y < 40) return true; 
   if(obsColTest(obs1)) return true;
   if(obsColTest(obs2)) return true;
   if(obsColTest(obs3)) return true;
   if(obsColTest(obs4)) return true;

   else return false;
}

boolean obsColTest(Obstacle obs) {
  if(obs.x > 50 && obs.x < 200) {
     if(player.y-30 < obs.yHigh) return true;
     if(player.y+30 > obs.yLow) return true;
  }
  return false;
}
  
