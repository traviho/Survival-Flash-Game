package {
	import flash.display.MovieClip;
	import flash.events.*;
	public class Lightning2 extends MovieClip {
		private var _root:*;
		private var damage:int;
		
		public function Lightning2(passedDamage:int) {
			damage = passedDamage;
			addEventListener(Event.ADDED,beginClass);//this will run every time this guy is made
			addEventListener(Event.ENTER_FRAME,eFrame);//this will run every frame
			addEventListener(Event.REMOVED_FROM_STAGE, destroyThis);
		}
		
		private function beginClass(e:Event):void {
			_root = MovieClip(root);
		}
		private function eFrame(e:Event):void {
			if (this.hit.hitTestObject(_root.player.hit)){
				dealDamage(0);
			}
			if (this.currentFrame == 10){
				destroyThis();
			}
		}
		private function dealDamage(whichHit:int):void{
			if (whichHit == 0){
				_root.inGamePlayerHealth -= this.damage;
			}
		}
		public function destroyThis(event:Event = null):void{
			this.removeEventListener(Event.ENTER_FRAME, eFrame);
			if (event == null && this.parent){
				this.parent.removeChild(this);
			}
		}
	}
}