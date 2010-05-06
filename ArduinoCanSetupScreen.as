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

package  
{
	import flash.display.*;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.system.Capabilities;
	import flash.ui.Mouse;
	
	/**
	 * ...
	 * @author Richard Garside
	 */
	public class ArduinoCanSetupScreen extends MovieClip
	{
		private static var me:ArduinoCanSetupScreen;
		
		private var m_buttonGlow:GlowFilter;
		
		// Stage variables
		public var btnChooseSuper:SimpleButton;
		public var btnChooseNormal:SimpleButton;
		
		/**
		 * Shouldn't be declared directly. Use SerialSetupScreen.Show()
		 */
		public function ArduinoCanSetupScreen() 
		{
			x = (Capabilities.screenResolutionX - width) / 2;
			y = (Capabilities.screenResolutionY - height) / 2;
			
			m_buttonGlow = new GlowFilter(0xffff00);
			btnChooseNormal.filters = [m_buttonGlow];
			
			// Setup events
			btnChooseNormal.addEventListener(MouseEvent.CLICK, onChooseNormalCan);
			btnChooseSuper.addEventListener(MouseEvent.CLICK, onChooseSuperCan);
			
			addEventListener(MouseEvent.MOUSE_OVER, function(ev:MouseEvent) { 
				Mouse.show();
			});
			addEventListener(MouseEvent.MOUSE_OUT, function(ev:MouseEvent) { 
				Mouse.hide();
			});
		}
		
		//{ region Event handlers
		
		private function onChooseNormalCan(ev:MouseEvent):void
		{
			// Set the highlight
			btnChooseNormal.filters = [m_buttonGlow];
			btnChooseSuper.filters = [];
		}
		
		private function onChooseSuperCan(ev:MouseEvent):void
		{
			// Set the highlight
			btnChooseSuper.filters = [m_buttonGlow];
			btnChooseNormal.filters = [];
		}
		
		//} end region
		
		
		public static function ShowHide(stage:DisplayObjectContainer):ArduinoCanSetupScreen
		{
			if (me == null)
			{
				me = new ArduinoCanSetupScreen();
			}
			
			if (stage.contains(me))
			{
				stage.removeChild(me);
			}
			else
			{
				
				stage.addChild(me);
			}
			
			return me;
		}
	}

}