package
{
	import flash.display.MovieClip;
	public class Skeleton extends MovieClip
	{
		public var isOutside:Boolean;
		
		public function Skeleton()
		{
			
		}
		
		public function moveSkeleton(numX:Number, numY:Number):void
		{
			x = numX;
			y = numY;
		}
	}
}