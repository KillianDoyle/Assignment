// grid colors
int green = color(131, 255, 145);  
int red = color(255, 82, 82);
int blue = color(82, 167, 255);

//scanner
color scanner_color = red; // red
float speed = 20; //scanner speed

//move
float x = 0;
float y = 0;

//radar diameter
int diam = 120;

//font
PFont Digi_tech;

//levels
float oxyLevel= 18.0000;          //initial value for oxygen percentage
int mslQty= 10;                  //initial value for missiles
int gunsAmmo = 60;              //initial value for ammuniton
float damage= random(90, 100);  //random variable for damage

void setup()
{
  size(800, 400);
  Digi_tech = loadFont("Digitaltech-10.vlw"); 
  textFont(Digi_tech);
  
}//end setup()

void draw()
{
  background(0); //black background
  frameRate(12);  // 24 frames per second 
  grid();        //display a grid 
  move();        //used to control movement of the "scanner"
  //if DOWN key is pushed the scanner function is called
  if (keyCode == DOWN)
  {
    scanner();    //a "scanner" that pans the screen
  }//end if
  time(15, 390);  //digital clock
  radar(width*0.125, height*0.75);    //radar with position passed
  data(484, 300);    //data with position passed
}//end draw()

void move() 
{
  x = x + speed;
  if (x > width)
  {
    x = 0;
  }//end if
}//end scan

void scanner()
{
  stroke(scanner_color);
  line(x, y, x, y+width); 
}//end scanner

void data(int xpos, int ypos)
{
  String oxy = "02: " + oxyLevel;
  String msl = "MSL: " + mslQty;
  String guns = "GUN: " + gunsAmmo;
  String dmg = "DMG: " + damage;
  
  fill(255);
  text(oxy, xpos, ypos);
  text(msl, xpos, ypos+30);
  text(guns, xpos, ypos+60);
  text(dmg, xpos, ypos+90);
}

void time(int xpos, int ypos)
{
  fill(255);
  int s = second(); 
  int m = minute(); 
  int h = hour(); 
  text(h + ":" + nf(m, 2) + ":" + nf(s, 2), xpos, ypos);
}//end time()

void radar(float xloc, float yloc)
{ 
  
  stroke(255); 
  noFill();
  if (diam <= 120)
  {                               
    ellipse(xloc, yloc, diam, diam);
    diam += 5;  // increases diameter for next loop
  }//end if
  
  else
  {
    stroke(0, 255, 0);
    strokeWeight(2);  
    diam -= 120;
  }//end else 
  
  fill(255, 40 ,0);
  ellipse(xloc, yloc, 10, 10);
}//end radar()

void grid()
{
  //grid calculations
  int widthSpace = 40;     
  int heightSpace = 40; 
  
  stroke(blue);    //set line color
  
  for(int i = 0; i < width; i += widthSpace)
  { 
     line(i, 0, i, height);
  }//end for loop

  for(int w= 0; w < height; w += heightSpace)
   {
     line(0, w, width, w);
   }//end for loop
}//end grid()