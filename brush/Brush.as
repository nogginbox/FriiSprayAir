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

package brush
{
	import colour.*;	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.system.Capabilities;
	import flash.ui.Mouse;
	
	/**
	 * Base class for all brush classes
	 */
	public class Brush
	{
		private var m_colour:SimpleColour;
		private var m_size:Number;
		
		protected var m_brushParts:Array;
		private var m_cursor:MovieClip;
		private var m_paintDepth:uint = 0;
		protected var m_paper:MovieClip;
		private var m_paperBitmap:Bitmap;
		
		// Constants
		private const MIN_BRUSH_SIZE:Number = 1;
		private const MIN_CURSOR_SIZE:Number = 3;
		private const SIZE_DELTA:Number = 4;
		
		/**
		 * Constructor
		 */
		public function Brush(paper:MovieClip, brushCursor:MovieClip)
		{
			Colour = new SimpleColour(0,0,0);
			Size = 10;
			m_paper = paper;
			
			m_cursor = brushCursor;
			m_cursor.mouseEnabled = false;
			m_cursor.mouseChildren = false;
			m_cursor.visible = false;
			CursorSize = Size;
			
			m_brushParts = new Array();
		}
		
		// *** Accessors ***
		
		/**
		 * Add a brush part to this brush.
		 */
		protected function addBrushPart(brushPart:BrushPart):void
		{
			m_brushParts.push(brushPart);
		}
		
		/**
		 * The colour this brush paints.
		 */
		public function get Colour():SimpleColour
		{
			return m_colour;
		}
		
		/**
		 * Set the colour of this brush.
		 */
		public function set Colour(colour:SimpleColour):void
		{
			m_colour = colour;
		}
		
		/**
		 * Gets the paper this brush is drawing on
		 */
		public function get Paper():MovieClip
		{
			return m_paper;
		}
		
		/**
		 * Gets the paint depth
		 * The number of layers we wish to paint below.
		 * 0 paints on surface, 1 paints below top layer
		 */
		public function get PaintDepth():uint
		{
			return m_paintDepth;
		}
		
		/**
		 * Sets the paint depth
		 * The number of layers we wish to paint below.
		 * 0 paints on surface, 1 paints below top layer
		 */
		public function set PaintDepth(val:uint):void
		{
			m_paintDepth = val;
		}
		
		/**
		 * Set the size of this brush's cursor.
		 */
		private function set CursorSize(val:Number):void
		{
			// A cursor size of less than 3 crashes it.
			if(val < 3) val = 3;
			
			// Set height and width
			m_cursor.width = val;
			m_cursor.height = val;
		}
		
		/**
		 * Get the size of this brush.
		 */
		public function get Size():Number
		{
			return m_size;
		}
		
		/**
		 * Set the size of this brush.
		 */
		public function set Size(size:Number):void
		{
			m_size = size;
			
			// Size shouldn't be smaller than the minimum set brush size (normally 1)
			if(m_size < MIN_BRUSH_SIZE) m_size = MIN_BRUSH_SIZE;
		}
		
		/**
		 * Decrease the size of this brush by SIZE_DELTA.
		 */
		public function DecreaseSize():void
		{
			Size -= SIZE_DELTA;
			CursorSize = Size;
		}
		
		/**
		 * Increase the size of this brush by SIZE_DELTA
		 */
		public function IncreaseSize():void
		{
			Size += SIZE_DELTA;
			CursorSize = Size;
		}
		
		// *** Interface Methods *** //
		
		/**
		 * Sets up this brush to start drawing
		 *
		 * @param x The x coordinate to start drawing from.
		 * @param y The y coordinate to start drawing from.
		 */
		public function Begin(x:Number, y:Number):void
		{
			//trace('Beginning new line at (' + x + ', ' + y + ')');
			copyPaperToOnscreenBitmap();
			
			// Begin all brush parts and draw a very small line to start things off
			for(var i:Number=0; i < m_brushParts.length; i++)
			{
				m_brushParts[i].Clear();
				m_brushParts[i].Begin(x-1, y, Size, Colour, 1)
			}
			Draw(x, y);
		}
		
		/**
		 * Clear everything this brush has done from the canvass.
		 */
		public function ClearCanvass():void
		{
			// Clear
			m_paper.graphics.clear();
			// Set screen background (also resizes available drawable screen)
			m_paper.graphics.beginFill(0xffffff);
			m_paper.graphics.drawRect(0,0, Capabilities.screenResolutionX, Capabilities.screenResolutionY);
			
			if(m_paperBitmap != null) {
				m_paper.removeChild(m_paperBitmap);
				m_paperBitmap = null;
			}
			ClearBrushParts();
		}
		
		/**
		 * Clear the marks made by all the brush parts.
		 */
		private function ClearBrushParts():void
		{
			for(var i:Number=0; i < m_brushParts.length; i++)
			{
				m_brushParts[i].Clear();
			}
		}
		
		/**
		 * Draw a line from the current position to this position.
		 *
		 * @param x The x coordinate to draw to.
		 * @param y The y coordinate to draw to.
		 */
		public function Draw(x:Number, y:Number):void
		{
			for(var i:Number=0; i < m_brushParts.length; i++)
			{
				m_brushParts[i].Draw(x,y);
			}
		}
		
		/**
		 * Stop using this brush
		 *
		 * @returns The bitmap that this brush is storing to cache the marks made on the paper
		 */
		public function DropBrush():Bitmap
		{
			copyPaperToOnscreenBitmap();
			// Clear all brush parts
			ClearBrushParts();
			
			m_cursor.stopDrag();
			m_cursor.visible = false;
			Mouse.show();
			return m_paperBitmap;
		}
		
		/**
		 * Start using this brush
		 */
		public function PickUpBrush(cachedPaper:Bitmap = null):void
		{
			m_paperBitmap = cachedPaper;
			m_cursor.visible = true;
			m_cursor.startDrag(true);
			Mouse.hide();
		}
		
		/**
		 * Copy the recent lines and previous bitmap to a new bitmap that will replace them.
		 */
		protected function copyPaperToOnscreenBitmap():void
		{
			// Copy all lines to bitmap
			var paperBitmapData:BitmapData = new BitmapData(m_paper.width, m_paper.height);
			paperBitmapData.draw(m_paper);
			
			// Remove old bitmap from screen (if it exists)
			if(m_paperBitmap != null) {
				m_paper.removeChild(m_paperBitmap);
			}
			
			// Add new bitmap to screen
			m_paperBitmap = new Bitmap(paperBitmapData);
			m_paperBitmap.name = 'PaperBitmap';
			m_paper.addChildAt(m_paperBitmap, m_paper.numChildren - PaintDepth); //1
		}
	}
}