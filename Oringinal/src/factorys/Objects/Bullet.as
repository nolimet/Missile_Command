package  factorys.Objects
{
	import flash.geom.Point;
	import utils.callulate.MovingObjects;
	import utils.draw.Squar;
	import flash.display.Sprite;
	import utils.callulate.MathExstend;
	
	/**
	 * ...
	 * @author Jesse Stam
	 */
	public class Bullet extends MovingObjects 
	{
		private var _art:Squar;
		public var tag:String = "Bullet";
		public var speed:Point;
		public var explode:Boolean;
		private var _mx:Number;
		private var _my:Number;
		
		public function Bullet($x:Number,$y:Number,$mx:Number,$my:Number) 
		{
			this.x = $x;
			this.y = $y;
			this._mx = $mx;
			this._my = $my;
			//speed = new Point(Math.cos(angle)*5, Math.sin(angle)*5);
			_art = new Squar(0, 0, 2, 2, 0x00AAFF);
			addChild(_art);
		}
		
		public function step():void
		{
			if(this.y<=_my)
			{
			 destroy = true;
			 explode = true;
			}
		}
	}

}