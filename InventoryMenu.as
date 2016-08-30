package  {
	import flash.display.MovieClip;
	import flash.events.*;
	public class InventoryMenu extends MovieClip{
		private var _root:*;
		public var inventoryTags:Array;
		public var itemArr;//holds ItemSlot objects
		private var ran:Boolean = false;
		private var popper:popUpMessageContinue;
		//public var tempImage;
		
		public function InventoryMenu(passedArr:Array) {
			addEventListener(Event.ADDED,beginClass);
			addEventListener(Event.REMOVED_FROM_STAGE, destroyThis);
			this.trashClick.addEventListener(MouseEvent.MOUSE_UP, trashItem);
			inventoryTags = passedArr;
			itemArr = new Array(inventoryTags.length-4);
			trace(inventoryTags);
		}
		private function beginClass(e:Event):void { //the problem was that this code was running twice
		if (!ran){
			ran = true;
			_root = MovieClip(root);//setting the root
			var startX:int = 65;
			var startY:int = 85;
			var incX:int = 0;
			var incY:int = 0;
			for (var i:int = 4;i < inventoryTags.length;i++){
				if (inventoryTags[i] == null){
					inventoryTags[i] = 0;
				}
				itemArr[i-4] = new ItemSlot(inventoryTags[i],i);
				itemArr[i-4].x = this.x + startX + incX;
				itemArr[i-4].y = this.y + startY + incY;
				if ((i+1-4) % 5 == 0){
					incY += 60;
					incX = -60;
				}
				incX += 60;
				_root.MenuHolder.addChild(itemArr[i-4]);
			}
			this.longRange.visible = false;
			this.closeRange.visible = false;
			this.woodTxt.text = _root.woodSupply;
			this.stoneTxt.text = _root.stoneSupply;
			this.ironTxt.text = _root.ironSupply;
			this.scaleTxt.text = _root.scaleSupply;
		}
		}
		private function trashItem(Event:MouseEvent):void{
			_root.itemHeld = 0;
			/*popper = new popUpMessageContinue();
			popper.x = 100;
			popper.y = 100;
			this.addChild(popper);
			popper.messageTxt.text = "Are you sure you want to trash this item???"
			popper.xOut.addEventListener(MouseEvent.MOUSE_UP, leavePopUp);
			popper.continueBtn.addEventListener(MouseEvent.MOUSE_UP, whenContinue);
			function leavePopUp(Event:MouseEvent = null):void{
				this.removeChild(popper);
			}
			function whenContinue(Event:MouseEvent):void{
				_root.itemHeld = 0;
				leavePopUp();
			}*/
		}
		private function destroyThis(event:Event):void{
			ran = false;//for some reason if you click a bunch of times the InventoryMenu still run through the for-loops but it doesn't actually destroy the items and slots
			/*for (var j:int = 4;j < inventoryTags.length;j++){
				//if (_root.MenuHolder.contains(itemArr[j-3]))
				_root.MenuHolder.removeChild(itemArr[j-4]);
			} //gets rid of all item slots
			for (var i:int = 4;i < _root.itemData.length;i++){
				if (_root.itemData[i])
				_root.MenuHolder.removeChild(_root.itemData[i]);
			} //gets rid of all item images, which were pushed into itemData in the ItemSlot subclass*/
		}
	}
	
}
