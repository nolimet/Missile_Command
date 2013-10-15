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
	public var boost:Boolean = false;
	
	private var _level:Level = new Level;
	private var _mainmenu:Mainmenu = new Mainmenu;
	private var _boostDure:int = 0;
	private var _currentRoom:int = 0;

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
			_level.StartGame();
			//addChild(_mainmenu);
			
			stage.addEventListener(MouseEvent.MOUSE_DOWN, mouse_down);
			stage.addEventListener(MouseEvent.MOUSE_UP, mouse_up);
			
			addEventListener(Event.ENTER_FRAME, Update);
		}
		
		private function Update(e:Event):void 
		{
			if (_currentRoom == 0)
			{
				addChild(_mainmenu);
				
				if (_mainmenu.startGame.clicked)
				{
					removeChild(_mainmenu);
				}
			}
			
		}
		
		private function mouse_up(e:MouseEvent):void 
		{
			fireCannon = false;
		}
		
		private function mouse_down(e:MouseEvent):void 
		{
			fireCannon = true;
		}
	}
}