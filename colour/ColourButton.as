/*
 * This is an Open Source Project.
 * @see http://www.friispray.co.uk/
 * @author Richard Garside [http://www.richardsprojects.co.uk/]
 * Copyright 2009 Richard Garside, Stuart Childs & Dave Lynch (The Jam Jar Collective)
 * @license GNU General Purpose License [http://creativecommons.org/licenses/GPL/2.0/]
 *
 * Checkin version: $Id: ColourPallete.as 34 2010-01-29 11:43:19Z richard.garside $
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
	import flash.geom.ColorTransform;
	
	/**
	 * A button to choose teh colour that can display the last colour chosen.
	 */
	public class ColourButton extends MovieClip
	{
		public var mcColour:MovieClip;
		
		public function ColourButton()
		{
			trace("Starting " + numChildren);
		}
		
		/**
		 * The preview colour that this button shows.
		 */
		public function set Colour(val:SimpleColour):void
		{
			mcColour.transform.colorTransform = 
						new ColorTransform(0,0,0,1, val.r, val.g, val.b, 0);
		}
	}
}