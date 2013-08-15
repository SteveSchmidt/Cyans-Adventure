package 
{
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
 
	public class TitleScreen extends MovieClip 
	{
		public function TitleScreen() 
		{
			controlsButton.addEventListener( MouseEvent.CLICK, onClickControls );
		}
 
		public function onClickControls( event:MouseEvent ):void
		{
			dispatchEvent( new NavigationEvent( NavigationEvent.CONTROLS ) );
		}
	}
}