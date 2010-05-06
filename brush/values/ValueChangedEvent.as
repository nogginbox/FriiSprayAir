package brush.values 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Richard Garside
	 */
	public class ValueChangedEvent extends Event
	{
		public static const VALUE_CHANGED = "value-chngd";
		
		public function ValueChangedEvent() 
		{
			super(VALUE_CHANGED);
		}
	}
}