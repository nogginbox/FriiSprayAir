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
	import flash.events.*;
	import flash.ui.Mouse;
	
	/**
	 * The toolbar that contains all the option buttons.
	 * Most events are currently handled by the FriiSpray class,
	 * and this class doesn't do very much.
	 */
	public class Toolbar extends MovieClip
	{
		// UI Elements
		public var btnBrushPanel:SimpleButton;
		public var btnColourPanel:ColourButton;
		public var btnClear:SimpleButton;
		public var btnMinus:SimpleButton;
		public var btnPlus:SimpleButton;
		public var btnSave:SimpleButton;
		public var panelBrushes:MovieClip;
		public var panelColour:MovieClip;
		
		private var m_activePanelBrushes:Boolean = false;
		private var m_activePanelColour:Boolean = false;
		private var m_panelMoving:Boolean = false;
		
		
		/**
		 * Constructor
		 */
		public function Toolbar()
		{
			addEventListener(MouseEvent.MOUSE_OVER, onHover);
			btnBrushPanel.addEventListener(MouseEvent.CLICK, onShowHidePanelBrush);
			btnColourPanel.addEventListener(MouseEvent.CLICK, onShowHidePanelColour);
			
			// Add hide events for all panel buttons
			BtnBrushNormal.addEventListener(MouseEvent.CLICK, onShowHidePanelBrush);
			BtnBrushSpray.addEventListener(MouseEvent.CLICK, onShowHidePanelBrush);
			BtnBrushCaligraphy.addEventListener(MouseEvent.CLICK, onShowHidePanelBrush);
			BtnBrushCaligraphy2.addEventListener(MouseEvent.CLICK, onShowHidePanelBrush);
			colourPallete.addEventListener(ColourPickedEvent.COLOUR_PICKED, onColourPicked);
		}
		
		public function ChangeBrushPanelButton(newButton:SimpleButton):void
		{
			newButton.x = btnBrushPanel.x;
			newButton.y = btnBrushPanel.y;
			
			btnBrushPanel.removeEventListener(MouseEvent.CLICK, onShowHidePanelBrush);
			removeChild(btnBrushPanel);
			btnBrushPanel = newButton;
			addChild(newButton);
			
			btnBrushPanel.addEventListener(MouseEvent.CLICK, onShowHidePanelBrush);
		}
		
		private function onColourPicked(ev:ColourPickedEvent)
		{
			btnColourPanel.Colour = ev.Colour;
			onShowHidePanelColour(ev);
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
		
		private function onShowHidePanelBrush(ev:MouseEvent):void
		{
			if(!m_panelMoving)
			{
				m_panelMoving = true;
				if(m_activePanelBrushes)
				{
					gotoAndPlay("HideBrushes");
				}
				else
				{
					gotoAndPlay("ShowBrushes");
				}
				m_activePanelBrushes = !m_activePanelBrushes;
				m_activePanelColour = false;
			}
		}
		
		private function onShowHidePanelColour(ev:Event):void
		{
			if(!m_panelMoving)
			{
				m_panelMoving = true;
				if(m_activePanelColour)
				{
					gotoAndPlay("HideColours");
				}
				else
				{
					gotoAndPlay("ShowColours");
				}
				m_activePanelColour = !m_activePanelColour;
				m_activePanelBrushes = false;
			}
		}
		
		protected function stopMenu():void
		{
			stop();
			m_panelMoving = false;
		}
		
		// Brush panel buttons
		public function get BtnBrushNormal():SimpleButton
		{
			return panelBrushes.btnBrushNormal;
		}
		public function get BtnBrushSpray():SimpleButton
		{
			return panelBrushes.btnBrushSpray;
		}
		public function get BtnBrushCaligraphy():SimpleButton
		{
			return panelBrushes.btnBrushCaligraphy;
		}
		public function get BtnBrushCaligraphy2():SimpleButton
		{
			return panelBrushes.btnBrushCaligraphy2;
		}
		public function get colourPallete():ColourPallete
		{
			return panelColour.colourPallete;
		}
			
			
	}
}