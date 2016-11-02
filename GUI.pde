color slider_color = color(255, 0, 0);
float x = 0;
float y = 3;
float speed = 25;
int widthSpace=40;
int heightSpace=40;

int diam=140;

PImage img;

PFont Digi_tech;


String gun= "GUN";




void setup()
{
  size(800, 400);
  //img = loadImage("space.jpg");
  Digi_tech = loadFont("Digitaltech-10.vlw"); 
  textFont(Digi_tech);
}



void draw()
{
  background(0);
  frameRate(12);  // 24 frames per second 
  //smooth(); 
  //image(img, -100, -100);
  move();
  slider();
  grid();
  time(15, 390);
  data(484, 300);
  //rect(480, 280, 320, 120);
  radar(width*0.125, height*0.75);
}


void data(int xpos, int ypos)
{
  float oxylevel = random(18, 21);
  String oxy= "02: " + oxylevel;
  text(oxy, xpos, ypos);
  text("GUN:", xpos, ypos+30);
  text("MSSL:", xpos, ypos+60);
  text("DMG:", xpos, ypos+90);
}

void time(int xpos, int ypos)
{
  int s = second(); 
  int m = minute(); 
  int h = hour(); 
  text(h+":"+m+":"+s, xpos, ypos);
}

void radar(float xloc, float yloc)
{ 
  stroke(255); 
  noFill();
  if (diam <= 140)
  {                               
    ellipse(xloc, yloc, diam, diam);
    diam += 6;  // increases diameter for next loop
  }
  
  else
  {
    stroke(0, 255, 0);
    strokeWeight(2);  
    diam -= 140;
  }
  
  fill(255,40,0);
  ellipse(xloc, yloc, 10, 10);
}

void grid()
{
  stroke(82, 167, 255);      //(131, 255, 145)green  (255, 82, 82)red  (82, 167, 255)blue
  for(int i=0; i<width; i+=widthSpace)
  { 
     line(i, 0, i, height);
  }

 for(int w=0; w<height; w+=heightSpace)
 {
   fill(255);
   line(0, w, width, w);
 }
}
 
void move() 
{
  x = x + speed;
  if (x > width)
  {
    x = 0;
  }
}

void slider()
{
  stroke(0);
  fill(slider_color);
  rect(x, y, 30, 10); 
}