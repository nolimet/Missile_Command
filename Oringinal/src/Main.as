package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.display.Stage
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.net.SharedObject;
	
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
	
	private var _level:Level;
	private var _mainmenu:Mainmenu = new Mainmenu;
	public var _gui:gui;
	private var _boostDure:int = 0;
	private var _currentRoom:int = -1;
	private var _loadedNewRoom:Boolean = false;
	public var _health:int = 0;
	private var _gameOver:GameOver;
	
	public static var localData:SharedObject

		public function Main() 
		{
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point			
			//addChild(_level);
			//_level.StartGame();
			//addChild(_mainmenu);
			STAGE = this.stage;
			instance = this;
			try {
				localData = SharedObject.getLocal("MissleCommand_JDS");
				
				Globals.HighScore = localData.data.HighScore;
				if (isNaN(Globals.HighScore))
				{
					Globals.HighScore = 0;
				}
				
			}
			catch (e:Error)
			{
			}
			roomChange(0)
			trace(Main.localData.data.highscore);
			//_level  = new Level
			stage.addEventListener(KeyboardEvent.KEY_DOWN, KeyDown);
			addEventListener(Event.ENTER_FRAME, Update);
			
		}
		
		private function KeyDown(e:KeyboardEvent):void 
		{
			if (e.keyCode == 27)
			{
			 roomChange(0);	
			}
			if (e.keyCode == 78)
			{
				Globals.score += Globals.nextLevel
			}
		}
		private function roomChange(numb:int) : void
		{
			var oldRoom:int = _currentRoom;
			_currentRoom = numb;
			_loadedNewRoom = false;
			if (oldRoom == 0)
			{
				removeChild(_mainmenu);
				_loadedNewRoom = false;
			}
			else if (oldRoom == 1) {
				_level.StopGame();
				removeChild(_gui);
				removeChild(_level);
				_level = new Level();
				localData.flush();
			}
			else if (oldRoom == 2) {
				removeChild(_gameOver);
			}
			
			if (_currentRoom == 0)
			{
				if (_loadedNewRoom==false)
				{
					_mainmenu = new Mainmenu();
					addChild(_mainmenu);
					_loadedNewRoom = true;
				}
			}
			else if (_currentRoom == 1)
			{
				if (_loadedNewRoom==false)
				{
					Globals.score = 0;
					Globals.health = Globals.maxHealth;
					Globals.nextLevel = 10;
					Globals.scoreLastLevel = 0;
					_gui = new gui();
					addChild(_gui);
					_level = new Level();
					_level.StartGame();
					addChild(_level);
					_loadedNewRoom = true;
				}
			}
			else if (_currentRoom == 2)
			{
				if (_loadedNewRoom == false)
				{
					_gameOver = new GameOver();
					addChild(_gameOver);
					_loadedNewRoom = true;
				}
			}
			
			
		}
		private function Update(e:Event):void 
		{
			if (Globals.score > Globals.HighScore)
			{
				Globals.HighScore = Globals.score;
				localData.data.HighScore = Globals.HighScore;
				if (isNaN(Globals.HighScore))
				{
					Globals.HighScore = 0;
				}
			}
			
			if (_currentRoom == 0)
			{
				if (_mainmenu.startGame.clicked)
				{
					roomChange(1);
				}
				Globals.muted = _mainmenu.mute.clicked;
				if (_mainmenu.resetScore.clicked)
				{
					Globals.HighScore = 0
					localData.clear();
					trace("score reset!");
					_mainmenu.highScore.text.text = "highscore: " + Globals.HighScore
					_mainmenu.resetScore.clicked = false;
				}
			}
			
			if (_currentRoom == 1)
			{
				if (Globals.health <= 0)
				{
					roomChange(2);
				}
			}
		}
	}
}