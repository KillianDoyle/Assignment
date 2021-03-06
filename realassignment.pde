import ddf.minim.*;

Minim minim;
AudioPlayer button;
AudioPlayer toggle;
AudioPlayer engines;
AudioPlayer guns;
AudioPlayer missile;
AudioPlayer alarm;

//----variables----//

//colors
int gridGreen = color(131, 255, 145); 
int green = color(0, 255, 0);
int darkGreen = color(8, 137, 0);
int gridRed = color(255, 82, 82);
int red = color(255, 0 ,0);
int darkRed = color(180, 0, 0);
int gridBlue = color(82, 167, 255);
int blue = color (0, 0, 255);
int darkBlue = color(5, 0, 180);
int white = color(255); 
int yellow = color(250, 255, 0);
int gridStroke = gridBlue;    //set default grid to gridBlue

//scanner
float speed = 10; 

//move
float x = 0;
float y = 0;

//radar diameter
int diam = 120;

//font
PFont Arial;
PFont Digi_tech;
PFont Digi_tech2;
PFont Digi_tech3;
PFont Space_tech;

//images
PImage img2;

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
int fuel = 10;                  //default fuel level

//delay for flashing message
int delay = 1000;// ONE SEC
int now; 
//flag
boolean flash = false;
 
//class Button, used in controls()
Button button1;
Button button2;
Button button3;
//class WpnSelect, used in controls()
Switch wpn;
Switch engine;

//flags for switches
int gunFlag = 1;
int mslFlag = 0;
int fuelFlag=0;


void setup()
{
  size(800, 600);
  
  //sounds
  minim = new Minim(this);
  button = minim.loadFile("Button.mp3");
  toggle = minim.loadFile("Toggle.mp3");
  engines = minim.loadFile("Engines.mp3");
  guns = minim.loadFile("Laser_Blast.mp3");
  missile = minim.loadFile("Missile.mp3");
  alarm = minim.loadFile("Alarm.mp3");
  
  //fonts
  Arial = loadFont("Arial-Black-16.vlw");
  Digi_tech = loadFont("Digitaltech-10.vlw"); 
  Digi_tech2 = loadFont("Digitaltech-20.vlw");
  Digi_tech3 = loadFont("Digitaltech-8.vlw");
  Space_tech = loadFont("Spac3tech-20.vlw");
  textFont(Digi_tech);
  textFont(Digi_tech2);
  textFont(Space_tech);
  
  //images
  img2 = loadImage("space2.jpg");
  
  now = millis();    //used for delay in flashing message
  
  //buttons that feature in controls()
  button1 = new Button(360, 420, darkBlue, blue);
  button2 = new Button(400, 420, darkRed, red);
  button3 = new Button(440, 420, darkGreen, green);
  wpn = new Switch("Weapons", "GUN", "MSL", 483, 485, 35, 20, red, red);
  engine = new Switch("Engines", "OFF", "ON", 243, 485, 35, 20, yellow, yellow);
}//end setup()



void draw()
{
  //background(0); //black background
  frameRate(12);  //slow down frame rate to control animation and ammunition consumption
  //if key is pressed chane imageX to give impression of the ship moving
  if(fuelFlag==1 && fuel > 0)
  {
    if(keyPressed && keyCode == LEFT)
    {
      imageX+=2;    //increment by 1
    }//end if
    if(keyPressed && keyCode == RIGHT)
    {
      imageX-=2;    //decrement by 1
    }//end if
      if(keyPressed && keyCode == UP)
    {
      imageY+=2;    //increment by 1
    }//end if
    if(keyPressed && keyCode == DOWN)
    {
      imageY-=2;    //decrement by 1
    }//end if
  }//end if
  //set boundaries
  if (imageX > -17)
  {
    imageX = imageX - 2;
  }//end if
  if(imageX < -760)
  {
    imageX = imageX + 2;
  }//end if
  if(imageY > -8)
  {
    imageY = imageY  -2;
  }//end if
  if(imageY < -260)
  {
    imageY = imageY +2;
  }//end if
  image(img2, imageX, imageY);    //image background
  //if DOWN is pressed the scanner function is called
  if (keyPressed)
  {
    if (keyCode == CONTROL)
    {
      move();    //used to control movement of the "scanner"
      scanner();    //a "scanner" that pans the screen
    }//end if
  }//end if
  grid();    //display a grid 
  frame();
 /*if CONTROL is pressed the scannerText() function is called
   this function is called seperately to scanner() so the text
   appears above the transparent elemnent of the control panel */
  if (keyPressed)
  {
    if (keyCode == CONTROL)
    {
      scannerText(365, 505);            //scanner with position passed
    }//end if
  }
  crosshair();
  fuel(width * 0.62, height-25);        //fuel with position passed
  time(width * 0.46, height * 0.03);    //digital clock with position passed
  radar(width * 0.125, height * 0.83);  //radar with position passed
  data(width * 0.81, height * 0.83);    //data with position passed
  controls();
  logo(10, height-10);                  //logo with location passed
}//end draw()

void fuel(float xloc, float yloc)
{
  strokeWeight(1);
  if(fuelFlag==1)
  {
    if(frameCount % 90 == 0)    //set delay for fuel consumption
    {
      fuel-=1;
    }//end if
  }//end if
  fill(green);
  noStroke();
  for (int i=0; i<fuel; i++)
  {
    rect((xloc)-i*10, yloc, 6, 8);    //draws blocks to reprisent fuel amount
  }//end for
  fill(white);
  textFont(Digi_tech3);
  text("FUEL", width/2-19, 558);    //print "FUEL" above fuel gauge
  stroke(white);
  line(xloc+8, yloc+10, 305, yloc+10);    //draw horizontal line for fuel gauge
  for(int a=0; a<21; a++)
  {
    line((xloc+8), yloc+10, xloc+8, yloc+4);   //draw vertical lines for fuel gauge
    xloc-=10;    //decrement x location by 10
  }//end for
  stroke(red);    //change color to gridRed for "low" part of guel gauge
  line(453, 585, 505, 585);    //draw line for "low" part of fuel gauge
  xloc = 496;      //reset xloc to start of gauge
  for(int a=0; a<6; a++)
  {
    line((xloc+8), yloc+10, xloc+8, yloc+4);   //draw vertical lines for "low" part of fuel gauge
    xloc-=10;    //decrement x location by 10
  }//end for
  
  if (millis() - now > delay)    //flashing warning message
  { 
    flash = !flash; //change flag
    now = millis(); //reset counter
  }//end if
  if(fuel<6 && fuel>0 &&fuelFlag == 1)
  {
    alarm.play();
    if (flash)
    {
    textFont(Digi_tech2);    //larger font
    fill(red, 150);
    text("FUEL CRITICALLY LOW", width/2-175, height/2+20);    //print low fuel message
    }//end if
  }//end if
  if(fuel <= 0 && fuelFlag == 1)
  {
    if (flash)
    {
      textFont(Digi_tech2);    //larger font
      fill(red, 150);
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
}//end move()



void scanner()
{
 stroke(red);
 line(x, y, x, height);
 int trailLength = 30;
 float intensityChange = 255.0f / trailLength;
 for(int i = 0; i < trailLength-15; i++)
 {
   stroke(255- (i* intensityChange+50), 0, 0);
   line(x-i, y-i, x-i, height);
 }//end for
}//end scanner



void scannerText(int xloc, int yloc)
{
 fill(red);
 textFont(Digi_tech);
 if (millis() - now > delay)    //flashing warning message
 { 
   //change flag
   flash = !flash;
   //reset counter
   now = millis();
  }//end if
  if(flash)
  {
     text("SCANNING", xloc, yloc);
  }//end if
}//end scannText()



void data(float xloc, float yloc)
{
  textFont(Digi_tech);
  if(frameCount % 50 == 0)    //set pace for oxygen level change
  {
  oxyLevel = random(18, 21);  //random numbers of realistic normal oxygen levels
  }//end if
  if(mousePressed && mouseButton == LEFT && mouseY< 399 && gunFlag==1)  //if mouse pressed and left click pressed and mouseY is less than 399
  {
    gunsAmmo-=0.0001;    //decriment ammunition
  }//end if
  if(mousePressed && mouseButton == LEFT && mouseY< 399 && mslFlag==1)  //if mouse pressed and left click pressed and mouseY is less than 399
  {
    mslQty-=0.0001;  //decriment missile quantity
  }//end if
  
  //create strings to display data
  String oxyLevelFormatted = nf(oxyLevel, 2, 1);    //format oxygen level to 99.9
  String damageFormatted = nf(damage, 2, 1);
  String oxy = "02  " + oxyLevelFormatted;
  String msl = "MSL  " + mslQty;
  String guns = "GUN  " + gunsAmmo;
  String dmg = "DMG  " + damageFormatted;    //format damage level to 99.9
  
  //display data
  fill(white);
  text(oxy, xloc, yloc);
  text(msl, xloc, yloc+30);
  text(guns, xloc, yloc+60);
  text(dmg, xloc, yloc+90);
  
  textFont(Arial);
  text("%", xloc+67, yloc);
  text("%", xloc+80, yloc+90);
  
  //conditions
  textFont(Digi_tech);
  
  //-------missiles------//
  fill(white);
  text(mslStatus, xloc+80, yloc+30);
  if(mslQty < 5 && mslQty > 0)
  {
     mslStatus = "LOW";
     fill(yellow);
     text(mslStatus, xloc+80, yloc+30);
  }//end if
  
  if(mslQty < 1)
  {
   mslStatus = "EMPTY";
   fill(red);
   if(frameCount % 10 == 0)    //make "EMPTY" flash
   {
       text(mslStatus, xloc+80, yloc+30);
   }//end if
  }//end if
  
  //-------guns-------//
  fill(white);
  text(gunsStatus, xloc+80, yloc+60);
  if(gunsAmmo < 50 && gunsAmmo>0)
  {
     gunsStatus = "LOW";
     fill(yellow);
     text(gunsStatus, xloc+80, yloc+60);
  }//end if
  if(gunsAmmo ==0)
  {
     gunsStatus = "EMPTY";
     fill(red);
   if(frameCount % 10 == 0)    //make "EMPTY" flash
   {
       text(gunsStatus, xloc+80, yloc+60);
   }//end if
  }//end if
  
  int coordX = mouseX;
  int coordY = mouseY;
  //format floats to 3 places before decimal, none after
  String coordXFormatted = nf(coordX, 3, 0);
  String coordYFormatted = nf(coordY, 3, 0);
  
  fill(white);
  text("CoOrd ", xloc, yloc-30);
  if (mouseY < 400)
  {
     text(coordXFormatted + coordYFormatted, xloc+60, yloc-30);  //if crosshair is in KA show co-ordinates
  }//end if
  else
  {
     text("000000", xloc+60, yloc-30);    //if crosshair is not active show no co-ordinates
  }//end else
}//end data



void crosshair()
{
  noFill();
  strokeWeight(2);
  stroke(red);    //gridRed
  //move crosshair by mouse
  if(mouseY<400)
  {
    noCursor();
    ellipse(mouseX, mouseY, 30, 30);
    ellipse(mouseX, mouseY, 50, 50);
    line(mouseX-30, mouseY-30, mouseX+30, mouseY+30);
    line(mouseX+30, mouseY-30, mouseX-30, mouseY+30);
    
    if(mousePressed && mouseButton == LEFT && gunsAmmo > 0 && mouseY < 399 && gunFlag == 1)   //if mouse pressed and there is ammo left and mouseY is less than 399
    {
      guns.play();
      guns.rewind();
      noFill();
      stroke(yellow);
      //white crosshair within main one when mouse clicked
      ellipse(mouseX, mouseY, 20, 20);
      line(mouseX-20, mouseY-20, mouseX+20, mouseY+20);
      line(mouseX+20, mouseY-20, mouseX-20, mouseY+20);
    }//end if
    
    if(mousePressed && mouseButton == LEFT && mslQty > 0 && mouseY < 399 && mslFlag == 1)   //if mouse pressed and there is ammo left and mouseY is less than 399
    {
      missile.play();
      missile.rewind();
      noFill();
      stroke(255, 155, 5); //orange
      //white crosshair within main one when mouse clicked
      ellipse(mouseX, mouseY, 20, 20);
      line(mouseX-20, mouseY-20, mouseX+20, mouseY+20);
      line(mouseX+20, mouseY-20, mouseX-20, mouseY+20);
    }//end if
  }//end if
  
  //change the cursor to a hand when it's in the conrol panel
  else
  {
    cursor(HAND);
  }//end else
}//end crosshair()



void time(float xloc, float yloc)
{
  textFont(Digi_tech);
  fill(white);
  int s = second(); 
  int m = minute(); 
  int h = hour(); 
  text(h + ":" + nf(m, 2) + ":" + nf(s, 2), xloc, yloc);
}//end time()



void radar(float xloc, float yloc)
{ 
  strokeWeight(2);
  stroke(white); 
  noFill();
  if (diam <= 120)
  {                               
    ellipse(xloc, yloc, diam, diam);
    diam += 5;  // increases diameter for next loop
  }//end if
  
  else
  {
    stroke(green); //gridGreen flash
    strokeWeight(2);  
    diam -= 120;
  }//end else 
  
  fill(red);
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
  
  strokeWeight(1);
  noFill();
  ellipse(width/2, height/3, 350, 350);
  ellipse(width/2, height/3, 358, 358);
  ellipse(width/2, height/3, 320, 320);
  ellipse(width/2, height/3, 328, 328);
  
  line(580, 200, width, 200);
  line(220, 200, 0, 200);
  
  strokeWeight(2);
  line(width/2-20, height/3-50, width/2-60, height/3+50);
  line(width/2-10, height/3-50, width/2-50, height/3+50);
  
  line(width/2+20, height/3-50, width/2+60, height/3+50);
  line(width/2+10, height/3-50, width/2+50, height/3+50);
  
  strokeWeight(6);
  line(width/2, height/3-10, width/2+10, height/3+10);
  line(width/2, height/3-10, width/2-10, height/3+10);
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
   
  noStroke();
  fill(gridStroke, 80);
  rect(0, 401, width, height);
  triangle(0, 320, 120, 399, 0, 399);
  triangle(width, 320, 681, 399, width, 399);
  triangle(0, 0, 0, 79, 79, 0);
  triangle(721, 0, width, 79, width, 0);
}//end grid()



void controls()
{
  button1.run();
  button2.run();
  button3.run();
  wpn.run();
  engine.run();
}//end controls



void logo(int xloc, int yloc)
{
  fill(white);
  textFont(Space_tech);
  text("deltacorp", xloc, yloc);
}//end logo()