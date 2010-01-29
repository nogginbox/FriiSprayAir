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
	import flash.display.*;
	import flash.events.MouseEvent;
	
	/*
	 * Extends Ryan Taylor of http://www.boostworthy.com's ColourBar class
	 * to add picker properties
	 */
	public class ColourBarPicker extends ColourBar
	{
		private var m_bitmapColourBar:BitmapData;
		
		/**
		 * Constructor.
		 * 
		 * @param	nWidth		The width of the color bar.
		 * @param	nHeight		The height of the color bar.
		 */
		public function ColourBarPicker(nWidth:Number = DEFAULT_WIDTH, nHeight:Number = DEFAULT_HEIGHT)
		{
			super(nWidth, nHeight);
			addEventListener(MouseEvent.CLICK, onColourPick);
		}
		
		/**
		 * Initializes the color bar.
		 * 
		 * @param	nWidth		The width of the color bar.
		 * @param	nHeight		The height of the color bar.
		 */
		protected override function init(nWidth:Number = DEFAULT_WIDTH, nHeight:Number = DEFAULT_HEIGHT):void
		{
			super.init(nWidth, nHeight);
			
			// Copy data to bitmap, so it can scale okay
			m_bitmapColourBar = new BitmapData(nWidth, nHeight, false);
			m_bitmapColourBar.draw(this);
			graphics.clear();
			addChild(new Bitmap(m_bitmapColourBar));
		}
		
		/**
		 * User clicks on a colour in the colour bar
		 */
		private function onColourPick(ev:MouseEvent):void
		{
			var _colour:SimpleColour = SimpleColour.CreateFromHex(m_bitmapColourBar.getPixel(mouseX, mouseY));
			dispatchEvent(new ColourPickedEvent(_colour));
		}
	}
	
}