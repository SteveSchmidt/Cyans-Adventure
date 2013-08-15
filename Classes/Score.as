package
{
	import flash.text.TextField;
	public class Score extends Counter
	{
		public function Score()
		{
			super();
			x = 320;
			y = 0;
		}
		
		override public function updateDisplay():void
		{
 			super.updateDisplay();
			scoreDisplay.text = currentValue.toString();
		}
	}
}