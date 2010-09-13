/*
 * This is an Open Source Project.
 * @see http://www.friispray.co.uk/
 * @author Richard Garside [http://www.richardsprojects.co.uk/]
 * Copyright 2010 Richard Garside, Stuart Childs & Dave Lynch (The Jam Jar Collective)
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

package brush.values
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	/**
	 * A base class that lets us change where we get the width and alpha values for our brushes.
	 * The main purpose of this is to allow brush values to either come from the interface or from a smarter can.
	 * @author Richard Garside
	 */
	public class BrushValues extends EventDispatcher
	{
		// Constants
		private const MIN_BRUSH_SIZE:Number = 1;
		private const SIZE_DELTA:Number = 4;
		
		private var m_brushAlpha:Number;
		private var m_brushSize:int;
		
		public function BrushValues() 
		{
			m_brushSize = 10;
			m_brushAlpha = 1;
		}
		
		public function get BrushAlpha():Number
		{
			return m_brushAlpha;
		}
		public function set BrushAlpha(val:Number):void
		{
			m_brushAlpha = val;
			
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		public function get BrushSize():int
		{
			return m_brushSize;
		}
		
		public function set BrushSize(val:int):void
		{
			setBrushSize(val);
		}
		
		private function setBrushSize(val:int):void
		{
			m_brushSize = val;
			
			// Size shouldn't be smaller than the minimum set brush size (normally 1)
			if (m_brushSize < MIN_BRUSH_SIZE) m_brushSize = MIN_BRUSH_SIZE;
			
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		/**
		 * The base brush size which remains constant even through possible arduino changes
		 */
		public function get CursorBrushSize():int
		{
			return m_brushSize;
		}
		
		/**
		 * Decrease the size of this brush by SIZE_DELTA.
		 */
		public function DecreaseBrushSize():void
		{
			setBrushSize(m_brushSize - SIZE_DELTA);
		}
		
		/**
		 * Increase the size of this brush by SIZE_DELTA
		 */
		public function IncreaseBrushSize():void
		{
			setBrushSize(m_brushSize + SIZE_DELTA);
		}
	}

}