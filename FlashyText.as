package  {
	import flash.display.MovieClip;
	import flash.events.*;
	import fl.motion.Color;
	import flash.geom.ColorTransform;
	public class FlashyText extends MovieClip{
		private var _root:*;
		private var ran:Boolean;
		private var count:int;
		private var txtColor:int;
		private var dynamicColor:Color = new Color();
		
		public function FlashyText(passMsg:String, whichColor:int) {
			addEventListener(Event.ADDED,beginClass);
			addEventListener(Event.ENTER_FRAME, eFrame);
			addEventListener(Event.REMOVED_FROM_STAGE, destroyThis);
			if (whichColor == 1){
				this.redText.text = passMsg;
			} else if (whichColor == 2){
				this.greenText.text = passMsg;
			}
		}
		private function beginClass(e:Event):void {
			if (!ran){
				ran = true;
				_root = MovieClip(root);//setting the root
				dynamicColor.alphaMultiplier = 1.0;
			}
		}
		private function eFrame(e:Event):void{
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
			this.removeEventListener(Event.ENTER_FRAME, eFrame);
		}

	}
	
}
