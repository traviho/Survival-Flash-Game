package  {
	import flash.display.MovieClip;
	import flash.events.*;
	public class tropicalTree extends MovieClip{
		private var _root:*;
		public var health:int = 8;
		public var isAttackReady:Boolean = false;
		public var reloadCount:int = -999;
		public var hasNoKnockback:Boolean = true;
		public var xRef:int;
		public var yRef:int;
		private var bar;
		private var droppedItem;
		
		public function tropicalTree() {
			addEventListener(Event.ADDED,beginClass);
			addEventListener(Event.ENTER_FRAME, eFrame);
			addEventListener(Event.REMOVED_FROM_STAGE, destroyThis);
		}
		private function beginClass(e:Event):void {
			_root = MovieClip(root);//setting the root
		}
		private function eFrame(e:Event):void{
			if (bar){
				bar.x = this.x - 18;
				bar.y = this.y + 40;
			}
			if (this.health <= 0){
				destroyThis();
			}
		}
		public function takeDamage(theDamage:int):void{
		}
		public function takeMaterialDamage(theDamage:int, theType:int):void{
			if (theType == 10002){
				if (!bar){
					bar = new hpBar();
					bar.width = 36;
					bar.height = 5;
					bar.x = this.x - 18;
					bar.y = this.y + 20;
					_root.ObjectHolder.addChild(bar);
				}
				this.health -= theDamage;
				bar.healthSize.width = 158 * (health/8);
			}
		}
		private function destroyThis(event:Event = null):void{
			//_root.enemyData.splice(_root.enemyList.indexOf(this), 1);
			if (event == null){
				_root.createMessage("wood chopped");
				bar.parent.removeChild(bar);
			//if (_root.randomNumbers(1,5) == 5){
				droppedItem = new woodDrop();
				droppedItem.x = x;
				droppedItem.y = y;
				_root.droppedItemsData.push(droppedItem);
				_root.SettingHolder.addChild(droppedItem);
			//}
				this.parent.removeChild(this);
				_root.enemyData.splice(_root.enemyData.indexOf(this), 1);
				_root.hitObjectData.splice(_root.hitObjectData.indexOf(this), 1);
				//_root.ObjectHolder.removeChild(this);
				for (var i:int = 0;i < _root.savedStageData[_root.settingTag].length-2;i++){
					if (_root.savedStageData[_root.settingTag][i] == 10002){
						if (_root.savedStageData[_root.settingTag][i+1] == xRef){
							if (_root.savedStageData[_root.settingTag][i+2] == yRef){
								_root.savedStageData[_root.settingTag].splice(i,3)
							}
						}
					}
				}
			}
			this.removeEventListener(Event.ENTER_FRAME, eFrame);
		}

	}
	
}
