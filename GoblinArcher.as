package  {
	import flash.display.MovieClip;
	import flash.events.*;
	public class GoblinArcher extends MovieClip{
		private var _root:*;
		public var speed:int = 2;
		private var shotSpeed:int = 15;
		private var pushBack:int = 3;
		public var health:int = 5;
		private var damage:int = 2;
		private var noticeRadius:int = 500;
		private var runAwayRadius:int = 80;
		private var knockBack:int = 8;
		public var reloadTime:int = 72;
		public var reloadCount:int;
		public var isAttackReady:Boolean = true;
		public var isNightEnemy:Boolean;
		private var stunTime:int = 0;
		
		private var dy:int;
		private var dx:int;
		private var angle:Number;
		private var droppedItem:itemBow;
		public var xRef:int;
		public var yRef:int;
		private var bar;
		public var materialHit:Boolean = false;
		public var hasNoKnockback:Boolean = false;
		
		public function GoblinArcher() {
			addEventListener(Event.ADDED,beginClass);
			addEventListener(Event.ENTER_FRAME, eFrame);
			addEventListener(Event.REMOVED_FROM_STAGE, destroyThis);
		}
		private function beginClass(e:Event):void {
			_root = MovieClip(root);//setting the root
		}
		private function eFrame(e:Event):void{
			dy = _root.player.y - y
			dx = _root.player.x - x
			
			if (Math.sqrt(Math.pow(dy,2) + Math.pow(dx,2)) <= noticeRadius){
				this.rotation = 90 + Math.atan2(dy, dx) * 180 / Math.PI;
				angle = Math.atan2(dy, dx);//is this way because angle is radians, but want rotation degrees
				if (isAttackReady){
					var newArrow:Arrow = new Arrow(damage, shotSpeed, knockBack, false);
					newArrow.x = this.x;
					newArrow.y = this.y;
					newArrow.rotation = this.rotation;
					_root.ObjectHolder.addChild(newArrow);
					isAttackReady = false;
					reloadCount = 0;
					reloadTime = _root.randomNumbers(60,90);//randomizing when it shoots a bit
				}
			}
			if (reloadCount <= reloadTime-12 && (Math.sqrt(Math.pow(dy,2) + Math.pow(dx,2)) <= runAwayRadius)){
				this.rotation = -90 + angle * 180 / Math.PI;
				var ySpeed:Number = Math.sin(angle + Math.PI) * speed;
				var xSpeed:Number = Math.cos(angle + Math.PI) * speed;
				this.x+= xSpeed;
				this.y+= ySpeed;
			}
			if (!isAttackReady){
				reloadCount++;
				if (reloadCount >= reloadTime){
					isAttackReady = true;
				}
			}
			if (this.hit.hitTestObject(_root.player.hit)){
				_root.player.y += Math.sin(angle) * pushBack;
				_root.player.x += Math.cos(angle) * pushBack;
			}
			if (bar){
				bar.x = this.x - 18;
				bar.y = this.y + 20;
			}
			if (this.health <= 0){
				destroyThis();
			}
		}
		public function takeDamage(theDamage:int):void{
			if (!bar){
				bar = new hpBar();
				bar.width = 36;
				bar.height = 5;
				bar.x = this.x - 18;
				bar.y = this.y + 20;
				_root.ObjectHolder.addChild(bar);
			}
			if (reloadCount > stunTime){
				reloadCount -= stunTime;
			}
			this.health -= theDamage;
			bar.healthSize.width = 158 * (health/5);
		}
		private function destroyThis(event:Event = null):void{
			if (event == null){
				_root.createMessage("goblin archer killed");
				if (bar){
				bar.parent.removeChild(bar);
				}
			if (_root.randomNumbers(1,5) == 5){
				trace("drop");
				droppedItem = new itemBow();
				droppedItem.x = x;
				droppedItem.y = y;
				droppedItem.width = 20;
				droppedItem.height = 20;
				_root.droppedItemsData.push(droppedItem);
				_root.SettingHolder.addChild(droppedItem);
			}
				this.parent.removeChild(this);
				_root.enemyData.splice(_root.enemyData.indexOf(this), 1);
				for (var i:int = 0;i < _root.savedStageData[_root.settingTag].length-2;i++){
					if (_root.savedStageData[_root.settingTag][i] == 2001){
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
