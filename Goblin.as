package  {
	import flash.display.MovieClip;
	import flash.events.*;
	public class Goblin extends MovieClip{
		private var _root:*;
		public var speed:int = 3;
		private var pushBack:int = 3;
		public var health:int = 10;
		private var damage:int = 2;
		public var reloadTime:int = 48;//2 secs
		private var noticeRadius:int = 200;
		private var knockBack:int = 20;
		private var stunTime:int = 10;
		
		public var isAttackReady:Boolean = true;
		public var reloadCount:int;
		private var dy:int;
		private var dx:int;
		private var angle:Number;
		private var droppedItem:itemKnife;
		public var xRef:int;
		public var yRef:int;
		public var isNightEnemy:Boolean;
		public var bar;
		public var materialHit:Boolean = false;
		public var hasNoKnockback:Boolean = false;
		
		private var isTouchingPlayer:Boolean;
		
		public function Goblin() {
			addEventListener(Event.ADDED,beginClass);
			addEventListener(Event.ENTER_FRAME, eFrame);
			addEventListener(Event.REMOVED_FROM_STAGE, destroyThis);
		}
		private function beginClass(e:Event):void {
			_root = MovieClip(root);//setting the root
		}
		private function eFrame(e:Event):void{
			dy = _root.player.y - y;
			dx = _root.player.x - x;
			if (Math.sqrt(Math.pow(dy,2) + Math.pow(dx,2)) <= noticeRadius){
				this.rotation = 90 + Math.atan2(dy, dx) * 180 / Math.PI;
				angle = Math.atan2(dy, dx);
				var ySpeed:Number = Math.sin(angle) * speed;
				var xSpeed:Number = Math.cos(angle) * speed;
				this.x+= xSpeed;
				this.y+= ySpeed;
			}
			
			if (!isAttackReady){
				reloadCount++;
				if (reloadCount >= reloadTime){
					isAttackReady = true;
				}
			}
			if (!isTouchingPlayer){
				speed = 3;
			}
			if (this.knifeHit.hitTestObject(_root.player.hit)){
				dealDamage(0);
				isTouchingPlayer = true;
			} else {
				isTouchingPlayer = false;
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
		private function dealDamage(whichHit:int):void{
			if (isAttackReady){
				isAttackReady = false;
				reloadCount = 0;
				this.gotoAndPlay("knifeSwing");
				if (whichHit == 0){
					_root.inGamePlayerHealth -= this.damage;
					_root.player.y += Math.sin(angle) * knockBack;
					_root.player.x += Math.cos(angle) * knockBack;
				}
			}
			speed = 0;
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
			bar.healthSize.width = 158 * (health/10);
		}
		private function destroyThis(event:Event = null):void{
			if (event == null){
				_root.createMessage("goblin killed");
				if (bar){
				bar.parent.removeChild(bar);
				}
			if (_root.randomNumbers(1,5) == 5){
				droppedItem = new itemKnife();
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
					if (_root.savedStageData[_root.settingTag][i] == 2000){
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
