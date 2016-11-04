// grid colors
int green = color(131, 255, 145);  
int red = color(255, 82, 82);
int blue = color(82, 167, 255);
//grid calculations
int widthSpace = 40;     
int heightSpace = 40;    

void setup()
{
  size(800, 400);
}

void draw()
{
  background(0); //black background
  grid();
  time(15, 390);
}

void time(int xpos, int ypos)
{
  fill(255);
  int s = second(); 
  int m = minute(); 
  int h = hour(); 
  text(h + ":" + nf(m, 2) + ":" + nf(s, 2), xpos, ypos);
}

void grid()
{
  stroke(blue);     
  for(int i=0; i<width; i+=widthSpace)
  { 
     line(i, 0, i, height);
  }

 for(int w=0; w<height; w+=heightSpace)
 {
   line(0, w, width, w);
 }
}