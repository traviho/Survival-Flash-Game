package  {
	import flash.display.MovieClip;
	import flash.events.*;
	public class TwoHeadedReptile extends MovieClip{
		private var _root:*;
		public var speed:Number = 1;
		private var pushBack:int = 2;
		public var health:int = 180;
		private var quakeDamage:Number = 3;
		private var damage:int = 5;
		public var reloadTime:int = 100;
		private var noticeRadius:int = 400;
		private var knockBack:int = 60;
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
		private var ran:Boolean;
		
		public function TwoHeadedReptile() {
			addEventListener(Event.ADDED,beginClass);
			addEventListener(Event.ENTER_FRAME, eFrame);
			addEventListener(Event.REMOVED_FROM_STAGE, destroyThis);
		}
		private function beginClass(e:Event):void {
			if (!ran){
			ran = true;
			_root = MovieClip(root);//setting the root
			this.width = 90;
			this.height = 210;
			}
		}
		private function eFrame(e:Event):void{
			dy = _root.player.y - y
			dx = _root.player.x - x
			if (Math.sqrt(Math.pow(dy,2) + Math.pow(dx,2)) <= noticeRadius){
				angle = Math.atan2(dy, dx);//is this way because angle is radians, but want rotation degrees
				if (Math.abs((90 + angle * 180 / Math.PI) - 0) <= 22.5){
					this.rotation = 0;
				} else if (Math.abs((90 + angle * 180 / Math.PI) - 45) < 22.5){
					this.rotation = 45;
				} else if (Math.abs((90 + angle * 180 / Math.PI) - 90) <= 22.5){
					this.rotation = 90;
				} else if (Math.abs((90 + angle * 180 / Math.PI) - 135) < 22.5){
					this.rotation = 135;
				} else if (Math.abs((90 + angle * 180 / Math.PI) - 180) <= 22.5){
					this.rotation = 180;
				} else if (Math.abs((90 + angle * 180 / Math.PI) + 45) < 22.5){
					this.rotation = -45;
				} else if (Math.abs((90 + angle * 180 / Math.PI) + 90) <= 22.5){
					this.rotation = -90;
				} else if (Math.abs((90 + angle * 180 / Math.PI) + 135) < 22.5){
					this.rotation = -135;
				}
				ySpeed = Math.sin(angle) * speed *.5;
				xSpeed = Math.cos(angle) * speed *.5;
				this.x+= xSpeed;
				this.y+= ySpeed;
				if (isAttackReady){
					var newQuake:Earthquake = new Earthquake(quakeDamage);
					this.gotoAndPlay("quakeAnim");
					newQuake.x = this.x;
					newQuake.y = this.y;
					newQuake.rotation = this.rotation;
					_root.ObjectHolder.addChild(newQuake);
					if (this.superHit.hitTestObject(_root.player.hit)){
						_root.player.y += Math.sin(angle) * knockBack;
						_root.player.x += Math.cos(angle) * knockBack;
					}
					isAttackReady = false;
					reloadCount = 0;
					reloadTime = _root.randomNumbers(8,40);//randomizing when it shoots a bit
				}
			}
			if (this.tailHit.hitTestObject(_root.player.hit)){
				isTouchingPlayer = true;
				speed = 0;
				this.gotoAndPlay("tailSwing");
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
			bar.healthSize.width = 158 * (health/180);
			noticeRadius = 800;
		}
		private function destroyThis(event:Event = null):void{
			//_root.enemyData.splice(_root.enemyList.indexOf(this), 1);
			if (event == null){
				_root.createMessage("Two Headed Reptile killed");
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
					if (_root.savedStageData[_root.settingTag][i] == 2006){
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
