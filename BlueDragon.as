package  {
	import flash.display.MovieClip;
	import flash.events.*;
	public class BlueDragon extends MovieClip{
		private var _root:*;
		public var speed:Number = 7;
		private var pushBack:int = 3;
		public var health:int = 80;
		private var lightningDamage:int = 3;
		private var damage:int = 5;
		public var reloadTime:int = 48;//2 secs
		private var noticeRadius:int = 600;
		private var knockBack:int = 1;
		private var stunTime:int = 12;
		private var attackCycle:int = 2;
		private var count:int = 1;
		
		public var isAttackReady:Boolean = true;
		public var reloadCount:int;
		private var dy:int;
		private var dx:int;
		private var ySpeed:Number;
		private var xSpeed:Number;
		private var droppedItem;
		private var newBolt;
		public var xRef:int;
		public var yRef:int;
		private var angle:int;
		public var isNightEnemy:Boolean;
		private var bar;
		public var materialHit:Boolean = false;
		public var hasNoKnockback:Boolean = true;
		private var isTouchingPlayer:Boolean;
		
		public function BlueDragon() {
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
				if (attackCycle == 1){
					ySpeed = Math.sin(angle) * speed;
					xSpeed = Math.cos(angle) * speed;
					this.x+= xSpeed;
					this.y+= ySpeed;
				}
				if (isAttackReady){
					if (attackCycle == 1){
						newBolt = new Lightning(lightningDamage);
					} else {
						newBolt = new Lightning2(lightningDamage);
					}
					newBolt.x = this.x;
					newBolt.y = this.y;
					newBolt.rotation = this.rotation + 180;
					_root.ObjectHolder.addChild(newBolt);
					isAttackReady = false;
					reloadCount = 0;
					reloadTime = _root.randomNumbers(20,40);//randomizing when it shoots a bit
				}
			}
			if (attackCycle == 2 && reloadCount <= reloadTime-12 && (Math.sqrt(Math.pow(dy,2) + Math.pow(dx,2)) <= noticeRadius * .4)){
				this.rotation = -90 + angle * 180 / Math.PI;
				ySpeed = Math.sin(angle + Math.PI) * speed;
				xSpeed = Math.cos(angle + Math.PI) * speed;
				this.x+= xSpeed;
				this.y+= ySpeed;
			}
			if (!isTouchingPlayer){
				speed = 5;
			}
			if (this.jumpHit.hitTestObject(_root.player.hit)){
				isTouchingPlayer = true;
				speed = 0;
				if (count % 50 == 0){
					this.gotoAndPlay("jumpAttack");
					_root.inGamePlayerHealth -= this.damage;
				}
			} else {
				isTouchingPlayer = false;
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
			if (count % 120 == 0){
				attackCycle = _root.randomNumbers(1,2);
			}
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
			bar.healthSize.width = 158 * (health/80);
			noticeRadius = 800;
		}
		private function destroyThis(event:Event = null):void{
			//_root.enemyData.splice(_root.enemyList.indexOf(this), 1);
			if (event == null){
				_root.createMessage("Blue Dragon killed");
				if (bar){
				bar.parent.removeChild(bar);
				}
			for (var j:int = 0;j < _root.randomNumbers(2,4);j++){
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
					if (_root.savedStageData[_root.settingTag][i] == 2004){
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
