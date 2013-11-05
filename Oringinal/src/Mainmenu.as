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
		public var fullScreen:Button;
		public var mute:Button;
		public var highScore:Button;
		public var resetScore:Button;
		
		public function Mainmenu() 
		{
			fullScreen = new Button(0, 0, 400, 450, 0x00ff00,0xff0000 , "FullScreen", 20, 0xffffff, true,Globals.font);
			startGame = new Button(0, 0, 400, 350, 0x00ff00,0x00ff00, "StartGame", 30, 0xffffff,true, Globals.font);
			highScore = new Button(0, 0, 0, 0, 0x000000,0x000000, "highscore: "+Globals.HighScore, 32, 0xffffff, false, Globals.font, false);
			mute = new Button(0, 0, 400,300, 0x00ff00,0xff0000, "Mute", 20, 0xffffff,true,Globals.font);
			resetScore = new Button(0, 0,740,580, 0x00ff00,0x00ff00, "ResetScore", 20, 0xffffff,true,Globals.font);
			
			addChild(startGame);
			addChild(mute);
			//addChild(fullScreen);
			addChild(highScore);
			addChild(resetScore);
		}
		
	}

}