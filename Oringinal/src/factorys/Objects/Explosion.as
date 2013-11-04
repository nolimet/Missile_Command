package  factorys.Objects
{
	import flash.display.Sprite;
	import utils.draw.Circle;
	import utils.loaders.SoundPlayer;
	/**
	 * ...
	 * @author Jesse Stam
	 */
	public class Explosion extends Sprite
	{
		private var _size:Number=1;
		private var _scale:Number;
		private var _art:Circle;
		public var tag:String = "Explosion";
		public var destroy:Boolean = false;
		private var sound:SoundPlayer;
		
		public function Explosion($x:Number,$y:Number,$scale:Number) 
		{
			this._scale = $scale;
			if (Globals.muted==false)
			{
				sound = new SoundPlayer ("assets/sounds/explosion.mp3", 20);
			}
			
			_art = new Circle($x, $y, 1.2 * _scale, 0xffff00, 0);
			addChild(_art);
		}
		
		public function step():void
		{
			_size+=_scale*1.2
			_art.scaleX = _size;
			_art.scaleY = _size;
			if (_size > 10 * _scale)
			{
				destroy = true;
			}
		}
	}

}