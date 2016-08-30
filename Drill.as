package  {
	import flash.display.MovieClip;
	import flash.events.*;
	public class Drill extends MovieClip{
		
		private var _root:*;
		public var hasUse:Boolean = true;
		private var reloadTime:int = 3;
		private var damage:int = .25;
		private var stoneDamage:int = 1;
		private var hitTime:int = .5;
		private var knockBack:int = 1;		
		private var isHitReady:Boolean = true;
		private var hitCount:int;
		private var curSlot:int;
		private var doAttack:Boolean;
		private var ran:Boolean;
		
		public function Drill(passSlot:int) {
			curSlot = passSlot;
			addEventListener(Event.ADDED,beginClass);
			addEventListener(Event.ENTER_FRAME, eFrame);
		}
		private function beginClass(e:Event):void {
			if (!ran){
				ran = true;
				_root = MovieClip(root);
			}
		}
		private function eFrame(e:Event):void{
			this.x = _root.player.x;
			this.y = _root.player.y;
			this.rotation = _root.player.rotation;
			if (!isHitReady){
				hitCount++;
				if (hitCount >= hitTime){
					isHitReady = true;
					hitCount = 0;
				}
			}
			if (doAttack){
			for (var i:int = 0; i < _root.enemyData.length; i++){
				if (_root.enemyData[i].materialHit){
					if (this.hit.hitTestObject(_root.enemyData[i].materialHit)){
						_root.enemyData[i].takeMaterialDamage(stoneDamage, 1003);
					}
				}
				if (this.hit.hitTestObject(_root.enemyData[i].hit) && isHitReady){
						if (!_root.enemyData[i].hasNoKnockback){
						_root.enemyData[i].y -= Math.cos(_root.player.rotation) * knockBack;
						_root.enemyData[i].x += Math.sin(_root.player.rotation) * knockBack;
						}
					_root.enemyData[i].takeDamage(damage);
				}
			}
				if (this.currentFrame >= 4){
					doAttack = false;
				}
			}
			
		}
		public function useItem(){
			if (_root.isCloseRangeAttackReady){
			doAttack = true;
			_root.closeRangeLoadCount = reloadTime;
			_root.isCloseRangeAttackReady = false;
			this.gotoAndPlay("Drill drill");
			}
		}
		
	}
}