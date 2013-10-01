package  
{
	import utils.draw.Circle;
	import utils.draw.Squar;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Jesse Stam
	 */	 
	public class Cannon extends Sprite
	{
		private var _base:Circle;
		private var _barrel:Squar;
		public var tag:String = "Cannon";
		
		public var firepoint:Number
		public function Cannon($x:Number, $y:Number, scale:Number = 1):void
		{
			
			_base = new Circle(0, 0, 10*scale, 0x999999, 0);
			_barrel = new Squar(10*scale, -2*scale, 4*scale, 20*scale, 0x555555);
			
			this.x = $x;
			this.y = $y;
			
			addChild(_barrel);
			addChild(_base);
		}	
	}
}