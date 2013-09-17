package  
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import Missle;
	import utils.draw.Squar;
	import flash.display.Sprite;
	import flash.text.TextField;
	import Explosion;
	
	/**
	 * ...
	 * @author Jesse Stam
	 */
	public class Level extends Sprite 
	{
		private var _world:Array = new Array();
		private var _spawner:Timer = new Timer(300, 0);
		private var _cannons:int
		private var _fireDelay:int = 0;
		
		public function Level() :void
		{
			placeCannons();
			//newMissle(50);
			this.addEventListener(Event.ENTER_FRAME, step)
			_spawner.addEventListener(TimerEvent.TIMER, eSpawner)
			_spawner.start();
		}
		
		private function eSpawner(e:TimerEvent):void 
		{
			newMissle(Math.floor(Math.random() * 10));
		}
		
		public function step(e:Event):void 
		{
			var l:int = _world.length - 1
			for (var i:int = l; i >= 0; i--) 
			{
				if (_world[i].tag == "Missle")
				{
					_world[i].move(_world[i].speed,_world[i].angle);
					if (_world[i].destroy==true)
					{
						removeChild(_world[i]);
						_world.splice(i,1)
					}
				}
				else if (_world[i].tag == "Cannon")
				{
					_world[i].rotation = poinToMouse(_world[i]);
				}
				else if (_world[i].tag == "Bullet")
				{
					_world[i].move(5);
					_world[i].step();
					if (_world[i].destroy)
					{
						if (_world[i].explode)
						{
							placeExplosion(_world[i].x, _world[i].y);
						}
						removeChild(_world[i]);
						_world.splice(i,1)
					}
				}
				else if (_world[i].tag == "Explosion")
				{
					_world[i].step()
					if (_world[i].destroy==true)
					{
						removeChild(_world[i]);
						_world.splice(i,1)
					}
				}
			}
			if (Main.instance.fireCannon == true&&_fireDelay==0)
			{
				fireCannons();
				_fireDelay = 5;
			}
			else
			{
				if (_fireDelay != 0)
				{
					_fireDelay--
				}
			}
		}
		
		private function newMissle(amount:int=0) : void
		{
			if(amount<=0){amount=1}
			for (var i:int = 0; i < amount; i++) 
			{
				var m:Missle = new Missle();
				addChild(m)
				_world.push(m);
			}
		}
		private function placeExplosion($x:Number,$y:Number):void
		{
			var e:Explosion = new Explosion($x, $y, Math.random() * 1.5 + 0.5);
			addChild(e);
			_world.push(e);
		}
		private function placeCannons():void
		{
			for (var i:int = 0; i < 6; i++) 
			{
				var c:Cannon = new Cannon(125 *i + 87.5 , Main.resolution[1], 1.5)
				addChild(c);
				_world.push(c);
				_cannons++
			}
			
		}
		private function poinToMouse(obj1:Object):Number 
		{
            var dX:Number = mouseX - obj1.x;
            var dY:Number = mouseY - obj1.y;
            var angleDeg:Number = Math.atan2(dY, dX) / Math.PI * 180;
			
            return angleDeg;
		}
		
		private function fireCannons():void
		{
			var b:Bullet;
			var c:Cannon;
			for (var i:int = 0; i < _cannons; i++) 
			{
				c = _world[i];
				b = new Bullet (c.x, c.y, mouseX,mouseY);
				b.rotation=c.rotation
				addChild(b);
				_world.push(b);
			}
		}
	}
}