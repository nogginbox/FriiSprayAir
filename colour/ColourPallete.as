/*
 * This is an Open Source Project.
 * @see http://www.friispray.co.uk/
 * @author Richard Garside [http://www.richardsprojects.co.uk/]
 * Copyright 2009 Richard Garside, Stuart Childs & Dave Lynch (The FriiSpray Team)
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

		private const BLACK:Number = 12;
		
		// Stage objects
		public var swatch0:MovieClip;

		/**
		 * The constructor.
		 * Defines thes colours that will appear in this pallette.
		 */
		public function ColourPallete()
		{
			// molotow colour chart numbers: [from http://www.molotow.com/products/molotow-artist/true-color-fan/color-chart/]
			swatches = new Array (	new Swatch(new SimpleColour(255, 225, 65)),		// 006 - bright yellow
									new Swatch(new SimpleColour(247, 185, 62)),		// 083 - golden yellow
									new Swatch(new SimpleColour(124, 185, 48)),		// 064 - grass green
								 	new Swatch(new SimpleColour(1, 91, 37)),		// 143 - dark green
								 	new Swatch(new SimpleColour(0, 178, 234)),		// 161 - light blue
									new Swatch(new SimpleColour(0, 65, 145)),		// 024 - blue blue
									new Swatch(new SimpleColour(237, 111, 34)),		// 085 - orange                    
									new Swatch(new SimpleColour(216, 0, 11)),		// 013 - red
									new Swatch(new SimpleColour(229, 0, 131)),		// 164 - bright pink
									new Swatch(new SimpleColour(244, 189, 184)),	// 081 - skin pink
									new Swatch(new SimpleColour(110, 59, 30)),		// 092 - skin brown
									new Swatch(new SimpleColour(255, 255, 255)),	// 160 - white
									new Swatch(new SimpleColour(0, 0, 0)),			// Black
									new Swatch(new SimpleColour(152, 151, 156)),	// 101 - grey
									new Swatch(new SimpleColour(1, 158, 149)),		// 074 - aqua blue
									new Swatch(new SimpleColour(82, 24, 134)),		// 042 - purple
									new Swatch(new SimpleColour(211, 219, 74)),		// 119 - kiwi green
									new Swatch(new SimpleColour(177, 109, 90)),		// 169 - skin shade
									new Swatch(new SimpleColour(128, 19, 19)),		// blood red
									new Swatch(new SimpleColour(255, 239, 180))		// 115 - vanilla yellow
									);		
			
			// Add first swatch
			swatches[0].x = 5;
			swatches[0].y = 5;
			addChild(swatches[0]);
			
			// Set first active swatch to be black
			swatches[BLACK].Selected = true;
			
			// Duplicate first swatch to make entire pallete.
			var palleteCount:Number = 0;
			for(var i:Number=0; i < 2; i++)
			{
				for(var j:Number=0; j < 10; j++)
				{
					if(!(i==0 && j==0)) //Don't draw first element
					{
						// Set swatch position
						swatches[palleteCount].x = swatches[0].x + j*28;
						swatches[palleteCount].y = swatches[0].y + i*28;
						// Add it to stage
						addChild(swatches[palleteCount]);
					}
					palleteCount++;
				}
			}
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
	}
}