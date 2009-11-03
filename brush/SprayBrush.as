/*
 * This is an Open Source Project.
 * @see http://www.friispray.co.uk/
 * @author Richard Garside [http://www.richardsprojects.co.uk/]
 * Copyright 2009 Richard Garside, Stuart Childs & Dave Lynch (The FriiSpray Team)
 * @license GNU General Purpose License [http://creativecommons.org/licenses/GPL/2.0/]
 *
 * Checkin version: $Id: SprayBrush.as 67 2009-02-02 21:31:32Z richard.laptop $
 *
 * This file is part of FriiSpray.
 *
 * FriiSpray is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * FriiSpray is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with FriiSpray.  If not, see <http://www.gnu.org/licenses/>.
 */

package brush
{
	import flash.display.MovieClip;
	
	/**
	 * A spraybrush made from 8 centred brush parts with varying alpha values.
	 */
	public class SprayBrush extends Brush
	{
		/**
		 * Constructor
		 */
		public function SprayBrush(paper:MovieClip, cursor:MovieClip)
		{
			super(paper, cursor);
			
			// Set up correct number of brush parts for this brush
			var numBrushes:Number = 8;
			var brushMiddleWidth:Number = 0.5;
			var brushWidthDelta:Number = (1 - brushMiddleWidth) / numBrushes;
			var brushAlphaDelta:Number = 0.9 / numBrushes;
			var brushWidth:Number = 1;
			var brushAlpha:Number = 0;
			
			for(var i:Number=0; i<numBrushes; i++)
			{
				brushAlpha += brushAlphaDelta;
				addBrushPart(new BrushPart(this, 0, 0, brushAlpha, brushWidth));
				brushWidth -= brushWidthDelta;
			}
		}
	}
	
}