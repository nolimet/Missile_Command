package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author Jesse Stam
	 */
	public class gui extends Sprite 
	{
		private var _score:TextField;
		public function gui() 
		{
			_score = new TextField()
			addChild(_score);
			_score.text = "Loading";
			_score.defaultTextFormat = new TextFormat(Globals.font , null, 0xffffff);
			addEventListener(Event.EXIT_FRAME, Update);
		}
		
		private function Update(e:Event):void 
		{
			_score.text = "score: " + Globals.score + " Highscore: " + Globals.HighScore + "\nhealth: "+Globals.health;
			_score.width = _score.textWidth+20;
		}
		
	}

}