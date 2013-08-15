package
{
	import flash.display.MovieClip;
	public class MoveSelector extends MovieClip
	{
		public function MoveSelector(numX:Number, numY:Number)
		{
			x = numX;
			y = numY;
		}
		
		public function moveDown(numX:Number, numY:Number):void
		{
			x = numX;
			y = numY + 32;
		}
		public function moveUp(numX:Number, numY:Number):void
		{
			x = numX;
			y = numY - 32;
		}
		public function moveLeft(numX:Number, numY:Number):void
		{
			x = numX - 32;
			y = numY;
		}
		public function moveRight(numX:Number, numY:Number):void
		{
			x = numX + 32;
			y = numY;
		}
	}
}