/*A class used to create the buttons that control the grid colour. 
This class features in the control funtion.*/

class Button 
{
 //variables
 float xloc;
 float yloc;
 float r1; 
 float r2;
 int fillC;
 int fillS;
 
 //the co-ordinates and the two different colors of the buttons are passed.
 Button(float x, float y, float r_1, float r_2, int Cfill, int Sfill )
 {
   xloc = x;
   yloc =y;
   r1 = r_1;
   r2 = r_2;
   fillC = Cfill;
   fillS = Sfill;
 }
 
 void run()
 {
   display();
 }//end run
  
 void display()
  {
    stroke(fillS);
    fill(fillC);
    ellipse(xloc, yloc, r1, r2);
    //the following code dictates what color the grid changes depending on what button is pressed
    if(mousePressed)
    {
      if(mouseX >=xloc && mouseX <=xloc+r1 && mouseY >= yloc && mouseY <= yloc+r2)
      {
        if(fillC==red)
        {
          gridStroke = red;
        }
        else if(fillC==blue)
        {
          gridStroke = blue;
        }
        else if(fillC==green)
        {
          gridStroke = green;
        }
      }//end if
     }//end if
  }//end display()
}//end Button