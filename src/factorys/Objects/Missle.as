package  
{
	import flash.geom.Point;
	import utils.callulate.MathExstend;
	import flash.display.Sprite;
	import utils.callulate.MovingObjects;
	import utils.draw.Squar
	import flash.events.Event;
	/**
	 * ...
	 * @author Jesse Stam
	 * 
	 */
	public class Missle extends MovingObjects
	{
		public var speed:Number = Math.random() * 4+2;
		private var art:Squar = new Squar(0, 0, 4, 4, 0xff0000);
		public var tag:String = "Missle"
		//public var angle:Number = Math.random() * 45 + 67.5;
		public var angle:Number = 1.5;
		
		
		//public var destroy:Boolean = false;
		
		
		public function Missle() 
		{
			//speed = (MathExstend.callMove(Math.random() * 4+2, angle));
			this.x = Math.random() * Main.resolution[0];
			this.y = -20;		
			addChild(art);
		}
		
		/*public function move():void
		{
			this.x += speed.x
			this.y += speed.y;
			if (this.x < 0 || this.x > Main.resolution[0] || this.y > Main.resolution[1])
			{
				destroy = true;
			}
		}*/
		
	}

}