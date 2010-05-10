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
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.system.Capabilities;
	import flash.text.TextField;
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
		public var btnClose:SimpleButton;
		public var txtOutput:TextArea;
		public var txtAlpha:TextField;
		public var txtAlphaMax:TextField;
		public var txtAlphaMin:TextField;
		public var txtSize:TextField;
		public var txtSizeMax:TextField;
		public var txtSizeMin:TextField;
		
		
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
			
			txtAlphaMax.addEventListener(Event.CHANGE, onChangeMinMaxSetting);
			txtAlphaMin.addEventListener(Event.CHANGE, onChangeMinMaxSetting);
			txtSizeMax.addEventListener(Event.CHANGE, onChangeMinMaxSetting);
			txtSizeMin.addEventListener(Event.CHANGE, onChangeMinMaxSetting);
			
			btnClose.addEventListener(MouseEvent.CLICK, function(ev:MouseEvent) {
				ShowHide(me.parent);
			});
			
			addEventListener(MouseEvent.MOUSE_OVER, function(ev:MouseEvent) { 
				Mouse.show();
			});
			addEventListener(MouseEvent.MOUSE_OUT, function(ev:MouseEvent) { 
				Mouse.hide();
			});
		}
		
		//{ region Event handlers
		
		private function onChangeMinMaxSetting(ev:Event):void
		{
			trace("Trying to change");
			m_currentArduinoBrushValuesProvider.BrushAlphaMin = int(txtAlphaMin.text);
			m_currentArduinoBrushValuesProvider.BrushAlphaMax = int(txtAlphaMax.text);
			m_currentArduinoBrushValuesProvider.BrushSizeMin = int(txtSizeMin.text);
			m_currentArduinoBrushValuesProvider.BrushSizeMax = int(txtSizeMax.text);
		}
		
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
				m_currentArduinoBrushValuesProvider = new ArduinoBrushValues(txtOutput.textField, txtSize, txtAlpha);
				dispatchEvent(new NewBrushValueProviderEvent(m_currentArduinoBrushValuesProvider));
				
				// Set settings numbers
				txtAlphaMin.text = m_currentArduinoBrushValuesProvider.BrushAlphaMin.toString();
				txtAlphaMax.text = m_currentArduinoBrushValuesProvider.BrushAlphaMax.toString();
				txtSizeMin.text = m_currentArduinoBrushValuesProvider.BrushSizeMin.toString();
				txtSizeMax.text = m_currentArduinoBrushValuesProvider.BrushSizeMax.toString();
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