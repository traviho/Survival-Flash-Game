package  {
	import flash.display.MovieClip;
	import flash.events.*;
	
	public class Exit extends MovieClip{
		private var _root:*;
		private var ran:Boolean;
		private var whichExit:int;
		public var xRef:int;
		public var yRef:int;
		
		public function Exit(passWhich:int) {
			whichExit = passWhich;
			addEventListener(Event.ADDED, beginClass);
		}
		
		private function beginClass(e:Event):void {
			if (!ran){
			ran = true;
			_root = MovieClip(root);
				if (whichExit == 2 || whichExit == 4){
					this.rotation = 90;
				}
			}
		}
		public function moveStages(){
			if (whichExit == 1){
				_root.goUp = true;
				_root.newStage();
			} else if (whichExit == 2){
				_root.goRight = true;
				_root.newStage();
			} else if (whichExit == 3){
				_root.goDown = true;
				_root.newStage();
			} else if (whichExit == 4){
				_root.goLeft = true;
				_root.newStage();
			}
		}
	}
	
}
