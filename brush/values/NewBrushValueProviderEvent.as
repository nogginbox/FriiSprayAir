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
	
	/**
	 * ...
	 * @author Richard Garside
	 */
	public class NewBrushValueProviderEvent extends Event
	{
		public static const NEW_BRUSH_VALUE_PROVIDER:String = "nw-brsh-val-provider";
		
		private var m_valueProvider:BrushValues;
		
		public function NewBrushValueProviderEvent(provider:BrushValues):void
		{
			m_valueProvider = provider;
			
			super(NEW_BRUSH_VALUE_PROVIDER);
		}
		
		public function get BrushValueProvider():BrushValues
		{
			return m_valueProvider;
		}
	}

}