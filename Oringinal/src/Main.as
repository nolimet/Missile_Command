package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.display.Stage
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Jesse Stam
	 */
	public class Main extends Sprite {

	public static const resolution:Array = [800, 600];
    public static var instance:Main;
	public static var STAGE:Stage;
	public var fireCannon:Boolean;
	private var _level:Level = new Level;
	public var boost:Boolean = false;
	private var _boostDure:int = 0;

		public function Main() 
		{
			STAGE = this.stage;
			instance = this;
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point			
			addChild(_level);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, key_down);
			stage.addEventListener(KeyboardEvent.KEY_UP, key_up);
		}
		
		private function key_up(e:KeyboardEvent):void 
		{
			if (e.keyCode == 32)
			{
				fireCannon = false;
			}
		}
		
		private function key_down(e:KeyboardEvent):void 
		{
			if (e.keyCode == 32)
			{
				fireCannon = true;
			}
		}
	}
}