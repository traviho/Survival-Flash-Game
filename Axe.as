package  {
	import flash.display.MovieClip;
	import flash.events.*;
	public class Axe extends MovieClip{
		
		private var _root:*;
		public var hasUse:Boolean = true;
		private var reloadTime:int = 12;
		private var damage:int = 1;
		private var woodDamage:int = 1;
		private var hitTime:int = 3;
		private var knockBack:int = 10;		
		private var isHitReady:Boolean = true; //hit always ready
		private var hitCount:int;
		private var curSlot:int;
		private var ran:Boolean;
		
		public function Axe(passSlot:int) {
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
		}
		public function useItem(){
			if (_root.isCloseRangeAttackReady){
			_root.closeRangeLoadCount = reloadTime;
			_root.isCloseRangeAttackReady = false;
			this.gotoAndPlay("axeSwing");
			for (var i:int = 0; i < _root.enemyData.length; i++){
				if (this.hit.hitTestObject(_root.enemyData[i].hit) && isHitReady){
						if (!_root.enemyData[i].hasNoKnockback){
						_root.enemyData[i].y -= Math.cos(_root.player.rotation) * knockBack;
						_root.enemyData[i].x += Math.sin(_root.player.rotation) * knockBack;
						}
					_root.enemyData[i].takeDamage(damage);
				}
				if (_root.enemyData[i].materialHit){
					if (this.hit.hitTestObject(_root.enemyData[i].materialHit) && isHitReady){
						_root.enemyData[i].takeMaterialDamage(woodDamage, 10002);
					}
				}
			}
			}
		}
		
	}
}