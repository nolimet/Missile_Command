package 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.filters.BlurFilter;
	import flash.filters.GradientGlowFilter;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BitmapFilterType;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.ByteArray;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundMixer;
	
	/**
	 * Sound Visualizer Demo 1
	 * Creates a mouse following music visualizer with aftertrails.
	 * @author http://matteley.wordpress.com/
	 */
	[SWF(width="1600", height="900", backgroundColor="#000000", frameRate="30")]
	public class TestMusic extends Sprite 
	{
		//statics
		private static const MUSIC_PATH:String = "assets/sounds/21_Anniversary_Album_Mix.mp3";
		private static const WAVE_RADIUS:uint = 100;
		private static const WAVE_COLORS:Array = [0x0054DF, 0xBFE8FF, 0x6100D7];
		
		//props
		private var _loadingText:TextField;
		private var _format:TextFormat;
		private var _centerSprite:Sprite;
		private var _bitmapBackground:Bitmap;
		private var _bitmapBuffer:BitmapData;
		private var _sound:Sound;
		private var _soundChannel:SoundChannel;
		
		/**
		 * Constructor
		 */
		public function  TestMusic():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		/**
		 * Sets up all the graphics on the stage
		 * and loads the external music
		 */
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
		
			//add textfield to display loading info
			_loadingText = new TextField();
			_loadingText.autoSize = TextFieldAutoSize.LEFT;
			_loadingText.text = "Music Loading: 0%";
			_loadingText.x = stage.stageWidth / 2 - _loadingText.width / 2;
			_loadingText.y = stage.stageHeight / 2 - _loadingText.height / 2;
			_format = new TextFormat();
			_format.font = '_sans';
			_format.color = 0xffffff;
			_loadingText.setTextFormat(_format);
			addChild(_loadingText);
			
			//create a new sound objects and load the music
			_sound = new Sound();
			_sound.addEventListener(ProgressEvent.PROGRESS, onSoundLoadProgress);
			_sound.addEventListener(Event.COMPLETE, onSoundLoadComplete);
			_sound.load(new URLRequest(MUSIC_PATH));
			
		}
		
		/**
		 * Updates the screen with loading info
		 */
		private function onSoundLoadProgress(e:ProgressEvent):void
		{
			_loadingText.text = "Music Loading: " + (e.bytesLoaded / e.bytesTotal * 100 << 0) + "%";
			_loadingText.setTextFormat(_format);
		}
		
		/**
		 * Called when music has completely loaded, and starts the visualizer
		 */
		private function onSoundLoadComplete(e:Event):void
		{
			//clear up
			_loadingText.visible = false;
			_sound.removeEventListener(ProgressEvent.PROGRESS, onSoundLoadProgress);
			_sound.removeEventListener(Event.COMPLETE, onSoundLoadComplete);
			
			//add bitmap background
			_bitmapBuffer = new BitmapData(stage.stageWidth, stage.stageHeight, true, 0xffffff);
			_bitmapBackground = new Bitmap(_bitmapBuffer);
			addChild(_bitmapBackground);
			
			//add center sprite and apply filters
			_centerSprite = new Sprite();
			_centerSprite.visible = false; //hide sprite
			_centerSprite.x = stage.stageWidth / 2;
			_centerSprite.y = stage.stageHeight / 2;
			_centerSprite.filters = [new GradientGlowFilter(0, 0, WAVE_COLORS, [0, 1], [0, 200, 255], 16, 16, 1, BitmapFilterQuality.LOW, BitmapFilterType.FULL)];
			addChild(_centerSprite);
			
			//play music
			playMusic();	
		}
		
		/**
		 * Starts the music playing and sets up listeners needed for the visualizer
		 */
		public function playMusic():void
		{
			_soundChannel = _sound.play(3000); //skip first 3 seconds of track
			_soundChannel.addEventListener(Event.SOUND_COMPLETE, onSoundComplete);
			stage.addEventListener(Event.ENTER_FRAME, onSoundEnterFrame);
		}
		
		/**
		 * Called on enter frame, only active while music is playing
		 */
		private function onSoundEnterFrame(e:Event):void
		{
			updateGraphics();
			updateBitmap();
			_centerSprite.x += (800 - _centerSprite.x) / 5;
			_centerSprite.y += (450 - _centerSprite.y) / 5;
		}
		
		/**
		 * Loops the music
		 */
		private function onSoundComplete(e:Event):void
		{
			playMusic();
		}
		
		/**
		 * Updates the graphics in the main sprite
		 * using the sound spectrum byte array from the sound controller
		 */
		private function updateGraphics():void
		{
			//first get the sound spectrum byte array
			var spectrumBytes:ByteArray = new ByteArray();
			SoundMixer.computeSpectrum(spectrumBytes);
			
			//then setup the canvas
			var canvas:Graphics = _centerSprite.graphics;
			var x:Number;
			var y:Number;
			var startX:Number;
			var startY:Number;
			var value:Number;
			var angle:Number;
			var i:int = -1;
			
			//then draw graphics
			canvas.clear();
			canvas.beginFill(0xffffff, 0.7);
			
			//loop through all 512 floating point numbers in the byte array
			while (++i < 512)
			{
				//for each one calculate where to draw a line
				value = Math.ceil(WAVE_RADIUS * spectrumBytes.readFloat());
				angle = i / 512 * Math.PI * 2;
				x = Math.cos(angle) * value;
				y = Math.sin(angle) * value;
				if (i == 0)
				{
					startX = x;
					startY = y;
					canvas.moveTo(x, y);
				}
				else
				{
					canvas.lineTo(x, y);
				}
			}
			canvas.lineTo(startX, startY);
		}
		
		/**
		 * Update the background bitmap with the current content of the main sprite
		 */
		private function updateBitmap():void
		{
			//set transforms
			var matrix:Matrix = new Matrix();
			matrix.scale(5, 5);
			matrix.translate(_centerSprite.x, _centerSprite.y);
			
			//set colors
			var colors:ColorTransform = new ColorTransform(1, 1, 1, 0.90);
			
			//update background
			_bitmapBuffer.lock();
			_bitmapBuffer.applyFilter(_bitmapBuffer, _bitmapBuffer.rect, new Point(0, 0), new BlurFilter(16, 16, BitmapFilterQuality.LOW));
			_bitmapBuffer.colorTransform(_bitmapBuffer.rect, colors);
			_bitmapBuffer.draw(_centerSprite, matrix, null, BlendMode.ADD);
			_bitmapBuffer.unlock();
		}
		
	}
	
}