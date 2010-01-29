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
	import flash.events.Event;
	
	/**
	 * An event that is dispatched when a user chooses a colour.
	 */
	public class ColourPickedEvent extends Event
	{
		public static const COLOUR_PICKED:String = "ColourPicked";
		
		private var _colour:SimpleColour;
		
		/**
		 * Constructor
		 */
		public function ColourPickedEvent(c:SimpleColour)
		{
			super(COLOUR_PICKED, true);
			_colour = c;
		}
		
		/**
		 * The colour chosen by the user.
		 *
		 * @return A SimpleColour object.
		 */
		public function get Colour():SimpleColour
		{
			return _colour;
		}
	}
}