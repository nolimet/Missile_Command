package utils.draw 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Button extends Sprite 
	{
		private var _art:Squar;
		private var _text:TextField;
		private var _clicked:Boolean = false;
		
		public function Button($Height:Number, $Width:Number, $x:Number, $y:Number, $colour:uint, $text:String="",$fontsize:Number=12,$textcolour:uint=0x000000) 
		{
			this.x = $x;
			this.y = $y;
			
			_text = new TextField();
			_text.defaultTextFormat = new TextFormat("Arial", $fontsize, $textcolour);
			_text.text = $text;
			addEventListener(MouseEvent.CLICK, mouseClick);
			
			_art = new Squar(0, 0, $Height, $Width, $colour);
			addChild(_art);
			addChild(_text);
		}
		
		private function mouseClick(e:MouseEvent):void 
		{
			_clicked = true;
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