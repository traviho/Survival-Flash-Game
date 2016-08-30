package  {
	import flash.display.MovieClip;
	import flash.events.*;
	public class Knife extends MovieClip{
		
		private var _root:*;
		public var hasUse:Boolean = true;
		private var reloadTime:int = 6;
		private var damage:int = 2;
		private var stun:int = 12;
		private var hitTime:int = 2;
		private var knockBack:int = 2;		
		private var isHitReady:Boolean = true;
		private var hitCount:int;
		private var curSlot:int;
		
		public function Knife(passSlot:int) {
			curSlot = passSlot;
			addEventListener(Event.ADDED,beginClass);
			addEventListener(Event.ENTER_FRAME, eFrame);
		}
		private function beginClass(e:Event):void {
			_root = MovieClip(root);//setting the root
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
			this.gotoAndPlay("knifeStab");
			for (var i:int = 0; i < _root.enemyData.length; i++){
				if (this.hit.hitTestObject(_root.enemyData[i].hit) && isHitReady){
					isHitReady = false;
					if (!_root.enemyData[i].hasNoKnockback){
						_root.enemyData[i].y -= Math.cos(_root.player.rotation) * knockBack;
						_root.enemyData[i].x += Math.sin(_root.player.rotation) * knockBack;
					}
					_root.enemyData[i].takeDamage(damage);
					_root.enemyData[i].isAttackReady = false;
					_root.enemyData[i].reloadCount -= stun;
				}
			}
			}
		}
		
	}
}