//----variables----//

//colors
int green = color(131, 255, 145); 
int green2 = color(0, 255, 0);
int red = color(255, 82, 82);
int red2 = color(255, 0 ,0);
int blue = color(82, 167, 255);
int blue2 = color (0, 0, 255);
int white = color(255); 
int yellow = color(250, 255, 0);
int gridStroke = blue;    //set default grid to blue

//scanner
float speed = 10; 

//move
float x = 0;
float y = 0;

//radar diameter
int diam = 120;

//font
PFont Digi_tech;
PFont Digi_tech2;
PFont Space_tech;

//image
PImage img;
PImage img2;
PImage img3;
//image position
float imageX= -300;
float imageY= -100;

//levels
float oxyLevel= 18.0000;          //initial value for oxygen percentage
int mslQty= 10;                  //initial value for missiles
int gunsAmmo = 60;              //initial value for ammuniton
float damage= random(90, 100);  //random variable for damage
String mslStatus ="READY";      //set the initial missile weapon status to "READY"
String gunsStatus = "READY";    //set the initial gun weapon status to "READY"
int fuel = 20;                  //default fuel level

//delay for flashing message
int delay = 1000;// ONE SEC
int now; 
//flag
boolean flash = false;

//class Button, used in controls()
Button button1;
Button button2;
Button button3;

void setup()
{
  size(800, 600);
  Digi_tech = loadFont("Digitaltech-10.vlw"); 
  Digi_tech2 = loadFont("Digitaltech-20.vlw");
  Space_tech = loadFont("Spac3tech-20.vlw");
  textFont(Digi_tech);
  textFont(Digi_tech2);
  textFont(Space_tech);
  img = loadImage("space.jpg");
  img2 = loadImage("space2.jpg");
  img3 = loadImage("space3.jpg");
  now = millis();    //used for delay in flashing message
  //buttons that feature in controls()
  button1 = new Button(360, 420, blue, blue2);
  button2 = new Button(400, 420, red, red2);
  button3 = new Button(440, 420, green, green2);

}//end setup()

void draw()
{
  background(0); //black background
  frameRate(12);  
  //if key is pressed chane imageX to give impression of the ship moving
  if (keyPressed)
  {
    if(keyCode == LEFT)
    {
      imageX+=2;    //increment by 1
    }//end if
  }//end if
  if (keyPressed)
  {
    if(keyCode == RIGHT)
    {
      imageX-=2;    //decrement by 1
    }//end if
  }//end if
  image(img2, imageX, imageY);
  grid();    //display a grid 
  frame();
  move();    //used to control movement of the "scanner"
  //if DOWN key is pushed the scanner function is called
  if (keyPressed)
  {
    if (keyCode == DOWN)
    {
      scanner();    //a "scanner" that pans the screen
    }//end if
  }
  crosshair();
  fuel(width * 0.62, height-25);
  time(width * 0.46, height * 0.04);  //digital clock with position passed
  radar(width * 0.125, height * 0.83);    //radar with position passed
  data(width * 0.81, height * 0.83);    //data with position passed
  controls();
  logo();
  println(mouseX);
  println(mouseY);
}//end draw()

void fuel(float xloc, float yloc)
{
  strokeWeight(1);
  if(frameCount % 90 == 0)    //set delay for fuel consumption
  {
    fuel-=1;
  }//end if
  fill(green2);
  noStroke();
  for (int i=0; i<fuel; i++)
  {
    rect((xloc)-i*10, yloc, 6, 8);    //draws blocks to reprisent fuel amount
  }//end for
  fill(white);
  textFont(Digi_tech);
  text("FUEL", width/2-19, 558);    //print "FUEL" above fuel gauge
  stroke(white);
  line(xloc+8, yloc+10, 305, yloc+10);    //draw horizontal line for fuel gauge
  for(int a=0; a<21; a++)
  {
    line((xloc+8), yloc+10, xloc+8, yloc+4);   //draw vertical lines for fuel gauge
    xloc-=10;    //decrement x location by 10
  }//end for
  stroke(255, 0, 0);    //change color to red for "low" part of guel gauge
  line(453, 585, 505, 585);    //draw line for "low" part of fuel gauge
  xloc = 496;      //reset xloc to start of gauge
  for(int a=0; a<6; a++)
  {
    line((xloc+8), yloc+10, xloc+8, yloc+4);   //draw vertical lines for "low" part of fuel gauge
    xloc-=10;    //decrement x location by 10
  }//end for
  
  if (millis() - now > delay)    //flashing warning message
  { 
    //change flag
    flash = !flash;
    //reset counter
    now = millis();
  }//end if
  
  if(fuel<6 && fuel>0)
  {
    if (flash)
    {
    textFont(Digi_tech2);    //larger font
    fill(red2);
    text("FUEL CRITICALLY LOW", width/2-175, height/2+20);    //print low fuel message
    }//end if
  }//end if
  if(fuel<=0)
  {
    if (flash)
    {
    textFont(Digi_tech2);    //larger font
    fill(red2);
    text("FUEL EMPTY", width/2-100, height/2+20);    //print empty message
    }//end if
  }//end if
}//end fuel()

void move() 
{
  x = x + speed;
  if (x > width)    //if x is bigger than the HUD
  {
    x = 0;   //x is reset to 0 to start again
  }//end if
}//end scan

void scanner()
{
 stroke(red2);
 line(x, y, x, height);
 fill(red2);
 text("SCANNING...", 362, 500);
}//end scanner

void data(float xloc, float yloc)
{
  textFont(Digi_tech);
  if(frameCount % 50 == 0)    //set pace for oxygen level change
  {
  oxyLevel = random(18, 21);  //random numbers of realistic normal oxygen levels
  }//end if
  if(mousePressed && mouseButton == LEFT && mouseY< 399)  //if mouse pressed and left click pressed and mouseY is less than 399
  {
    gunsAmmo-=0.1;    //decriment ammunition
  }//end if
  if(keyPressed)    //if key is pressed ONCE
  {
     if(keyCode == UP)
    {
      mslQty-=0.1;  //decriment missile quantity
    }//end if
  }//end if
  
  //create strings to display data
  String oxy = "02: " + oxyLevel;
  String msl = "MSL: " + mslQty;
  String guns = "GUN: " + gunsAmmo;
  String dmg = "DMG: " + damage;
  
  //display data
  fill(255);
  text(oxy, xloc, yloc);
  text(msl, xloc, yloc+30);
  text(guns, xloc, yloc+60);
  text(dmg, xloc, yloc+90);
  
  //-------missiles------//
  fill(255);
  text(mslStatus, xloc+80, yloc+30);
  if(mslQty < 5 && mslQty > 0)
  {
   mslStatus = "LOW";
   fill(255, 255, 0);
   text(mslStatus, xloc+80, yloc+30);
  }//end if
  
  if(mslQty < 1)
  {
   mslStatus = "EMPTY";
   fill(red2);
   if(frameCount % 10 == 0)    //make "EMPTY" flash
   {
     text(mslStatus, xloc+80, yloc+30);
   }//end if
  }//end if
  
  //-------guns-------//
  fill(255);
  text(gunsStatus, xloc+80, yloc+60);
  if(gunsAmmo < 50 && gunsAmmo>0)
  {
   gunsStatus = "LOW";
   fill(255, 255, 0);
   text(gunsStatus, xloc+80, yloc+60);
  }//end if
  if(gunsAmmo ==0)
  {
   gunsStatus = "EMPTY";
   fill(red2);
   if(frameCount % 10 == 0)    //make "EMPTY" flash
   {
   text(gunsStatus, xloc+80, yloc+60);
   }//end if
  }//end if
}//end data

void crosshair()
{
  noFill();
  strokeWeight(2);
  stroke(255, 0, 0);    //red
  //move crosshair by mouse
  ellipse(mouseX, mouseY, 30, 30);
  ellipse(mouseX, mouseY, 50, 50);
  line(mouseX-30, mouseY-30, mouseX+30, mouseY+30);
  line(mouseX+30, mouseY-30, mouseX-30, mouseY+30);
  
  if(mousePressed && gunsAmmo > 0 && mouseY < 399)    //if mouse pressed and there is ammo left and mouseY is less than 399
  {
    noFill();
    stroke(yellow);
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

void time(float xloc, float yloc)
{
  textFont(Digi_tech);
  fill(255);
  int s = second(); 
  int m = minute(); 
  int h = hour(); 
  text(h + ":" + nf(m, 2) + ":" + nf(s, 2), xloc, yloc);
}//end time()

void radar(float xloc, float yloc)
{ 
  strokeWeight(2);
  stroke(255); 
  noFill();
  if (diam <= 120)
  {                               
    ellipse(xloc, yloc, diam, diam);
    diam += 5;  // increases diameter for next loop
  }//end if
  
  else
  {
    stroke(0, 255, 0); //green flash
    strokeWeight(2);  
    diam -= 120;
  }//end else 
  
  fill(255, 40 ,0);
  ellipse(xloc, yloc, 10, 10);
}//end radar()

void frame()
{
  strokeCap(SQUARE);
  
  //White frame
  stroke(white);
  strokeWeight(5);
  line(0, 320, 120, 400);
  line(120, 400, 680, 400);
  line(680, 400, 800, 320);
  line(0, 80, 80, 0);
  line(720, 0, 800, 80);
  
  //blue center
  //stroke(blue);
  strokeWeight(4);
  //outer center piece
  line(320, 120, 320, 280);  //left vertical
  line(320, 120, 360, 120);  //top left horizontal
  line(320, 280, 360, 280);  //nottom right horizontal
  line(480, 120, 480, 280);  //right vertical
  line(480, 120, 440, 120);  //top right vertical
  line(440, 280, 480, 280);  //bottom right vertical
  //inner center piece
  line(360, 160, 360, 240);  //left verical
  line(360, 160, 380, 160);  //top left horizontal
  line(360, 240, 380, 240);  //bottom left horizontal
  line(440, 160, 440, 240);  //right verical
  line(440, 160, 420, 160);  //top right horizontal
  line(440, 240, 420, 240);  //bottom right horizontal
}//end frame()

void grid()
{
  //grid calculations
  int widthSpace = 40;     
  int heightSpace = 40; 
  strokeWeight(2);
  stroke(gridStroke);    //set line color
  
  for(int i = 0; i < width; i += widthSpace)
  { 
     line(i, 0, i, height);
  }//end for loop

  for(int w=0; w<height; w+=heightSpace)
   {
     line(0, w, width, w);
   }//end for loop
}//end grid()

void controls()
{
  button1.run();
  button2.run();
  button3.run();
}//end controls

void logo()
{
  fill(white);
  textFont(Space_tech);
  text("deltacorp", 10, height-10);
}//end logo()