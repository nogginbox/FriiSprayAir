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
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	
	/**
	 * Represents a colour swatch that can be clicked to choose the colour.
	 */
	public class Swatch extends MovieClip
	{
		private var _colour:SimpleColour;
		public var swatchBorder:MovieClip;
		public var swatchColour:MovieClip;
		
		/**
		 * Constructor
		 */
		public function Swatch(c:SimpleColour)
		{
			_colour = c;
			
			// Set colour of this swatch
			var tempCol:ColorTransform = new ColorTransform();
			tempCol.color = _colour._hexColour;
			swatchColour.transform.colorTransform = tempCol;
			
			// Hide highlight border
			Selected = false;
			
			// Add events
			addEventListener(MouseEvent.MOUSE_DOWN, swatchClicked);
		}
		
		/**
		 * Event function: User has pressed this swatch.
		 * 
		 * @param ev MouseEvent object containing event details.
		 */
		private function swatchClicked(ev:MouseEvent):void
		{
			dispatchEvent(new ColourPickedEvent(_colour));
			// Hide highlight border
			swatchBorder.visible = true;
		}
		
		/**
		 * Sets if this is the selected swatch or not.
		 * @param val Boolean
		*/
		public function set Selected(val:Boolean):void
		{
			swatchBorder.visible = val;
		}
	}
}