package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import utils.draw.Button;
	
	/**
	 * ...
	 * @author Jesse Stam
	 */
	public class gui extends Sprite 
	{
		private var _score:TextField;
		public var notifiy:Button;
		public function gui() 
		{
			notifiy = new Button(0, 0, 400, 300, 0x000000, 0x00000, "GameStart", 40, 0xffffff, true, "Arial", false, 0)
			_score = new TextField()
			addChild(_score);
			addChild(notifiy);
			_score.text = "Loading";
			_score.defaultTextFormat = new TextFormat(Globals.font , null, 0xffffff);
			addEventListener(Event.EXIT_FRAME, Update);
		}
		
		private function Update(e:Event):void 
		{
			_score.text = "score: " + Globals.score + " Highscore: " + Globals.HighScore + "\nhealth: "+Globals.health;
			_score.width = _score.textWidth + 20;
			if (notifiy.alpha > 0)
			{
				notifiy.alpha -= 0.026;
			}
		}
		
	}

}