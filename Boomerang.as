﻿package  {
	import flash.display.MovieClip;
	import flash.events.*;
	public class Boomerang extends MovieClip{
		
		private var _root:*;
		public var hasUse:Boolean = true;
		private var reloadTime:int = 15;
		public var damage:int = 2;
		private var hitTime:int = 5;
		private var knockBack:int = 7;		
		private var isHitReady:Boolean = true;
		private var hitCount:int;
		private var curSlot:int;
		private var doAttack:Boolean;
		private var ran:Boolean;
		
		public function Boomerang(passSlot:int) {
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
				if (this.hit.hitTestObject(_root.enemyData[i].hit) && isHitReady){
					isHitReady = false;
					if (!_root.enemyData[i].hasNoKnockback){
						_root.enemyData[i].y -= Math.cos(_root.player.rotation) * knockBack;
						_root.enemyData[i].x += Math.sin(_root.player.rotation) * knockBack;
					}
					_root.enemyData[i].takeDamage(damage);
				}
				if (this.currentFrame >= 15){
					doAttack = false;
				}
			}
			}
		}
		public function useItem(){
			if (_root.isLongRangeAttackReady){
				doAttack = true;
				var curAnimation = _root.controlAnimation(curSlot);
				this.gotoAndPlay("boomerangToss");
				_root.longRangeLoadCount = reloadTime;
				_root.isLongRangeAttackReady = false;
			}
		}
		
	}
}