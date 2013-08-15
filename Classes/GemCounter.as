package
{
	import flash.text.TextField;
	public class GemCounter extends Counter
	{
		public var maxValue:Number;
		
		public function GemCounter()
		{
			super();
			x = 192;
			y = 0;
		}
		
		public function addMax( amountToAdd:Number ):void
		{
			maxValue = amountToAdd;
			updateDisplay();
		}
		override public function updateDisplay():void
		{
 			super.updateDisplay();
			gemDisplay.text = currentValue.toString();
			gemMaxDisplay.text = maxValue.toString();
		}
	}
}