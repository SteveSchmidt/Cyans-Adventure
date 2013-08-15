package  
{
	import flash.events.Event;
	public class NavigationEvent extends Event 
	{
		public static const RESTART:String = "restart";
		public static const START:String = "start";
		public static const CONTROLS:String = "controls";
		public static const TITLE:String = "title";
		public static const NEXTLEVEL:String = "nextlevel";
 
		public function NavigationEvent( type:String )
		{
			super( type );
		}
	}
}