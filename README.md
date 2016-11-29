# Assignment

OOP Assignment DT 228/2

C15490862 Killian Doyle

[![Video](http://img.youtube.com/vi/2oH3nGaAiOo/0.jpg)](http://www.youtube.com/watch?v=2oH3nGaAiOo)
[![Video](http://img.youtube.com/vi/e9it_bKlu74/0.jpg)](http://www.youtube.com/watch?v=e9it_bKlu74)

(The videos tend to lag, it's not the program. Included two videos)

The assignment is a simple GUI for a futuristic space ship with a sci-fi theme.

Basic operation:
1. The background is an image that is moved when the user presses the arrow keys.

2. The grid is drawn using loops. The colour can be changed by clicking buttons created in a class.

3. A cross hair appears if the cursor is within the "Killing Area" of the spaceships controls. It turns to a hand when the cursor is on the control panel.

4. Pressing Ctrl calls a function that draws a "scanner" and displays text.

5. Switches, created in a class, control the selection of weapons (missiles or guns) and control wether the engine is on or off.

6. When guns or missiles are fired the cross hair changes colour and plays a different sound for both.

7. The data on the right of the control panel features levels such as oxygen, ammunition, damage and co-ordinates(mouseX and mouseY).
	-Oxygen is randomised within normal oxygen levels.
	-Ammunition decrements according to which is selected and fired.
	-Weapon status is "Ready", "Low" or "Empty".
	-Damage is random, above 90%.
	-Co-ordinates don't display unless the crosshair is in the Killing Area.

8. Radar is animated through a loop.

9. Fuel decrements every few seconds when the engines are turned on and this is represented on the fuel bar. 
   Warning messages and sounds play when fuel is low. The ship can not be moved when engines are off and fuel is empty.

10. Sounds play when buttons and switches are clicked.