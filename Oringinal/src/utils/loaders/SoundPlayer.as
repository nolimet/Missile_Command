package utils.loaders 
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author Jesse Stam
	 */
	public class SoundPlayer extends Sound
	{
		private var sound:Sound = new Sound();
		private var channel:SoundChannel = new SoundChannel();
		private var _playing:Boolean = false;
		
		public function SoundPlayer(url:String)
		{
			sound.load(new URLRequest(url));
			channel = sound.play(0, 1, null);
			_playing=true
		}
		
		public function stopS():void
		{
			channel.stop();
			_playing=false
		}
		public function get playing():Boolean 
		{
			return _playing;
		}
	}

}