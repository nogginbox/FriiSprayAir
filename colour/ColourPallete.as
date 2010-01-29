/*
 * This is an Open Source Project.
 * @see http://www.friispray.co.uk/
 * @author Richard Garside [http://www.richardsprojects.co.uk/]
 * Copyright 2009 Richard Garside, Stuart Childs & Dave Lynch (The Jam Jar Collective)
 * @license GNU General Purpose License [http://creativecommons.org/licenses/GPL/2.0/]
 *
 * Checkin version: $Id$
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

package colour
{
	import flash.display.MovieClip;
	
	/**
	 * The Colour Pallete with a number of Colour Swatches to choose from.
	 */
	public class ColourPallete extends MovieClip
	{
		private var swatches:Array;

		private const BLACK:Number = 0;
		
		// Stage objects
		public var swatch0:MovieClip;

		/**
		 * The constructor.
		 * Defines the colours that will appear in this pallette.
		 */
		public function ColourPallete()
		{
			var colourBar:ColourBarPicker = new ColourBarPicker(286, 62);
			colourBar.y = 35;
			addChild(colourBar);
			
			// molotow colour chart numbers: [from http://www.molotow.com/products/molotow-artist/true-color-fan/color-chart/]
			swatches = new Array (	new Swatch(new SimpleColour(0, 0, 0)),			// Black
									new Swatch(new SimpleColour(255, 255, 255)),	// 160 - white
									new Swatch(new SimpleColour(255, 225, 65)),		// 006 - bright yellow
									new Swatch(new SimpleColour(124, 185, 48)),		// 064 - grass green
								 	new Swatch(new SimpleColour(1, 91, 37)),		// 143 - dark green
								 	new Swatch(new SimpleColour(0, 178, 234)),		// 161 - light blue
									new Swatch(new SimpleColour(0, 65, 145)),		// 024 - blue blue
									new Swatch(new SimpleColour(237, 111, 34)),		// 085 - orange                    
									new Swatch(new SimpleColour(216, 0, 11)),		// 013 - red
									new Swatch(new SimpleColour(244, 189, 184))		// 081 - skin pink
									);
			
			// Set first active swatch to be black
			swatches[BLACK].Selected = true;
			
			drawSwatches();
		}
		
		/**
		 * Marks all swatches as unselected.
		 */
		public function UnselectAll():void
		{
			for (var i:Number = 0; i < swatches.length; i++)
			{
				swatches[i].Selected = false;
			}
		}
		
		/**
		 * Draws all the swatches to the scren.
		 */
		private function drawSwatches():void
		{
			for(var i:Number=0; i < 10; i++)
			{
				// Set swatch position
				swatches[i].x = 5 + i*28;
				swatches[i].y = 5;
				// Add it to stage
				addChild(swatches[i]);
			}
		}
	}
}