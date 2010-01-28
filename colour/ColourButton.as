package colour
{
	import flash.display.MovieClip;
	import flash.geom.ColorTransform;
	
	public class ColourButton extends MovieClip
	{
		public var mcColour:MovieClip;
		
		public function ColourButton()
		{
			trace("Starting " + numChildren);
		}
		
		public function set Colour(val:SimpleColour)
		{
			mcColour.transform.colorTransform = 
						new ColorTransform(0,0,0,1, val.r, val.g, val.b, 0);
		}
	}
}