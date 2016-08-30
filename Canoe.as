package  {
	import flash.display.MovieClip;
	import flash.events.*;
	public class Canoe extends MovieClip{
		
		private var _root:*;
		public var hasUse:Boolean = true;
		private var curSlot:int;
		private var ran:Boolean;
		public var thisTag:int;//means nothing, just so call method easy
		
		public function Canoe(passSlot:int) {
			curSlot = passSlot;
			addEventListener(Event.ADDED,beginClass);
			addEventListener(Event.ENTER_FRAME, eFrame);
			addEventListener(Event.REMOVED_FROM_STAGE, destroyThis);
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
			/*if (_root.StaticHolder.contains(this)){
				_root.createNewStructure(12, this.x, this.y, 0);
				_root.isInBoat = true;
				_root.StaticHolder.removeChild(this);*/
			_root.StaticHolder.setChildIndex(this, 0);
			_root.isInBoat = true;
		}
		private function destroyThis(event:Event = null):void{
			this.removeEventListener(Event.ENTER_FRAME, eFrame);
		}
	}
}