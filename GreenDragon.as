package  {
	import flash.display.MovieClip;
	import flash.events.*;
	public class GreenDragon extends MovieClip{
		private var _root:*;
		public var speed:Number = 4;
		private var pushBack:int = 3;
		public var health:int = 30;
		private var fireDamage:Number = 1;
		private var damage:int = 5;
		public var reloadTime:int = 24;
		private var noticeRadius:int = 300;
		private var knockBack:int = 1;
		private var stunTime:int = 12;
		private var count:int = 1;
		
		public var isAttackReady:Boolean = true;
		public var reloadCount:int;
		private var dy:int;
		private var dx:int;
		private var ySpeed:Number;
		private var xSpeed:Number;
		private var droppedItem;
		public var xRef:int;
		public var yRef:int;
		private var angle:int;
		public var isNightEnemy:Boolean;
		private var bar;
		public var materialHit:Boolean = false;
		public var hasNoKnockback:Boolean = true;
		private var isTouchingPlayer:Boolean;
		
		public function GreenDragon() {
			addEventListener(Event.ADDED,beginClass);
			addEventListener(Event.ENTER_FRAME, eFrame);
			addEventListener(Event.REMOVED_FROM_STAGE, destroyThis);
		}
		private function beginClass(e:Event):void {
			_root = MovieClip(root);//setting the root
			if (isNightEnemy){
				noticeRadius = 300;
			}
		}
		private function eFrame(e:Event):void{
			dy = _root.player.y - y
			dx = _root.player.x - x
			if (Math.sqrt(Math.pow(dy,2) + Math.pow(dx,2)) <= noticeRadius){
				this.rotation = 90 + Math.atan2(dy, dx) * 180 / Math.PI;
				angle = Math.atan2(dy, dx);//is this way because angle is radians, but want rotation degrees
				ySpeed = Math.sin(angle) * speed;
				xSpeed = Math.cos(angle) * speed;
				this.x+= xSpeed;
				this.y+= ySpeed;
				if (isAttackReady){
					var newFire:Fireball = new Fireball(fireDamage);
					newFire.x = this.x;
					newFire.y = this.y;
					newFire.rotation = this.rotation;
					_root.ObjectHolder.addChild(newFire);
					isAttackReady = false;
					reloadCount = 0;
					reloadTime = _root.randomNumbers(8,40);//randomizing when it shoots a bit
				}
			}
			if (this.jumpHit.hitTestObject(_root.player.hit)){
				isTouchingPlayer = true;
				speed = 0;
				if (count % 24 == 0){
					reloadTime = 8;
				}
			} else {
				isTouchingPlayer = false;
				speed = 4;
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
				bar.y = this.y + 60;
			}
			if (this.health <= 0){
				destroyThis();
			}
			/*if (count % 24 == 0){
				var determinant:int = _root.randomNumbers(1,2);
				trace(determinant);
				if (determinant == 1){
					speed = 0;
				} else {
					speed = 4;
				}
			}*/
			count++;
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
			bar.healthSize.width = 158 * (health/30);
			noticeRadius = 800;
		}
		private function destroyThis(event:Event = null):void{
			//_root.enemyData.splice(_root.enemyList.indexOf(this), 1);
			if (event == null){
				_root.createMessage("Green Dragon killed");
				if (bar){
				bar.parent.removeChild(bar);
				}
			for (var j:int = 0;j < _root.randomNumbers(0,3);j++){
					droppedItem = new scaleDrop();
					droppedItem.rotation = _root.randomNumbers(-179,180);
					droppedItem.x = x + _root.randomNumbers(-50,50);
					droppedItem.y = y + _root.randomNumbers(-50,50);
					_root.droppedItemsData.push(droppedItem);
					_root.SettingHolder.addChild(droppedItem);
				}
				this.parent.removeChild(this);
				_root.enemyData.splice(_root.enemyData.indexOf(this), 1);
				//_root.ObjectHolder.removeChild(this);
				for (var i:int = 0;i < _root.savedStageData[_root.settingTag].length-2;i++){
					if (_root.savedStageData[_root.settingTag][i] == 2003){
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
