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
	/**
	 * Makes colours simpler.
	 */
	public class SimpleColour
	{
		public var r:Number;
		public var g:Number;
		public var b:Number;

		/**
		 * Constructor.
		 *
		 * @param red The red component of the colour 0-255.
		 * @param green The green component of the colour 0-255.
		 * @param blue The blue component of the colour 0-255.
		 */
		public function SimpleColour(red:Number, green:Number, blue:Number)
		{
			r = red;
			g = green;
			b = blue;
		}

		/**
		 * A hex representation of this colour.
		 *
		 * @return A hexadecimal number of this colour.
		 */
		public function get _hexColour():Number
		{
			return r<<16|g<<8|b;
		}
		
		/**
		 * A string version of this colour for debugging.
		 */
		public function toString():String
		{
			return r + "," + g + "," + b;
		}
	}
}