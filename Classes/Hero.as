package
{
	import flash.display.MovieClip;
	public class Hero extends MovieClip
	{
		public function Hero()
		{
			x = 32;
			y = 64;
		}
		
		public function moveHero(numX:Number, numY:Number):void
		{
			if ( numX >= 0 && numX <= 480 )
			{
				x =  numX;
			}
			
			if ( numY <= 352 && numY >= 64  )
			{
				y =  numY;
			}
		}
		
		public function moveDown():void
		{
			if ( y < 352 )
			{
				y = y + 32;
			}
		}
		public function moveUp():void
		{
			if ( y > 64 )
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