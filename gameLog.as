package  {
	import flash.display.MovieClip;
	import flash.events.*;
	import fl.motion.Color;
	import flash.geom.ColorTransform;
	public class gameLog extends MovieClip{
		private var _root:*;
		private var ran:Boolean;
		private var count:int;
		private var logIndex:int
		private var txtColor:int;
		private var dynamicColor:Color = new Color();
		
		public function gameLog(whichIndex:int, whichColor:int) {
			logIndex = whichIndex;
			addEventListener(Event.ADDED,beginClass);
			addEventListener(Event.ENTER_FRAME, eFrame);
			addEventListener(Event.REMOVED_FROM_STAGE, destroyThis);
		}
		private function beginClass(e:Event):void {
			if (!ran){
				ran = true;
				_root = MovieClip(root);//setting the root
				dynamicColor.alphaMultiplier = 1.0;
			}
		}
		private function eFrame(e:Event):void{
			if (_root.numMessages > logIndex){
				this.y -= 14;
				logIndex++;
			}
			if (count >= 96){
				dynamicColor.alphaMultiplier *= .9;
				this.transform.colorTransform = dynamicColor;
			}
			if (count >= 160){
				destroyThis();
			}
			count++;
		}
		private function destroyThis(event:Event = null):void{
			_root.numMessages--;
			this.removeEventListener(Event.ENTER_FRAME, eFrame);
		}

	}
	
}
