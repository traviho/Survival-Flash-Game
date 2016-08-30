package  {
	import flash.display.MovieClip;
	import flash.events.*;
	public class Log extends MovieClip{
		private var _root:*;
		public var health:int = 8;
		public var speed:int = 0;
		public var isAttackReady:Boolean = false;
		public var reloadCount:int = -999;
		public var hasNoKnockback:Boolean = true;
		public var xRef:int;
		public var yRef:int;
		private var bar;
		private var droppedItem;
		private var ran:Boolean;
		private var rot:int;
		
		public function Log(passRot:int) {
			rot = passRot;
			addEventListener(Event.ADDED,beginClass);
			addEventListener(Event.ENTER_FRAME, eFrame);
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
					case 4:this.gotoAndStop("rot4");break;
					case 5:this.gotoAndStop("rot5");break;
					case 6:this.gotoAndStop("rot6");break;
					case 7:this.gotoAndStop("rot7");break;
					case 8:this.gotoAndStop("rot8");break;
					case 9:this.gotoAndStop("rot9");break;
					case 10:this.gotoAndStop("rot10");break;
					case 11:this.gotoAndStop("rot11");break;
				}
			}
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
				for (var j:int = 0;j < _root.randomNumbers(2,4);j++){
					droppedItem = new woodDrop();
					droppedItem.rotation = _root.randomNumbers(-179,180);
					droppedItem.x = x + _root.randomNumbers(-60,60);
					droppedItem.y = y + _root.randomNumbers(-40,40);
					_root.droppedItemsData.push(droppedItem);
					_root.SettingHolder.addChild(droppedItem);
				}
				this.parent.removeChild(this);
				_root.enemyData.splice(_root.enemyData.indexOf(this), 1);
				_root.hitObjectData.splice(_root.hitObjectData.indexOf(this), 1);
				for (var i:int = 0;i < _root.savedStageData[_root.settingTag].length-2;i++){
					if (_root.savedStageData[_root.settingTag][i] == 1009){
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
