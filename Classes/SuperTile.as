package
{
	import flash.display.MovieClip;
	public class SuperTile extends MovieClip
	{
		private var parentTile:SuperTile;
		
		public function SuperTile()
		{
			
		}
		
		public function getParent():SuperTile
		{
			return parentTile;
		}
		
		public function setParent(givenParent:SuperTile):
		{
			parentTile = givenParent;
		}
	}
}