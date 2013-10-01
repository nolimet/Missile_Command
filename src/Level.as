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
		private var _world:Array = [];
		private var _cannons:Array = [];
		private var _bullets:Array = [];
		private var _explosions:Array = [];
		
		private var _spawner:Timer = new Timer(300, 0);
	
		private var _fireDelay:int = 0;
		private var _spawnDelay:int = 1000;
		private var _enemyPerSpawn:int = 1;
		
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
			newMissle(Math.floor(Math.random() * _enemyPerSpawn));
			_spawner = new Timer(_spawnDelay, 1);
			
		}
		
		public function step(e:Event):void 
		{
			var l:int = _cannons.length - 1
			for (var i:int = l; i >= 0; i--) 
			{
				
				_missles[i].move(_missles[i].speed,_missles[i].angle);
				if (_missles[i].destroy==true)
				{
					removeChild(_missles[i]);
					_missles.splice(i,1)
				}
				
			}
			
			l = _cannons.length;
			for (var j:int = 0; j < l; j++) 
			{
				_cannons[j].rotation = poinToMouse(_cannons[j]);
			}
			
			l = _bullets.length
			
			for (var k:int = 0; k < l; k++) 
			{
				_bullets[k].move(5);
					_bullets[k].step();
					if (_bullets[k].destroy)
					{
						if (_bullets[k].explode)
						{
							placeExplosion(_bullets[k].x, _bullets[i].y);
						}
						removeChild(_bullets[k]);
						_bullets.splice(k,1)
					}
			}
				//else if (_world[i].tag == "Bullet")
				//{
					//_world[i].move(5);
					//_world[i].step();
					//if (_world[i].destroy)
					//{
						//if (_world[i].explode)
						//{
							//placeExplosion(_world[i].x, _world[i].y);
						//}
						//removeChild(_world[i]);
						//_world.splice(i,1)
					//}
				//}
				//else if (_world[i].tag == "Explosion")
				//{
					//_world[i].step()
					//if (_world[i].destroy==true)
					//{
						//removeChild(_world[i]);
						//_world.splice(i,1)
					//}
				//}
			//}
			//if (Main.instance.fireCannon == true&&_fireDelay==0)
			//{
				//fireCannons();
				//_fireDelay = 5;
			//}
			//else
			//{
				//if (_fireDelay != 0)
				//{
					//_fireDelay--
				//}
			//}
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
				_cannons.push(c);
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