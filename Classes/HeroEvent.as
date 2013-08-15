package  
{
	import flash.events.Event;
	public class HeroEvent extends Event 
	{
		public static const DEAD:String = "dead";
		
		public function HeroEvent( type:String )
		{
			super( type );
		}
	}
}