package brush 
{
	import brush.Brush;
	import flash.display.MovieClip;
	
	/**
	 * A transparent brush for Stuart. 
	 * @author Richard Garside
	 */
	public class SecretBrush extends Brush
	{
		
		public function SecretBrush(paper:MovieClip, cursor:MovieClip)
		{
			super(paper, cursor);
			
			// Set up correct number of brush parts for this brush
			addBrushPart(new BrushPart(this, 0, 0, 0.5));
		}
		
	}

}