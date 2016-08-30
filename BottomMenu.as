package  {
	import flash.display.MovieClip;
	import flash.events.*;
	public class BottomMenu extends MovieClip{
		private var _root:*;
		public var itemArr:Array = new Array(4);
		private var ran:Boolean = false;
		
		public function BottomMenu() {
			addEventListener(Event.ADDED,beginClass);
			addEventListener(Event.REMOVED_FROM_STAGE, destroyThis);
			this.MainBtn.addEventListener(MouseEvent.MOUSE_UP, openMain);
			this.ISBtn.addEventListener(MouseEvent.MOUSE_UP, openIS);
			this.BuildBtn.addEventListener(MouseEvent.MOUSE_UP, openBuild);
			this.CharBtn.addEventListener(MouseEvent.MOUSE_UP, openChar);
		}
		private function beginClass(e:Event):void {
			if (!ran){
				ran = true;
				_root = MovieClip(root);
			
			for (var i:int = 0;i < 4;i++){//since there are 4 itemSlots in BottomMenu
				if (_root.inventory[i] == null){
					_root.inventory[i] = 0;
				}
				itemArr[i] = new ItemSlot(_root.inventory[i], i);
				itemArr[i].x = this.x + 300 + i * 70;
				itemArr[i].y = this.y + 38;
				itemArr[i].isBottomSlot = true;
				_root.MenuHolder.addChild(itemArr[i]);
			}
			}
		}
		private function openMain(event:MouseEvent):void{
			_root.openMainMenu();
		}
		private function openIS(event:MouseEvent):void{
			_root.openInventoryAndSuppliesMenu();
		}
		private function openBuild(event:MouseEvent):void{
			_root.openBuildMenu();
		}
		private function openChar(event:MouseEvent):void{
			_root.openCharMenu();
		}
		private function destroyThis(event:Event):void{
			
		}
	}
}