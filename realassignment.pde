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

//image
PImage img;
//image position
float image1= -100;
float image2= -100;

//levels
float oxyLevel= 18.0000;          //initial value for oxygen percentage
int mslQty= 10;                  //initial value for missiles
int gunsAmmo = 60;              //initial value for ammuniton
float damage= random(90, 100);  //random variable for damage
String mslStatus ="READY";      //set the initial missile weapon status to "READY"
String gunsStatus = "READY";    //set the initial gun weapon status to "READY"

void setup()
{
  size(800, 400);
  Digi_tech = loadFont("Digitaltech-10.vlw"); 
  textFont(Digi_tech);
  img = loadImage("space.jpg");
}//end setup()

void draw()
{
  background(0); //black background
  frameRate(12);  // 24 frames per second 
  image(img, image1, image2);
  grid();        //display a grid 
  move();        //used to control movement of the "scanner"
  //if DOWN key is pushed the scanner function is called
  if (keyCode == DOWN)
  {
    scanner();    //a "scanner" that pans the screen
  }//end if
  crosshair();
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
  if(frameCount % 50 == 0)    //set pace for oxygen level change
  {
  oxyLevel = random(18, 21);  //random numbers of realistic normal oxygen levels
  }//end if
  if(mousePressed && mouseButton == LEFT)  //if mouse pressed and left click pressed
  {
    gunsAmmo-=0.2;    //decriment ammunition
  }//end if
  if(keyPressed)    //if key is pressed ONCE
  {
     if(keyCode == UP)
    {
      mslQty-=0.2;  //decriment missile quantity
    }//end if
  }//end if
  
  //create strings to display data
  String oxy = "02: " + oxyLevel;
  String msl = "MSL: " + mslQty;
  String guns = "GUN: " + gunsAmmo;
  String dmg = "DMG: " + damage;
  
  //display data
  fill(255);
  text(oxy, xpos, ypos);
  text(msl, xpos, ypos+30);
  text(guns, xpos, ypos+60);
  text(dmg, xpos, ypos+90);
  
  //-------missiles------//
  fill(255);
  text(mslStatus, xpos+80, ypos+30);
  if(mslQty < 5 && mslQty > 0)
  {
   mslStatus = "LOW";
   fill(255, 255, 0);
   text(mslStatus, xpos+80, ypos+30);
  }//end if
  
  if(mslQty < 1)
  {
   mslStatus = "EMPTY";
   fill(red);
   if(frameCount % 10 == 0)    //make "EMPTY" flash
   {
     text(mslStatus, xpos+80, ypos+30);
   }//end if
  }//end if
  
  //-------guns-------//
  fill(255);
  text(gunsStatus, xpos+80, ypos+60);
  if(gunsAmmo < 50 && gunsAmmo>0)
  {
   gunsStatus = "LOW";
   fill(255, 255, 0);
   text(gunsStatus, xpos+80, ypos+60);
  }//end if
  if(gunsAmmo ==0)
  {
   gunsStatus = "EMPTY";
   fill(red);
   if(frameCount % 10 == 0)    //make "EMPTY" flash
   {
   text(gunsStatus, xpos+80, ypos+60);
   }//end if
  }//end if
}//end data

void crosshair()
{
  noFill();
  stroke(red);
  //move crosshair by mouse
  ellipse(mouseX, mouseY, 30, 30);
  ellipse(mouseX, mouseY, 50, 50);
  line(mouseX-30, mouseY-30, mouseX+30, mouseY+30);
  line(mouseX+30, mouseY-30, mouseX-30, mouseY+30);
  
  if(mousePressed && gunsAmmo > 0)    //if mouse pressed and there is ammo left
  {
    noFill();
    stroke(255);
    //white crosshair within main one when mouse clicked
    ellipse(mouseX, mouseY, 20, 20);
    line(mouseX-20, mouseY-20, mouseX+20, mouseY+20);
    line(mouseX+20, mouseY-20, mouseX-20, mouseY+20);
  }//end if
  
  /*----stationary central crosshair----
  ellipse(width/2, height/2, 30, 30);
  line(width/2-30, height/2-30, width/2+30, height/2+30);
  line(width/2+30, height/2-30, width/2-30, height/2+30);
  */
}//end crosshair()

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