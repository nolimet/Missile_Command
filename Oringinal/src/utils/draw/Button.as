package utils.draw 
{
	import adobe.utils.ProductManager;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import utils.draw.Squar;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Button extends Sprite 
	{
		private var _art:Squar;
		private var _text:TextField;
		private var _clicked:Boolean = false;
		private var _centered:Boolean;
		private var _height:Number;
		private var _width:Number;
		private var _colourInactive:uint;
		private var _colourActive:uint;
		private var _xoff:Number = 0;
		private var _yoff:Number = 0;
		
		/**
		 * Function make a Simple clickble button
		 *
		 * @example example:
		 * @param $height : Set height of bounding box
		 * @param $width : Set width of bouding box
		 * @param $x : Set location on the x axis
		 * @param $y : Set location on the y axis
		 * @param $colourActive : Set boudning box colour
		 * @param $colourInactive : Set boudning box colour
		 * @param $text : Set Text it will display
		 * @param $fontsize : Set the size of the font
		 * @param $textColour : Set colour of the text
		 * @param $centered : Use center of object
		 * @param $font : set the font of the text
		 * @param $clickble : if you can click on it
		 * @return 
		 */
		
		public function Button($height:Number, $width:Number, $x:Number, $y:Number, $colourActive:uint,$colourInactive:uint, $text:String = "", $fontsize:Number = 12, $textcolour:uint = 0x000000, $centered:Boolean = false, $font:String = "Arial", $clickble:Boolean = true) 
		{
			
			this.x = $x;
			this.y = $y;
			
			
			_text = new TextField();
			_text.defaultTextFormat = new TextFormat($font, $fontsize, $textcolour);
			_text.text = $text
			_text.width = _text.textWidth+5;
			_text.height = _text.textHeight+3;
			_text.selectable = false;
			if($clickble){addEventListener(MouseEvent.CLICK, mouseClick);}
			
			if ($height == 0 && $width == 0)
			{
				$height = _text.textHeight + 5;
				$width = _text.textWidth + 5;
			}
			if ($centered)
			{
				_xoff = -$width / 2;
				_yoff = -$height / 2
			}  
			_text.x = _xoff;
			_text.y = _yoff;
			_art = new Squar(_xoff , _yoff, $height, $width, $colourInactive);
			
			//some var's where edited so I put them into privated var's here
			_colourActive = $colourActive;
			_colourInactive = $colourInactive;
			_height = $height;
			_width = $width;
			_centered = $centered
			
			addChild(_art);
			addChild(_text);
		}
		
		private function mouseClick(e:MouseEvent):void 
		{
			_clicked = !_clicked;
			draw();
			
		}
		
		private function draw() : void
		{
			if (_clicked)
			{
				removeChild(_text);
				removeChild(_art);
				_art = new Squar(_xoff , _yoff, _height, _width, _colourActive);
				addChild(_art);
				addChild(_text);
			}
			else
			{
				removeChild(_text);
				removeChild(_art);
				_art = new Squar(_xoff , _yoff, _height, _width, _colourInactive);
				addChild(_art);
				addChild(_text);
			}
		}
		
		public function set text(value:TextField):void 
		{
			_text = value;
		}
		
		public function get clicked():Boolean 
		{
			
			return _clicked;
		}
		
		public function set clicked(value:Boolean):void 
		{
			_clicked = value;
			draw();
		}
		
		public function set text(value:TextField):void 
		{
			_text = value;
		}
		
		public function set art(value:Squar):void 
		{
			_art = value;
		}
		
	}

}