package
{
	import flash.display.MovieClip;
	public class Enemy extends MovieClip
	{
		public var isMovingLeft:Boolean;
		
		public function Enemy()
		{
			x = 416;
			y = 320;
			isMovingLeft = true;
		}
		
		public function moveDown():void
		{
			if ( y < 480 )
			{
				y = y + 32;
			}
		}
		public function moveUp():void
		{
			if ( y > 0 )
			{
				y = y - 32;
			}
		}
		public function moveLeft():void
		{
			if ( x > 0 )
			{
				x = x - 32;
			}
		}
		public function moveRight():void
		{
			if ( x < 480 )
			{
				x = x + 32;
			}
		}
	}
}