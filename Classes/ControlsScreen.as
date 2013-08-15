package 
{
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
 
	public class ControlsScreen extends MovieClip 
	{
		public function ControlsScreen() 
		{
			startButton.addEventListener( MouseEvent.CLICK, onClickStart );
		}
 
		public function onClickStart( event:MouseEvent ):void
		{
			dispatchEvent( new NavigationEvent( NavigationEvent.START ) );
		}
	}
}