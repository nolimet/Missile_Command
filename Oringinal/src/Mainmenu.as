package  
{
	import flash.display.Sprite;
	import utils.callulate.MathFunctions;
	import utils.draw.Button;
	/**
	 * ...
	 * @author Jesse Stam
	 */
	public class Mainmenu extends Sprite
	{
		public var startGame:Button;
		public var muteButton:Button;
		
		public function Mainmenu() 
		{
			startGame = new Button(30, 200, 0, 0, 0x00ff00, "StartGame", 20, 0xffffff);
			//muteButton = new Button(30, 100, 0, 0, 0x00ff00, "Mute", 20, 0xffffff);
			muteButton = new Button(0, 0, 0, 0, 0x00ff00, "Mute", 20, 0xffffff);
			
			//addChild(startGame);
			addChild(muteButton);
		}
		
	}

}