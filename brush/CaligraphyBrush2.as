/*
 * This is an Open Source Project.
 * @see http://www.friispray.co.uk/
 * @author Richard Garside [http://www.richardsprojects.co.uk/]
 * Copyright 2009 Richard Garside, Stuart Childs & Dave Lynch (The FriiSpray Team)
 * @license GNU General Purpose License [http://creativecommons.org/licenses/GPL/2.0/]
 *
 * Checkin version: $Id: CaligraphyBrush2.as 67 2009-02-02 21:31:32Z richard.laptop $
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
	 * A caligraphy style brush made from 3 brush parts.
	 */
	public class CaligraphyBrush2 extends Brush
	{
		/**
		 * Constructor
		 */
		public function CaligraphyBrush2(paper:MovieClip, cursor:MovieClip)
		{
			super(paper, cursor);
			
			addBrushPart(new BrushPart(this, 0.2, -0.2, 1, 0.5));
			addBrushPart(new BrushPart(this, 0, 0, 1, 0.5));
			addBrushPart(new BrushPart(this, -0.2, 0.2, 1, 0.5));
		}
	}
}