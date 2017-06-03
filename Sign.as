package  {
	import flash.display.MovieClip;
	import flash.events.*;
	public class Sign extends MovieClip{
		private var _root:*;
		public var speed:int = 0;
		public var isAttackReady:Boolean = false;
		public var hasNoKnockback:Boolean = true;
		public var xRef:int;
		public var yRef:int;
		private var ran:Boolean;
		private var rot:int;
		
		public function Sign(passRot:int) {
			rot = passRot;
			addEventListener(Event.ADDED,beginClass);
			addEventListener(Event.REMOVED_FROM_STAGE, destroyThis);
		}
		private function beginClass(e:Event):void {
			if (!ran){
				ran = true;
				_root = MovieClip(root);//setting the root
				switch (rot){
					case 1:this.gotoAndStop("rot1");break;
					case 2:this.gotoAndStop("rot2");break;
					case 3:this.gotoAndStop("rot3");break;
				}
			}
		}

		private function destroyThis(event:Event = null):void{
			if (event == null){
				this.parent.removeChild(this);
				_root.hitObjectData.splice(_root.hitObjectData.indexOf(this), 1);
				for (var i:int = 0;i < _root.savedStageData[_root.settingTag].length-2;i++){
					if (_root.savedStageData[_root.settingTag][i] == 1012){
						if (_root.savedStageData[_root.settingTag][i+1] == xRef){
							if (_root.savedStageData[_root.settingTag][i+2] == yRef){
								_root.savedStageData[_root.settingTag].splice(i,3)
							}
						}
					}
				}
			}
		}

	}
	
}
