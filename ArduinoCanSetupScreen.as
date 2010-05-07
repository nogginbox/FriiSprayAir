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
	import fl.controls.TextArea;
	import brush.values.*;
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
		private var m_currentArduinoBrushValuesProvider:ArduinoBrushValues;
		
		// Stage variables
		public var btnChooseArduino:SimpleButton;
		public var btnChooseNormal:SimpleButton;
		public var txtOutput:TextArea;
		
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
			btnChooseArduino.addEventListener(MouseEvent.CLICK, onChooseArduinoCan);
			
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
			// Ignore re-clicks
			if (btnChooseNormal.filters.length == 0)
			{
				// Set the highlight
				btnChooseNormal.filters = [m_buttonGlow];
				btnChooseArduino.filters = [];
				
				// If it exists remove the arduino value provider completely
				if (m_currentArduinoBrushValuesProvider != null)
				{
					m_currentArduinoBrushValuesProvider.Destroy();
				}
				
				// Create value provider and pass it as message
				dispatchEvent(new NewBrushValueProviderEvent(new StaticBrushValues()));
			}
		}
		
		private function onChooseArduinoCan(ev:MouseEvent):void
		{
			// Ignore re-clicks
			if (btnChooseArduino.filters.length == 0)
			{
				// Set the highlight
				btnChooseArduino.filters = [m_buttonGlow];
				btnChooseNormal.filters = [];
				
				// Create value provider and pass it as message
				dispatchEvent(new NewBrushValueProviderEvent(new ArduinoBrushValues(txtOutput.textField)));
			}
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