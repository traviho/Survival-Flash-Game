package  {
	import flash.display.MovieClip;
	import flash.events.*;
	public class Pickaxe extends MovieClip{
		
		private var _root:*;
		public var hasUse:Boolean = true;
		private var reloadTime:int = 7;
		private var damage:int = 1;
		private var stoneDamage:int = 1;
		private var hitTime:int = 6;
		private var knockBack:int = 10;		
		private var isHitReady:Boolean = true;
		private var hitCount:int;
		private var hitWait:int;//this is for hitting a max number of enemies
		private var maxHits:int;
		private var curSlot:int;
		private var ran:Boolean;
		
		public function Pickaxe(passSlot:int) {
			curSlot = passSlot;
			addEventListener(Event.ADDED,beginClass);
			addEventListener(Event.ENTER_FRAME, eFrame);
			addEventListener(Event.REMOVED_FROM_STAGE, destroyThis);
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
			
		}
		public function useItem(){
			if (_root.isCloseRangeAttackReady){
			_root.closeRangeLoadCount = reloadTime;
			_root.isCloseRangeAttackReady = false;
			var curAnimation = _root.controlAnimation(curSlot);
			if (!(curAnimation % 2 == 0)){
			this.gotoAndPlay("pickaxeSwing");
			} else if (curAnimation % 2 == 0){
				this.gotoAndPlay("pickaxeSwing2");
			}
			for (var i:int = 0; i < _root.enemyData.length; i++){
				if (_root.enemyData[i].materialHit){
					if (this.hit.hitTestObject(_root.enemyData[i].materialHit)){
						_root.enemyData[i].takeMaterialDamage(damage, 1003);
					}
				}
				if (this.hit.hitTestObject(_root.enemyData[i].hit) && isHitReady){
						if (!_root.enemyData[i].hasNoKnockback){
						_root.enemyData[i].y -= Math.cos(_root.player.rotation) * knockBack;
						_root.enemyData[i].x += Math.sin(_root.player.rotation) * knockBack;
						}
					_root.enemyData[i].takeDamage(damage);
					hitWait++;
					if (hitWait >= maxHits){
						isHitReady = false;
						hitWait = 0;
						break;
					}
				}
			}
			}
		}
		private function destroyThis(event:Event = null):void{
			this.removeEventListener(Event.ENTER_FRAME, eFrame);
		}
		
	}
}