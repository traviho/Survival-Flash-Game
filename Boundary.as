package  {
	import flash.display.MovieClip;
	import flash.events.*;
	public class Boundary extends MovieClip{
		private var _root:*;
		public var xRef:int;
		public var yRef:int;
		private var ran:Boolean;
		private var whichBound:int;
		public var canPass:Boolean;
		private var boundType:int;
		
		public function Boundary(passBound:int) {
			whichBound = passBound;
			addEventListener(Event.ADDED,beginClass);
			addEventListener(Event.ENTER_FRAME, eFrame);
			addEventListener(Event.REMOVED_FROM_STAGE, destroyThis);
		}
		private function beginClass(e:Event):void {
			if (!ran){
				ran = true;
				_root = MovieClip(root);
				if (whichBound == 1){
					this.hit1.width = 800;
					this.hit1.height = 50;
					this.hit1.x = 0;
					this.hit1.y = 0;
				} else if (whichBound == 2){
					this.hit2.width = 50;
					this.hit2.height = 575;
					this.hit2.x = 0;
					this.hit2.y = 0;
				} else if (whichBound == 3){
					this.hit3.width = 800;
					this.hit3.height = 50;
					this.hit3.x = 0;
					this.hit3.y = 0;
				} else if (whichBound == 4){
					this.hit4.width = 50;
					this.hit4.height = 575;
					this.hit4.x = 0;
					this.hit4.y = 0;
				}
			}
		}
		private function eFrame(e:Event):void{
			if (_root.isInBoat){
				canPass = true;
			} else {
				canPass = false;
			}
			if (!canPass){
				if (whichBound == 1){
					if (_root.player.hit.hitTestObject(this.hit1)){
						_root.player.y -= _root.player.speed;
					}
				} else if (whichBound == 2){
					if (_root.player.hit.hitTestObject(this.hit2)){
						_root.player.x += _root.player.speed;
					}
				} else if (whichBound == 3){
					if (_root.player.hit.hitTestObject(this.hit3)){
						_root.player.y += _root.player.speed;
					}
				} else if (whichBound == 4){
					if (_root.player.hit.hitTestObject(this.hit4)){
						_root.player.x -= _root.player.speed;
					}
				}
			}
		}
		private function destroyThis(event:Event = null):void{
			this.removeEventListener(Event.ENTER_FRAME, eFrame);
		}


	}
	
}
