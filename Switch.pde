
class Switch
{
 //variables
 String name;
 String text1;
 String text2;
 float xloc;
 float yloc;
 int w= 20;
 int h = 10;
 int passedcol;
 
 
 //the co-ordinates and the two different colors of the buttons are passed.
 Switch(String name ,String text1, String text2, float x, float y, int w, int h, int col1, int passedcol)
 {
   this.name = name;
   this.text1 = text1;
   this.text2 = text2;
   xloc = x;
   yloc = y;
   this.w = w;
   this.h = h;
   this.col1 = col1;
   this.passedcol = passedcol;
 }
  
 void run()
 {
   display();
 }//end run
  
   int col1 = passedcol;
   int col2 = white;
   
 void display()
 {
    textFont(Digi_tech3);
    fill(white);
    text(name, xloc+10, yloc-15);
    if(mousePressed)
    {
      if(mouseX >=xloc && mouseX <=xloc+w && mouseY >= yloc && mouseY <= yloc+h && passedcol == red)
      {
         col1 = passedcol;
         col2 = white;
         gunFlag = 1;
         mslFlag = 0;
       }//end if
     }//end if
     
    if(mousePressed)
    {
      if(mouseX >=xloc+35 && mouseX <=xloc+35 +w && mouseY >= yloc && mouseY <= yloc+h && passedcol == red)
      {
         col1 = white;
         col2 = passedcol;
         gunFlag = 0;
         mslFlag = 1;
       }//end if
     }//end if
     
         if(mousePressed)
    {
      if(mouseX >=xloc && mouseX <=xloc+w && mouseY >= yloc && mouseY <= yloc+h && passedcol == yellow)
      {
         col1 = passedcol;
         col2 = white;
         fuelFlag=0;
       }//end if
     }//end if
     
    if(mousePressed)
    {
      if(mouseX >=xloc+35 && mouseX <=xloc+35 +w && mouseY >= yloc && mouseY <= yloc+h && passedcol == yellow)
      {
         col1 = white;
         col2 = passedcol;
         fuelFlag=1;
       }//end if
     }//end if
     

    
    stroke(col1);
    noFill();
    rect(xloc, yloc, w, h);
    fill(col1);
    textFont(Digi_tech3);
    text(text1, xloc+5, yloc+15);
    
    stroke(col2);
    noFill();
    rect(xloc+40, yloc, w, h);
    fill(col2);
    textFont(Digi_tech3);
    text(text2, xloc+45, yloc+15);
  }//end display()
  
}//end Switch