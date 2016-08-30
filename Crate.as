package  {
	import flash.display.MovieClip;
	import flash.events.*;
	public class Crate extends MovieClip{
		private var _root:*;
		private var dy:int;
		private var dx:int;
		public var xRef:int;
		public var yRef:int;
		public var isMove:Boolean;
		private var popUp;
		public function Crate() {
			/*addEventListener(Event.ADDED,beginClass);
			addEventListener(Event.ENTER_FRAME, eFrame);
			addEventListener(Event.REMOVED_FROM_STAGE, destroyThis);*/
			addEventListener(Event.ADDED,beginClass);
			addEventListener(Event.ENTER_FRAME, eFrame);
			//this.clickBox.addEventListener(MouseEvent.MOUSE_UP, whenClicked);
			addEventListener(MouseEvent.MOUSE_UP, theClick);
			addEventListener(Event.REMOVED_FROM_STAGE, destroyThis);
		}
		private function beginClass(e:Event):void {
			_root = MovieClip(root);//setting the root
			//_root.MenuHolder.addChild(this.clickBox);
		}
			
		private function eFrame(e:Event):void{
			
		}
		public function theClick(Event:MouseEvent):void{
			popUp = new dropDown();
			popUp.x = this.x + 25;
			popUp.y = this.y + 55;
			if (this.y >= 500)
			popUp.y -= 60;
			_root.ObjectHolder.addChild(popUp);
		}
		private function destroyThis(event:Event = null):void{
			this.removeEventListener(Event.ENTER_FRAME, eFrame);
		}


	}
	
}
