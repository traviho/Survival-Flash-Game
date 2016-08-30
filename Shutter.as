package  {
	import flash.display.MovieClip;
	import flash.events.*;
	import fl.motion.Color;
	import flash.geom.ColorTransform;
	public class Shutter extends MovieClip{
		//private var _root:*;
		private var supposedColor:Color = new Color();
		public var lighting:Number = 0;
		private var dynamicColor:Color = new Color();
		private var count:int = 0;
		public var doShutter:Boolean;
		public function Shutter(){
			addEventListener(Event.ENTER_FRAME, loop);
			dynamicColor.alphaMultiplier = 1.0;
		}
		private function loop(e:Event):void{
			supposedColor.alphaMultiplier = lighting;
			if (doShutter){
				dynamicColor.alphaMultiplier *= .8;
				this.transform.colorTransform = dynamicColor;
				if (dynamicColor.alphaMultiplier <= supposedColor.alphaMultiplier + 0.1){ //do +.1 so that it doesnt that too long to get to OG lighting
					doShutter = false;
					dynamicColor.alphaMultiplier = 1.0
					supposedColor.alphaMultiplier = lighting;
				}
			} else {
				this.transform.colorTransform = supposedColor;
			}
		}
	}
	
}
