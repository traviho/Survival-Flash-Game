package  {
	import flash.display.MovieClip;
	import flash.events.*;
	public class dropDown2 extends MovieClip{
		private var _root:*;
		private var whichWallRef:int;
		public function dropDown2(passedWall:int) {
			addEventListener(Event.ADDED,beginClass);
			this.b1.addEventListener(MouseEvent.MOUSE_UP, repairWall);
			this.b2.addEventListener(MouseEvent.MOUSE_UP, upgradeWall);
			this.b3.addEventListener(MouseEvent.MOUSE_UP, xOut);
			//this.b4.addEventListener(MouseEvent.MOUSE_UP, destroyThis);
		}
		private function beginClass(e:Event):void {
			_root = MovieClip(root);//setting the root
		}
		private function repairWall(Event:MouseEvent):void{
			//_root.wallAndTowerObjectData[whichWallRef].doRepair(false);
			xOut();
		}
		private function upgradeWall(Event:MouseEvent):void{
			trace("open upgrade");
			xOut();
		}
		private function xOut(Event:MouseEvent = null):void{
			this.parent.removeChild(this);
		}
		
	}
	
}
