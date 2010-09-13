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
	import fl.controls.TextArea;
	import flash.errors.*;
	import flash.events.*;
	import flash.net.Socket;
	import flash.text.TextField;
	
	/**
	 * Brush values where base values are set by graphical UI and adjusted by arduino.
	 * (this feature is in development - feature3)
	 * @author Richard Garside
	 */
	public class ArduinoBrushValues extends BrushValues
	{
		private var m_feedbackText:TextField;
		private var m_feedbackAlphaText:TextField;
		private var m_feedbackSizeText:TextField;
		private var m_lastSerialSignalReceived:Date;
		private var m_socket:Socket;
		
		// The values from the arduino can
		private var m_offsetBrushAlpha:Number;
		private var m_offsetBrushSize:int;
		
		private var m_alphaMin:int;
		private var m_alphaMax:int;
		private var m_alphaRange:int;
		private var m_sizeMin:int;
		private var m_sizeMax:int;
		private var m_sizeRange:int;
		
		public function ArduinoBrushValues(feedBackText:TextField, sizeTextField:TextField, alphaTextField:TextField) 
		{
			m_feedbackText = feedBackText;
			m_feedbackAlphaText = alphaTextField;
			m_feedbackSizeText = sizeTextField;
			m_feedbackText.text = "";
			
			m_socket = new Socket("localhost", 5335);
			
			m_socket.addEventListener(Event.CLOSE, onClose);
			m_socket.addEventListener(Event.CONNECT, onConnect);
			m_socket.addEventListener(IOErrorEvent.IO_ERROR, onIoError);
			m_socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
			m_socket.addEventListener(ProgressEvent.SOCKET_DATA, onSocketData);
			
			// Standard settings
			// big size number = small
			BrushAlphaMin = 0;
			BrushAlphaMax = 255;
			BrushSizeMin = 0;
			BrushSizeMax = 255;
		}
		
		public function Destroy()
		{
			m_socket.close();
			
			m_socket.removeEventListener(Event.CLOSE, onClose);
			m_socket.removeEventListener(Event.CONNECT, onConnect);
			m_socket.removeEventListener(IOErrorEvent.IO_ERROR, onIoError);
			m_socket.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
			m_socket.removeEventListener(ProgressEvent.SOCKET_DATA, onSocketData);
			
			m_socket = null;
			m_feedbackText = null;
		}
		
		//{region Properties
		
		/**
		 * The number of miliseconds since last serial signal was received.
		 * -1 = no signal received.
		 */
		public function get InactiveTime():int
		{
			if (m_lastSerialSignalReceived == null)
			{
				return -1;
			}
			else
			{
				var now = new Date();
				return now.time = m_lastSerialSignalReceived.time;
			}
		}
		
		public override function get BrushAlpha():Number
		{
			return super.BrushAlpha + (m_offsetBrushAlpha / 255);
		}
		
		private function brushAlphaCalculateRange()
		{
			m_alphaRange = m_alphaMax - m_alphaMin;
		}
		
		public function get BrushAlphaMax():Number
		{
			return m_alphaMax;
		}
		
		public function set BrushAlphaMax(val:Number):void
		{
			m_alphaMax = val;
			brushAlphaCalculateRange();
		}
		
		public function get BrushAlphaMin():Number
		{
			return m_alphaMin;
		}
		
		public function set BrushAlphaMin(val:Number):void
		{
			m_alphaMin = val;
			brushAlphaCalculateRange();
		}
		
		
		public override function get BrushSize():int
		{	
			var val = (1 - calcRanged(m_offsetBrushSize, m_sizeMin, m_sizeRange));
			trace(val);
			
			return super.BrushSize + (val * 100);
		}
		
		private function brushSizeCalculateRange()
		{
			m_sizeRange = m_sizeMax - m_sizeMin;
		}
		
		public function get BrushSizeMax():int
		{
			return m_sizeMax;
		}
		
		public function set BrushSizeMax(val:int):void
		{
			m_sizeMax = val;
			brushSizeCalculateRange();
		}
		
		public function get BrushSizeMin():int
		{
			return m_sizeMin;
		}
		
		public function set BrushSizeMin(val:int):void
		{
			m_sizeMin = val;
			brushSizeCalculateRange();
		}
		
		//} end region
		
		//{ region Event handlers
		
		/**
		 * Event handler: The socket connection has been closed
		 */
		private function onClose(ev:Event):void
		{
			m_feedbackText.appendText("The arduino connection has been closed.");
		}
		
		/**
		 * Event handler: The socket connection is now open
		 */
		private function onConnect(ev:Event):void
		{
			m_feedbackText.appendText("The arduino connection is now open.");
		}
		
		/**
		 * Event handler: IO Error event
		 */
		private function onIoError(ev:IOErrorEvent):void
		{
			m_feedbackText.appendText("IO error: " + ev);
		}
		
		/**
		 * Event handler: Security Error event
		 */
		private function onSecurityError(ev:SecurityErrorEvent):void
		{
			m_feedbackText.appendText("Security error: " + ev);
		}
		
		
		private var m_dataSoFar:String;
		/**
		 * Puts the data input together from the arduino can
		 */
		private function onSocketData(ev:ProgressEvent):void
		{
			var textInput:String = m_socket.readUTFBytes(m_socket.bytesAvailable);
			
			m_dataSoFar += textInput;
			
			// Have we got the whole line
			if (textInput.indexOf("\n") > 0)
			{
				setNewValues(m_dataSoFar);
				m_dataSoFar = "";
			}
		}
		
		//} end region
		
		private function calcRanged(val:Number, min:Number, range:Number):Number
		{
			return Math.min(Math.max((val - min) / range, 0), 1);
		}
		
		/**
		 * Takes a complete line of input and then sets the brushes values from this
		 * @param	input
		 */
		private function setNewValues(input:String):void
		{
			var inputBits:Array = input.replace(" \n", "").split(" ");
			
			m_offsetBrushAlpha =  int("0x" + inputBits[1]);
			m_offsetBrushSize = int("0x" + inputBits[2]);
			
			m_feedbackAlphaText.text = m_offsetBrushAlpha.toString();
				
				
			m_feedbackSizeText.text	= m_offsetBrushSize.toString();
			//trace("Input - alpha: " + m_offsetBrushAlpha + ", size: " + m_offsetBrushSize + "\n");
		}
	}

}