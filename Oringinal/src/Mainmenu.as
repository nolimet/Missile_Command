package  
{
	import flash.display.Sprite;
	import utils.draw.Button;
	/**
	 * ...
	 * @author Jesse Stam
	 */
	public class Mainmenu extends Sprite
	{
		public var StartGame:Button;
		
		public function Mainmenu() 
		{
			StartGame = new Button(30, 200, 0, 0, 0x000000, "StartGame", 20, 0xffffff);
			addChild(StartGame);
		}
		
	}

}