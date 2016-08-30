package  {
	import flash.display.MovieClip;
	import flash.events.*;
	public class Spider extends MovieClip{
		private var _root:*;
		public var speed:Number = 2.3;
		private var pushBack:int = 3;
		public var health:int = 20;
		private var staticHealth:int = 20;
		private var damage:int = 1;
		public var reloadTime:int = 48;//2 secs
		private var noticeRadius:int = 150;
		private var knockBack:int = 1;
		private var stunTime:int = 24;
		private var walkCount:int = 0;
		private var doWalk:Boolean;
		
		public var isAttackReady:Boolean = true;
		public var reloadCount:int;
		private var dy:int;
		private var dx:int;
		private var angle:Number;
		private var xSpeed:Number;
		private var ySpeed:Number;
		private var droppedItem;
		public var xRef:int;
		public var yRef:int;
		public var isNightEnemy:Boolean;
		private var bar;
		public var materialHit:Boolean = false;
		public var hasNoKnockback:Boolean = false;
		
		public function Spider() {
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
				angle = Math.atan2(dy, dx);//the angle that it must move
				ySpeed = Math.sin(angle) * speed;//calculate how much it should move the enemy vertically
				xSpeed = Math.cos(angle) * speed;//calculate how much it should move the enemy horizontally
				this.x+= xSpeed;
				this.y+= ySpeed;
			} else {
				if (_root.randomNumbers(1,50) == 1 || doWalk){
					if (!doWalk){
						doWalk = true;
						angle = _root.randomNumbers(-179,180);
						this.rotation = angle;
					}
					if (walkCount >= 8){
						doWalk = false;
						walkCount = 0;
					}
					ySpeed = Math.sin(angle * .01745 - 90) * 3;//calculate how much it should move the enemy vertically
					xSpeed = Math.cos(angle * .01745 - 90) * 3;//calculate how much it should move the enemy horizontally
					this.x+= xSpeed;
					this.y+= ySpeed;
					walkCount++;
				}
			}
			if (!isAttackReady){
				reloadCount++;
				if (reloadCount >= reloadTime){
					isAttackReady = true;
				}
			}
			if (this.jumpHit.hitTestObject(_root.player.hit)){
				if (isAttackReady){
				isAttackReady = false;
				reloadCount = 0;
				_root.inGamePlayerHealth -= this.damage;
				_root.player.y += Math.sin(angle) * knockBack;
				_root.player.x += Math.cos(angle) * knockBack;
				this.gotoAndPlay("jumpAttack");
				}
				speed = 0;
			} else {
				speed = 3;
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
			bar.healthSize.width = 158 * (health/staticHealth);
		}
		private function destroyThis(event:Event = null):void{
			//_root.enemyData.splice(_root.enemyList.indexOf(this), 1);
			if (event == null){
				_root.createMessage("spider killed");
				if (bar){
				bar.parent.removeChild(bar);
				}
				if (_root.instructionalStep == 7 || _root.instructionalStep == 8){
					_root.instructionalStep = 8;
					_root.instructionCondition = true;
					_root.instructionCounter++;
					if (_root.instructionCounter >= 3){
						_root.instructionalStep = 9;
					}
					_root.createTopMessage();
				}
			//if (_root.randomNumbers(4,5) == 5){
				droppedItem = new XPDrop();
				droppedItem.x = x;
				droppedItem.y = y;
				droppedItem.width = 10;
				droppedItem.height = 10;
				_root.droppedItemsData.push(droppedItem);
				_root.SettingHolder.addChild(droppedItem);
			//}
				this.parent.removeChild(this);
				_root.enemyData.splice(_root.enemyData.indexOf(this), 1);
				//_root.ObjectHolder.removeChild(this);
				for (var i:int = 0;i < _root.savedStageData[_root.settingTag].length-2;i++){
					if (_root.savedStageData[_root.settingTag][i] == 2002){
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
