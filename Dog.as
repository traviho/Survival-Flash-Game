package  {
	import flash.display.MovieClip;
	import flash.events.*;
	public class Dog extends MovieClip{
		private var _root:*;
		public var speed;
		private var pushBack:int = 3;
		public var stopRadius:int = 15;
		
		public function Dog() {
			addEventListener(Event.ADDED,beginClass);
			addEventListener(Event.ENTER_FRAME, eFrame);
			addEventListener(Event.REMOVED_FROM_STAGE, destroyThis);
		}
		private function beginClass(e:Event):void {
			_root = MovieClip(root);//setting the root
		}
		private function eFrame(e:Event):void{
			speed = _root.player.speed;
			var dy:Number = _root.player.y - y
			var dx:Number = _root.player.x - x
			
			/*if (Math.abs(dy) <= stopRadius || Math.abs(dx) <= stopRadius){
				speed = 0;
			} else {*/
			if (!(Math.abs(dy) <= stopRadius || Math.abs(dx) <= stopRadius)){
				if (dx > 0){
				this.x += dx - stopRadius;
				} else if (dx < 0){
				this.x += dx + stopRadius;
				}
				if (dy > 0){
				this.y += dy - stopRadius;
				} else if (dy < 0){
				this.y += dy + stopRadius;
				}
			}
			
			/*if (this.hitTestObject(_root.player.hit)){
				this.y += pushBack;
				this.x += pushBack;
				//_root.player.x += Math.cos(angle) * pushBack;
			}*/
		}
		private function destroyThis(event:Event = null):void{
			this.removeEventListener(Event.ENTER_FRAME, eFrame);
		}

	}
	
}
