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

package
{
	import colour.*;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	
	/**
	 * The toolbar that contains all the option buttons.
	 * Most events are currently handled by the FriiSpray class,
	 * and this class doesn't do very much.
	 */
	public class Toolbar extends MovieClip
	{
		// UI Elements
		public var btnBrushCaligraphy2:SimpleButton;
		public var btnBrushCaligraphy:SimpleButton;
		public var btnBrushNormal:SimpleButton;
		public var btnBrushSpray:SimpleButton;
		public var btnClear:SimpleButton;
		public var btnMinus:SimpleButton;
		public var btnPlus:SimpleButton;
		public var btnSave:SimpleButton;
		public var colourPallete:ColourPallete;
		
		/**
		 * Constructor
		 */
		public function Toolbar()
		{
			addEventListener(MouseEvent.MOUSE_OVER, onHover);
		}
		
		/**
		 * Event handler: The cursor is over this Toolbar.
		 *
		 * @param ev MouseEvent object containing event details.
		 */
		private function onHover(ev:MouseEvent):void
		{
			Mouse.show();
		}
	}
}