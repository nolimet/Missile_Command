package  
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import utils.draw.Button;
	
	/**
	 * ...
	 * @author Jesse Stam
	 */
	public class GameOver extends Sprite
	{
		//private var _text:TextField;
		private var highScore:Button;
		private var score:Button;
		
		public function GameOver() 
		{
			highScore = new Button(0, 0, 400, 100, 0x000000, 0x000000, "HighScore: "+Globals.HighScore, 40, 0xffffff, true, "Arial", false);
			score = new Button(0, 0, 400, 150, 0x000000, 0x000000, "Your Score: "+Globals.score, 40, 0xffffff, true, "Arial", false);
			addChild(highScore);
			addChild(score);
		}
		
	}

}