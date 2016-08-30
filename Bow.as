package  {
	import flash.display.MovieClip;
	import flash.events.*;
	public class Bow extends MovieClip{
		
		private var _root:*;
		public var hasUse:Boolean = true;
		private var reloadTime:int = 24;
		private var damage:int = 5;
		private var speed:int = 20;
		private var knockBack:int = 10;
		private var curSlot:int;
		private var ran:Boolean;
		
		public function Bow(passSlot:int) {
			curSlot = passSlot;
			addEventListener(Event.ADDED,beginClass);
			addEventListener(Event.ENTER_FRAME, eFrame);
		}
		private function beginClass(e:Event):void {
			if (!ran){
				ran = true;
				_root = MovieClip(root);
			}
		}
		private function eFrame(e:Event):void{
			this.x = _root.player.x;
			this.y = _root.player.y;
			this.rotation = _root.player.rotation;
		}
		public function useItem(){
			if (_root.isLongRangeAttackReady){
			_root.longRangeLoadCount = reloadTime;
			_root.isLongRangeAttackReady = false;
			this.gotoAndPlay("bowShot");
			var newArrow:Arrow = new Arrow(damage, speed, knockBack, true);
			newArrow.x = this.x;
			newArrow.y = this.y;
			newArrow.rotation = this.rotation;
			_root.ObjectHolder.addChild(newArrow);
			}
		}
		
	}
}