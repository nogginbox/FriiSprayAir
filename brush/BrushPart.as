/*
 * This is an Open Source Project.
 * @see http://www.friispray.co.uk/
 * @author Richard Garside [http://www.richardsprojects.co.uk/]
 * Copyright 2009 Richard Garside, Stuart Childs & Dave Lynch (The FriiSpray Team)
 * @license GNU General Purpose License [http://creativecommons.org/licenses/GPL/2.0/]
 *
 * Checkin version: $Id: BrushPart.as 67 2009-02-02 21:31:32Z richard.laptop $
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
	import colour.*
	import flash.display.MovieClip;
	
	/**
	 * One or more of these form a brush and can be used to get different brush shapes.
	 */
	public class BrushPart
	{
		private var m_brushPart:MovieClip;
		private var m_alphaOffset:Number;
		private var m_parentBrush:Brush;
		private var m_xOffset:Number;
		private var m_yOffset:Number;
		private var m_size:Number;
		private var m_sizeRatio:Number;
		
		/**
		 * Constructor
		 */
		public function BrushPart(brush:Brush, xOffset:Number, yOffset:Number, alphaOffset:Number = 1, sizeRatio:Number = 1)
		{
			// Set values
			m_alphaOffset = alphaOffset;
			m_xOffset = xOffset;
			m_yOffset = yOffset;
			m_sizeRatio = sizeRatio;
			
			// Set up brush movie
			m_brushPart = new MovieClip();
			m_brushPart.name = 'BrushPart';
			m_parentBrush = brush;
		}
		
		/**
		 * Clear this brush part's marks from the screen.
		 */
		public function Clear():void
		{
			m_brushPart.graphics.clear();
		}
		
		/**
		 * Draw a line from the current position to this position.
		 *
		 * @param x The x coordinate to draw to.
		 * @param y The y coordinate to draw to.
		 */
		public function Draw(x:Number, y:Number):void
		{
			m_brushPart.graphics.lineTo(translateX(x), translateY(y));
		}
		
		/**
		 * Sets up this brush part to start drawing.
		 *
		 * @param x The x coordinate to start drawing from.
		 * @param y The y coordinate to start drawing from.
		 */
		public function Begin(x:Number, y:Number, size:Number, paintColour:SimpleColour, alpha:Number):void
		{
			m_size = size;
			// Adds or re-adds brush part to paper
			// Re-adding moves it to top of display stack
			
			//Debug trace info
			/*trace('Before adding brush part - display stack =');			
			for (var i:uint=0; i<m_parentBrush.Paper.numChildren; i++)
			{
				trace(m_parentBrush.Paper.getChildAt(i).name);
			}
			trace('Paint depth: ' + m_parentBrush.PaintDepth);*/
			
			m_parentBrush.Paper.addChildAt(m_brushPart, m_parentBrush.Paper.numChildren - m_parentBrush.PaintDepth);
			
			/*trace('After adding brush part - display stack =');
			for (i=0; i<m_parentBrush.Paper.numChildren; i++)
			{
				trace(m_parentBrush.Paper.getChildAt(i).name);
			}
			trace('');*/
			
			// Start new line
			m_brushPart.graphics.moveTo(translateX(x), translateY(y));
			m_brushPart.graphics.lineStyle(m_size * m_sizeRatio, paintColour._hexColour, alpha * m_alphaOffset);
		}
		
		/**
		 * Translates the provided x coordinate to one this brush part draws using its offset.
		 *
		 * @param x The x coordinate to translate.
		 */
		private function translateX(x:Number):Number
		{
			return x + (m_xOffset * m_size);
		}
		
		/**
		 * Translates the provided y coordinate to one this brush part draws using its offset.
		 *
		 * @param y The y coordinate to translate.
		 */
		private function translateY(y:Number):Number
		{
			return y + (m_yOffset * m_size);
		}
	}
}