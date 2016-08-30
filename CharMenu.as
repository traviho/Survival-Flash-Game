package  {
	import flash.display.MovieClip;
	import flash.events.*;
	public class CharMenu extends MovieClip{
		private var _root:*;
		private var ran:Boolean;
		
		public function CharMenu() {
			addEventListener(Event.ADDED,beginClass);
			this.inc1.addEventListener(MouseEvent.MOUSE_UP, upHealth);
			this.inc2.addEventListener(MouseEvent.MOUSE_UP, upDamage);
			this.inc3.addEventListener(MouseEvent.MOUSE_UP, upCritical);
		}
		private function beginClass(e:Event):void {
			if (!ran){
				ran = true;
				_root = MovieClip(root);
				setStats();
			}
		}
		private function upHealth(event:MouseEvent):void{
			if (_root.playerPoints > 0){
				_root.playerPoints--;
				_root.playerHealth++;
				setStats();
			}
		}
		private function upDamage(event:MouseEvent):void{
			if (_root.playerPoints > 0){
				_root.playerPoints--;
				if (_root.playerDamageRange % 2 == 0){
					_root.playerDamage++;
				}
					_root.playerDamageRange++;
				setStats();
			}
		}
		private function upCritical(event:MouseEvent):void{
			if (_root.playerPoints > 0){
				_root.playerPoints--;
				_root.playerCritical++;
				setStats();
			}
		}
		private function setStats():void{
			if (_root.instructionalStep == 9){
				if (_root.playerPoints == 0){
					_root.instructionalStep = 10;
					_root.createTopMessage();
				}
			}
			this.levelTxt.text = "Level " + _root.playerLevel;
			this.theXPBar.XPShape.width = 275 * (_root.playerXP/_root.XPToNext);
			this.healthTxt.text = _root.playerHealth + "";
			this.damageTxt.text = _root.playerDamage + "";
			this.baseDamageTxt.text = _root.playerDamage + "-" + (_root.playerDamage + _root.playerDamageRange);
			this.speedTxt.text = _root.playerSpeed + "";
			this.criticalTxt.text = _root.playerCritical + "";
			this.ptsTxt.text = _root.playerPoints + "";
		}
	}
	
}
