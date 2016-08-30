package  {
	import flash.display.MovieClip;
	import flash.events.*;
	public class dropDown extends MovieClip{
		private var _root:*;
		private var ran:Boolean;
		
		public function dropDown() {
			/*addEventListener(Event.ADDED,beginClass);
			addEventListener(Event.REMOVED_FROM_STAGE, destroyThis);
			this.b1.addEventListener(MouseEvent.MOUSE_UP, doMove);
			this.b3.addEventListener(MouseEvent.MOUSE_UP, destroyParent);
			this.b4.addEventListener(MouseEvent.MOUSE_UP, destroyThis);*/
		}
		/*private function beginClass(e:Event):void {
			if (!ran){
				ran = true;
				_root = MovieClip(root);//setting the root
				trace(this.parent);
			}
		}
		private function doMove(Event:MouseEvent){
			if (this.parent is Mill){
				this.parent.isMove = true;
			}
		}
		private function destroyParent(Event:MouseEvent){
			if (this.parent is Mill){
				this.parent.destroyThis();
			}
		}
		private function destroyThis(event:Event = null):void{
			if (event == null || event == MouseEvent.MOUSE_UP){
				if (this.parent.contains(this)){
					this.parent.removeChild(this);
				}
			}
		}*/


	}
	
}
