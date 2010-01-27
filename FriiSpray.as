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
	import brush.*;
	import colour.*;
	import com.adobe.images.*; //for saving images
	import flash.desktop.NativeApplication;
	import flash.display.*;
	import flash.events.*;
	import flash.filesystem.*; // for saving images
	import flash.geom.Rectangle;
	import flash.net.*;
	import flash.system.Capabilities;
	import flash.ui.Mouse;
	import flash.utils.ByteArray; // For saving
	import flash.utils.Timer;

import flash.text.TextField;

	/**
	 * The main FriiSpray control class.
	 *
	 * @see http://www.friispray.co.uk FriiSpray website
	 */
	public class FriiSpray extends MovieClip
	{
		private var m_activeBrush:Number;
		private var m_brushes:Array;

		public var toolbar:Toolbar;
		public var paper:MovieClip;
		public var savingDialogue:MovieClip;
		
		public var caligraphyCursor:MovieClip;
		public var caligraphyCursor2:MovieClip;
		public var normalCursor:MovieClip;
		
		public var txtError:TextField;
		
		// Image loading vars
		private var backgroundImageLoader:UserImageLoader;
		private var foregroundImageLoader:UserImageLoader;
		
		// Constants
		private const BRUSH_NORMAL:Number = 0;
		private const BRUSH_SPRAY:Number = 1;
		private const BRUSH_CALIGRAPHY:Number = 2;
		private const BRUSH_CALIGRAPHY2:Number = 3;
		
		private const WEB_SERVER_SAVE_SCRIPT = "http://www.aserver.co.uk/saveimage.aspx";
		
		/**
		 * Constructor
		 */
		public function FriiSpray()
		{
			// Connect events
			paper.addEventListener(MouseEvent.MOUSE_DOWN, onStartSpray);
			paper.addEventListener(MouseEvent.MOUSE_UP, onStopSpray);
			paper.addEventListener(MouseEvent.MOUSE_OVER, onOverPaper);

			toolbar.btnBrushNormal.addEventListener(MouseEvent.MOUSE_DOWN, onBrushPick);
			toolbar.btnBrushSpray.addEventListener(MouseEvent.MOUSE_DOWN, onBrushPick);
			toolbar.btnBrushCaligraphy.addEventListener(MouseEvent.MOUSE_DOWN, onBrushPick);
			toolbar.btnBrushCaligraphy2.addEventListener(MouseEvent.MOUSE_DOWN, onBrushPick);
			
			toolbar.btnClear.addEventListener(MouseEvent.MOUSE_DOWN, onClear);
			toolbar.btnMinus.addEventListener(MouseEvent.MOUSE_DOWN, onSmallerButton);
			toolbar.btnPlus.addEventListener(MouseEvent.MOUSE_DOWN, onBiggerButton);
			toolbar.btnSave.addEventListener(MouseEvent.MOUSE_DOWN, onSave);
			toolbar.colourPallete.addEventListener(ColourPickedEvent.COLOUR_PICKED, onColourChange);
			parent.addEventListener(KeyboardEvent.KEY_DOWN, onKeyCommand);
			
			// Set up dialogues
			savingDialogue.visible = false;
			
			// Set up brushes;
			m_brushes = new Array(4);
			m_brushes[BRUSH_NORMAL] = new NormalBrush(paper, normalCursor);
			m_brushes[BRUSH_SPRAY] = new SprayBrush(paper, normalCursor);
			m_brushes[BRUSH_CALIGRAPHY] = new CaligraphyBrush(paper, caligraphyCursor);
			m_brushes[BRUSH_CALIGRAPHY2] = new CaligraphyBrush2(paper, caligraphyCursor2);
			m_activeBrush = 0;
			m_brushes[m_activeBrush].PickUpBrush();
			
			// Set up image loaders
			backgroundImageLoader = new UserImageLoader(paper);
			foregroundImageLoader = new UserImageLoader(paper);
			
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			// Setup paper to match screen resolution
			stage.nativeWindow.width = Capabilities.screenResolutionX;
			stage.nativeWindow.height = Capabilities.screenResolutionY;

			// Clear canvas to set size (Resizes paper by drawing a big rectangle in it. (Setting width directly messes with scale))
			m_brushes[m_activeBrush].ClearCanvass();
			
			// Full screen the interface
			//stage.displayState = StageDisplayState.FULL_SCREEN;
		}

		
		// Events
		
		/**
		 * Event handler: The user has selected a brush.
		 *
		 * @param ev MouseEvent object containing event details.
		 */
		private function onBrushPick(ev:MouseEvent):void
		{
			// Drop old brush
			var tempPaperCache:Bitmap = m_brushes[m_activeBrush].DropBrush();
			
			// Get new brush
			switch(ev.target.name) {
				case "btnBrushSpray":
					m_activeBrush = BRUSH_SPRAY;
					break;
				case "btnBrushCaligraphy":
					m_activeBrush = BRUSH_CALIGRAPHY;
					break;
				case "btnBrushCaligraphy2":
					m_activeBrush = BRUSH_CALIGRAPHY2;
					break;
				default:
					m_activeBrush = BRUSH_NORMAL;
					break;
			}
			m_brushes[m_activeBrush].PickUpBrush(tempPaperCache);
		}
		
		/**
		 * Event handler: The user has pressed the clear button.
		 *
		 * @param ev MouseEvent object containing event details.
		 */
		private function onClear(ev:MouseEvent):void
		{
			m_brushes[m_activeBrush].ClearCanvass();
		}
		
		/**
		 * Event handler: The user has chosen a colour from the colour pallette.
		 *
		 * @param ev ColourPickedEvent object containing event details.
		 */
		private function onColourChange(ev:ColourPickedEvent):void
		{
			toolbar.colourPallete.UnselectAll();
			
			for (var i:Number = 0; i < m_brushes.length; i++)
			{
				m_brushes[i].Colour = ev.Colour;
			}
		}
		
		/**
		 * Event handler: Drives the drawing, is only active when the user has the input button pressed.
		 * Speed is dictated by Frame rate of 
		 *
		 * @param ev Event object containing event details.
		 */
		private function onMouseBrushMove(ev:MouseEvent):void
		{
			// Check the user still wants to draw
			if(ev.buttonDown)
			{
				m_brushes[m_activeBrush].Draw(paper.mouseX, paper.mouseY);
			}
			else
			{
				// Drawing should have stopped (User may have unclicked while off screen)
				onStopSpray(ev);
			}
			
			// Updates the screen if there has been a change
			// Allows low frame rate and smooth screen drawing
			ev.updateAfterEvent();
		}
		
		/**
		 * Event handler: The user has pressed a key.
		 * Esc key - Quits program.
		 * 0-9 keys - Change brush size.
		 *
		 * @param ev KeyboardEvent object containing event details.
		 */
		private function onKeyCommand(ev:KeyboardEvent):void
		{
			// Number keys change brush size
			if(ev.keyCode >= 48 && ev.keyCode <= 58)
			{
				var brushSize:Number = ((ev.keyCode - 48) * 5) + 1;
				
				for (var i:Number = 0; i < m_brushes.length; i++)
				{
					m_brushes[i].Size = brushSize;
				}
			}
			
			// Exit (ESC key)
			else if(ev.keyCode == 27)
			{
				NativeApplication.nativeApplication.exit();
			}
			
			// Ctrl Commands
			else if(ev.ctrlKey)
			{
				switch(ev.charCode)
				{
					// Background image open (Ctrl + o/O)
					case 79:
					case 111:
						backgroundImageLoader.UserChooseFile(m_brushes[m_activeBrush], m_brushes[m_activeBrush].PaintDepth);
						break;
						
					// Mask image open (Ctrl + m/M)
					case 77:
					case 109:
						foregroundImageLoader.UserChooseFile(m_brushes[m_activeBrush]);
						paintBelowMask();
						break;
				}
			}
		}
		
		/**
		 * Event handler: The mouse has passed over the drawing area of the screen.
		 *
		 * @param ev MouseEvent object containing event details.
		 */
		private function onOverPaper(ev:MouseEvent):void
		{
			Mouse.hide();
		}
		
		/**
		 * Event handler: The user has pressed the bigger brush button.
		 *
		 * @param ev MouseEvent object containing event details.
		 */
		private function onBiggerButton(ev:MouseEvent):void
		{
			for (var i:Number = 0; i < m_brushes.length; i++)
			{
				m_brushes[i].IncreaseSize();
			}
		}
		
		/**
		 * Event handler: The user has pressed the smaller mouse button.
		 *
		 * @param ev MouseEvent object containing event details.
		 */
		private function onSmallerButton(ev:MouseEvent):void
		{
			for (var i:Number = 0; i < m_brushes.length; i++)
			{
				m_brushes[i].DecreaseSize();
			}
		}
		
		/**
		 * Event handler: The user has pressed the save button.
		 *
		 * @param ev MouseEvent object containing event details.
		 */
		private function onSave(ev:MouseEvent):void
		{
			savingDialogue.visible = true;
			save();
			
			var savingTimer:Timer = new Timer(1000, 1);
            savingTimer.addEventListener("timer", onSaveDone);
            savingTimer.start()
		}
		
		/**
		 * Timer Event handler: Save is too quick to see the saving message.
		 *
		 * @param ev TimerEvent object containing event details.
		 */
		private function onSaveDone(ev:TimerEvent):void
		{
			savingDialogue.visible = false;
			//ev.target.stop();
		}
		
		/**
		 * Event handler: The user has started spraying.
		 *
		 * @param ev MouseEvent object containing event details.
		 */
		private function onStartSpray(ev:MouseEvent):void
		{
			Mouse.hide();
			m_brushes[m_activeBrush].Begin(paper.mouseX, paper.mouseY);
			addEventListener(MouseEvent.MOUSE_MOVE, onMouseBrushMove);
		}
		
		/**
		 * Event handler: The user has stopped spraying.
		 *
		 * @param ev MouseEvent object containing event details.
		 */
		private function onStopSpray(ev:MouseEvent):void
		{
			removeEventListener(MouseEvent.MOUSE_MOVE, onMouseBrushMove);
		}
		
		// ** Useful functions **
		
		private function paintBelowMask()
		{
			for each (var aBrush:Brush in m_brushes)
			{
    			aBrush.PaintDepth = 2;
			}
		}
		
		/**
		 * Save the current drawn image as a PNG in the users documents directory.
		 * The filename is automatically generated.
		 */
		private function save():void
		{
			var bitmapData:BitmapData = new BitmapData(Capabilities.screenResolutionX, Capabilities.screenResolutionY);
			bitmapData.draw(paper);
			
			// use adobe’s encoder to create a byteArray
			trace('Starting encoding');
			var byteArray:ByteArray = PNGEncoder.encode(bitmapData);
			trace('Finished encoding');
			
			// set a filename
			var fileName:String = "FriiConstruct"
			var fileNumber:Number = 0;
			var fileExtension:String = ".png";
			
			// get current path
			var file:File;
			
			do
			{
				file = File.documentsDirectory.resolvePath( fileName + fileNumber + fileExtension );
				fileNumber++;
			}
			while (file.exists && fileNumber < 1000000);
			
			// get the native path
			var wr:File = new File( file.nativePath );
			
			// create filestream
			var stream:FileStream = new FileStream();
			
			//  open/create the file, set the filemode to write in order to save.
			stream.open( wr , FileMode.WRITE);

			// write your byteArray into the file.
			stream.writeBytes ( byteArray, 0, byteArray.length );

			// close the file.
			stream.close();
			
			//Uncomment to send to a web
			//need to set this constant WEB_SERVER_SAVE_SCRIPT
			//sendToWeb(byteArray, fileName + fileNumber);
		}
		
		/**
		 * Sends image to a web server to save it and perhaps put it on a website
		 */
		private function sendToWeb(byteArray, imageTitle:String)
		{
			var queryString = "?tags=FriiSpray&title=" +imageTitle;
			
			// Choose sending method and attach the data
			var sendToScript:URLRequest = new URLRequest(WEB_SERVER_SAVE_SCRIPT + queryString);
			sendToScript.method = URLRequestMethod.POST;
			sendToScript.data = byteArray;
			
			// Actually send the info to the server.
			var sendLoader = new URLLoader();

			//sendLoader.addEventListener(IOErrorEvent.IO_ERROR, onSendError);
            //sendLoader.addEventListener(Event.COMPLETE, onSendSent);
			sendLoader.load(sendToScript);
		}
	}
}