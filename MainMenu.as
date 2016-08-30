package  {
	import flash.display.MovieClip;
	import flash.events.*;
	public class MainMenu extends MovieClip{
		private var _root:*;
		
		public function MainMenu() {
			addEventListener(Event.ADDED,beginClass);
			this.continueBtn.addEventListener(MouseEvent.MOUSE_UP, continueGame);
			this.htpBtn.addEventListener(MouseEvent.MOUSE_UP, howToPlay);
			this.sqBtn.addEventListener(MouseEvent.MOUSE_UP, SaveAndQuit);
			this.saveBtn.addEventListener(MouseEvent.MOUSE_UP, SaveFunc);
		}
		private function beginClass(e:Event):void {
			_root = MovieClip(root);
		}
		private function continueGame(Event:MouseEvent):void{
			//this.parent.removeChild(this);
			_root.openMainMenu();
		}
		private function howToPlay(Event:MouseEvent):void{
			_root.openHowToPlayPopUp();
		}
		private function SaveAndQuit(Event:MouseEvent):void{
			_root.openMainMenu();
			_root.saveGame();
			_root.returnToMain();
		}
		private function SaveFunc(Event:MouseEvent):void{
			_root.saveGame();
		}
	}
	
}
