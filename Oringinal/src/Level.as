package  
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	import flash.display.Sprite;
	import flash.text.TextField;
	import factorys.Objects.Explosion;
	import factorys.Objects.Cannon;
	import factorys.Objects.Bullet;
	import factorys.Objects.Missle;
	import utils.debug.soundLength;
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
		private var _spawnDelay:int = 50;
		private var _enemyPerSpawn:int = 1;
		
		private var _backsound:SoundPlayer;
		
		private var _debugsoundlenght:soundLength
		
		private var _mouseToggle:Boolean;
		private var _firesound:SoundPlayer
		public function Level() :void
		{
			placeCannons();
			//this.addEventListener(Event.ENTER_FRAME, step)
			//_spawner.addEventListener(TimerEvent.TIMER, eSpawner)
			
			Main.STAGE.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			Main.STAGE.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
			//_spawner.start();
			
		}
		
		private function mouseUp(e:MouseEvent):void 
		{
			_mouseToggle =false;
		}
		
		private function mouseDown(e:MouseEvent):void 
		{
			_mouseToggle = true;
		}
		
		public function StartGame() :void
		{
			placeCannons();
			//newMissle(50);
			this.addEventListener(Event.ENTER_FRAME, step)
			_spawner.addEventListener(TimerEvent.TIMER, eSpawner)
			Main.STAGE.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			_spawner.start();
		}
		
		public function StopGame() :void
		{
			removeEventListener(Event.ENTER_FRAME, step);
			_spawner.removeEventListener(TimerEvent.TIMER, eSpawner);
			Main.STAGE.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			
			var l:int = _missles.length - 1
			for (var i:int = l; i >= 0; i--) 
			{
				removeChild(_missles[i]);
				_missles.splice(i, 1)
			}
			l = _cannons.length-1;
			
			for (var j:int = l; j >= 0 ; j--) 
			{
				removeChild(_cannons[j]);
				_cannons.splice(j, 1);
			}
			
			l = _bullets.length - 1;
			
			for (var k:int = l; k >= 0; k--) 
			{
				removeChild(_bullets[k]);
				_bullets.splice(k,1)
			}
			
			l = _explosions.length - 1;
			
			for (var m:int = l; m >= 0; m--) 
			{
				removeChild(_explosions[m]);
				_explosions.splice(m,1)
			}
		}
		
		private function eSpawner(e:TimerEvent):void 
		{
			if (Math.random() * (1 + Globals.score / 100) > 0.8)
			{
				newMissle(Math.floor(Math.random() * _enemyPerSpawn));
				_spawner = new Timer(_spawnDelay, 1);
			}
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
					_missles.splice(i, 1)
					trace(Globals.score);
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
			for each (var item:Explosion in _explosions) 
			{
				for (var n:int = _missles.length-1; n >= 0; n--) 
				{
					if (item.hitTestObject(_missles[n]))
					{
						_missles[n].destroy = true;
						Globals.score+=1
						
					}
				}
				
			}
			for each (var item2:Bullet in _bullets) 
			{
				for (var o:int = _missles.length-1; o >= 0; o--) 
				{
					if (item2.hitTestObject(_missles[o]))
					{
						try{
						_missles[o].destroy = true;
						Globals.score += 1;
						item2.destroy = true;
						}
						catch (e:Error)
						{
							trace(e.message);
						}
						
					}
				}
				
			}
			
			if (_mouseToggle && _fireDelay <= 0)
			{
				fireCannons();
				_fireDelay=10
			}
			_fireDelay--
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
			var offSet:Number = 3
			if (Globals.muted == false)
			{
				_firesound = new SoundPlayer("assets/sounds/Fire.mp3", 20)
			}
			for (var i:int = 0; i < 6; i++) 
			{
				c = _cannons[i];
				b = new Bullet (c.x, c.y, mouseX,mouseY);
				b.rotation = c.rotation + (Math.random() * offSet - (offSet/2));
				addChild(b);
				_bullets.push(b);
			}
		}
	}
}