﻿package  {
	import flash.display.MovieClip;
	import flash.events.*;
	public class ironBoulder extends MovieClip{
		private var _root:*;
		public var health:int = 30;
		public var isAttackReady:Boolean = false;
		public var reloadCount:int = -999;
		public var hasNoKnockback:Boolean = true;
		public var xRef:int;
		public var yRef:int;
		private var bar;
		private var droppedItem;
		
		public function ironBoulder() {
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
			if (theType == 1003){
				if (!bar){
					bar = new hpBar();
					bar.width = 36;
					bar.height = 5;
					bar.x = this.x - 18;
					bar.y = this.y + 20;
					_root.ObjectHolder.addChild(bar);
				}
				this.health -= theDamage;
				bar.healthSize.width = 158 * (health/30);
			}
		}
		private function destroyThis(event:Event = null):void{
			//_root.enemyData.splice(_root.enemyList.indexOf(this), 1);
			if (event == null){
				_root.createMessage("iron stone mined");
				bar.parent.removeChild(bar);
				for (var j:int = 0;j < _root.randomNumbers(1,3);j++){
					droppedItem = new ironDrop();
					droppedItem.rotation = _root.randomNumbers(-179,180);
					droppedItem.x = x + _root.randomNumbers(-50,50);
					droppedItem.y = y + _root.randomNumbers(-50,50);
					_root.droppedItemsData.push(droppedItem);
					_root.SettingHolder.addChild(droppedItem);
				}
				this.parent.removeChild(this);
				_root.enemyData.splice(_root.enemyData.indexOf(this), 1);
				_root.hitObjectData.splice(_root.hitObjectData.indexOf(this), 1);
				//_root.ObjectHolder.removeChild(this);
				for (var i:int = 0;i < _root.savedStageData[_root.settingTag].length-2;i++){
					if (_root.savedStageData[_root.settingTag][i] == 1005){
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
