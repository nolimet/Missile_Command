package  
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.display.Sprite;
	import flash.text.TextField;
	import factorys.Objects.Explosion;
	import factorys.Objects.Cannon;
	import factorys.Objects.Bullet;
	import factorys.Objects.Missle;
	import utils.loaders.SoundPlayer;
	import utils.draw.Squar;
	
	
	/**
	 * ...
	 * @author Jesse Stam
	 */
	public class Level extends Sprite 
	{
		private var _missles:Array = [];
		private var _cannons:Array = [];
		private var _bullets:Array = [];
		private var _explosions:Array = [];
		
		private var _spawner:Timer = new Timer(300, 0);
	
		private var _fireDelay:int = 0;
		private var _spawnDelay:int = 1000;
		private var _enemyPerSpawn:int = 1;
		
		private var _backsound:SoundPlayer;
		
		public function Level() :void
		{
			placeCannons();
			//newMissle(50);
			this.addEventListener(Event.ENTER_FRAME, step)
			_spawner.addEventListener(TimerEvent.TIMER, eSpawner)
			_spawner.start();
			
		}
		
		public function StartGame() :void
		{
			placeCannons();
			//newMissle(50);
			this.addEventListener(Event.ENTER_FRAME, step)
			_spawner.addEventListener(TimerEvent.TIMER, eSpawner)
			_spawner.start();
			_backsound = new SoundPlayer("assets/sounds/21_Anniversary_Album_Mix.mp3");
		}
		
		private function eSpawner(e:TimerEvent):void 
		{
			newMissle(Math.floor(Math.random() * _enemyPerSpawn));
			_spawner = new Timer(_spawnDelay, 1);
			
		}
		
		public function step(e:Event):void 
		{
			var l:int = _missles.length - 1
			for (var i:int = l; i >= 0; i--) 
			{
				
				_missles[i].move(_missles[i].speed,_missles[i].angle);
				if (_missles[i].destroy==true)
				{
					removeChild(_missles[i]);
					_missles.splice(i,1)
				}
				
			}
			l = _cannons.length-1;
			
			for (var j:int = 0; j <= l; j++) 
			{
				_cannons[j].rotation = poinToMouse(_cannons[j]);
			}
			
			l = _bullets.length - 1;
			
			for (var k:int = l; k >= 0; k--) 
			{
				_bullets[k].move(7);
				_bullets[k].step();
				//trace(k);
				if (_bullets[k].destroy)
				{
					if (_bullets[k].explode)
					{
						placeExplosion(_bullets[k].x, _bullets[k].y);
					}
					removeChild(_bullets[k]);
					_bullets.splice(k,1)
				}
			}
			
			l = _explosions.length - 1;
			
			for (var m:int = l; m >= 0; m--) 
			{
				_explosions[m].step()
				if (_explosions[m].destroy==true)
				{
					removeChild(_explosions[m]);
					_explosions.splice(m,1)
				}
			}
			//try 
			//{
				//var a:Explosion;
				//var b:Missle;
				//for (var n:int = 0; n < _explosions.length; n++) 
				//{
					//a = _explosions[n];
					//for (var o:int = _missles.length; o >= 0; o--) 
					//{
						//b= _missles[o]
						//if (a.hitTestObject(b))
						//{
							//removeChild(_missles[o]);
							//_missles.splice(o,1)
						//}
					//}
				//}
			//}catch (e:Error)
			//{
				//trace("Error in hitTestObect")
				//trace(e.message);
			//}
			
			for each (var item:Explosion in _explosions) 
			{
				for (var n:int = _missles.length-1; n >= 0; n--) 
				{
					if (item.hitTestObject(_missles[n]))
					{
						removeChild(_missles[n]);
						_missles.splice(n, 1);
						
						
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
				_missles.push(m);
			}
		}
		private function placeExplosion($x:Number,$y:Number):void
		{
			var e:Explosion = new Explosion($x, $y, Math.random() * 1.2 + 1);
			addChild(e);
			_explosions.push(e);
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
			for (var i:int = 0; i < 6; i++) 
			{
				c = _cannons[i];
				b = new Bullet (c.x, c.y, mouseX,mouseY);
				b.rotation=c.rotation
				addChild(b);
				_bullets.push(b);
			}
		}
	}
}