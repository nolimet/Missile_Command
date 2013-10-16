package utils.draw 
{
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
		/**
		 * Function make a Simple clickble button
		 *
		 * @example example:
		 * @param $height : Set height of bounding box
		 * @param $width : Set width of bouding box
		 * @param $x : Set location on the x axis
		 * @param $y : Set location on the y axis
		 * @param $colour : Set boudning box colour
		 * @param $text : Set Text it will display
		 * @param $fontsize : Set the size of the font
		 * @param $textColour : Set colour of the text
		 * @param $font : set the font of the text
		 * @return 
		 */
		
		public function Button($height:Number, $width:Number, $x:Number, $y:Number, $colour:uint, $text:String="",$fontsize:Number=12,$textcolour:uint=0x000000, $font:String = "Arial") 
		{
			this.x = $x;
			this.y = $y;
			
			_text = new TextField();
			_text.defaultTextFormat = new TextFormat($font, $fontsize, $textcolour);
			_text.text = $text;
			_text.selectable = false;
			addEventListener(MouseEvent.CLICK, mouseClick);
			
			if ($height == 0 && $width == 0)
			{
				$height = _text.textHeight + 5;
				$width = _text.textWidth + 5;
			}
			_art = new Squar(0, 0, $height, $width, $colour);
			addChild(_art);
			addChild(_text);
		}
		
		private function mouseClick(e:MouseEvent):void 
		{
			_clicked = !_clicked;
			trace("clicked");
		}
		
		public function set text(value:TextField):void 
		{
			_text = value;
		}
		
		public function get clicked():Boolean 
		{
			
			return _clicked;
		}
		
	}

}