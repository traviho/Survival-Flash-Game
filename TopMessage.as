package  {
	import flash.display.MovieClip;
	import flash.events.*;
	public class TopMessage extends MovieClip{
		private var _root:*;
		private var ran:Boolean = false;
		private var count:int = 0;
		private var curMessage:String = "";
		
		public function TopMessage() {
			addEventListener(Event.ADDED,beginClass);
			this.click.addEventListener(MouseEvent.MOUSE_UP, riseFall);
			fallDown();
		}
		private function beginClass(e:Event):void { //the problem was that this code was running twice
			if (!ran){
				ran = true;
				_root = MovieClip(root);
			}
		}
		public function makeMessage(newMsg:String):void{
			curMessage = newMsg;
			this.messageTxt.text = newMsg;
		}
		public function riseUp():void{
			this.gotoAndPlay("rise");
		}
		public function fallDown():void{
			this.gotoAndPlay("fall");
		}
		private function riseFall(event:MouseEvent){
			if (this.currentFrame == 1 || this.currentFrame == 13){
				this.gotoAndPlay("fall");
			} else if (this.currentFrame == 7){
				this.gotoAndPlay("rise");
			}
			this.messageTxt.text = curMessage;
		}

	}
	
}
