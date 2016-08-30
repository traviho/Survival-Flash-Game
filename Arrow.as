package {
	import flash.display.MovieClip;
	import flash.events.*;
	public class Arrow extends MovieClip {
		private var _root:*;
		private var damage:int;
	    private var maxSpeed:int;
		private var knockBack;
		private var isPlayerArrow:Boolean;
		
		public function Arrow(passedDamage:int, passedSpeed:int, passedKnockBack:int, passIsPlayer:Boolean) {
			damage = passedDamage;
			maxSpeed = passedSpeed;
			knockBack = passedKnockBack;
			isPlayerArrow = passIsPlayer;
			addEventListener(Event.ADDED,beginClass);//this will run every time this guy is made
			addEventListener(Event.ENTER_FRAME,eFrame);//this will run every frame
			addEventListener(Event.REMOVED_FROM_STAGE, destroyThis);
		}
		
		private function beginClass(e:Event):void {
			_root = MovieClip(root);
		}
		private function eFrame(e:Event):void {
			if (this.y < _root.upperBound || this.y > _root.lowerBound || this.x < _root.leftBound || this.x > _root.rightBound){
				destroyThis();
			}
				this.y -= Math.cos(rotation * Math.PI / 180) * maxSpeed;
				this.x += Math.sin(rotation * Math.PI / 180) * maxSpeed
			if (isPlayerArrow){
			for (var i:int = 0; i < _root.enemyData.length; i++){
				if (this.hit.hitTestObject(_root.enemyData[i].hit)){
					if (!_root.enemyData[i].hasNoKnockback){
						_root.enemyData[i].y -= Math.cos(_root.player.rotation) * knockBack;
						_root.enemyData[i].x += Math.sin(_root.player.rotation) * knockBack;
					}
					_root.enemyData[i].takeDamage(damage);
					destroyThis();
				}
			}
			} else {
				if (this.hit.hitTestObject(_root.player.hit)){
					dealDamage(0);
				}
			}
		}
		private function dealDamage(whichHit:int):void{
			if (whichHit == 0){
				_root.inGamePlayerHealth -= this.damage;
				_root.player.y += Math.sin(this.rotation) * knockBack;
				_root.player.x += Math.cos(this.rotation) * knockBack;
			}
			destroyThis();
		}
		public function destroyThis(event:Event = null):void{
			//this function will just remove this guy from the stage
			this.removeEventListener(Event.ENTER_FRAME, eFrame);
			if (event == null && this.parent){
				this.parent.removeChild(this);
			}
		}
	}
}