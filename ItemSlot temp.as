﻿package
{
    import flash.display.MovieClip;
    import flash.events.Event;
    import flash.events.MouseEvent 
	import flash.events.*;
	import flash.display.Sprite;
	
    public class ItemSlot extends MovieClip{
		public var thisTag:int;
		private var temp:int;
		//public var hasItem:Boolean;
		private var whichOne:int;
		public var itemImage;
		public var isMouseFollow:Boolean;
		private var _root:MovieClip;
		private var slotNumber:int;
		public var isBottomSlot:Boolean;
		private var ran:Boolean = false;
 
        public function ItemSlot(passTag:int, whichSlot):void{
			thisTag = passTag;
			slotNumber = whichSlot;
            addEventListener(Event.ADDED, init);
			addEventListener(MouseEvent.MOUSE_UP, whenClicked);
			if (slotNumber > 3){
				addEventListener(MouseEvent.MOUSE_OVER, whenIn);
				addEventListener(MouseEvent.MOUSE_OUT, whenOut);
			}
        }
        public function init(e:Event):void{
			if (!ran){
			_root = MovieClip(root);
			setImage(thisTag);
			ran = true;
			}
		}
		public function whenClicked(Event:MouseEvent):void{
			trace("Object tag before click: "+ thisTag);
			if (_root.itemData[slotNumber])//if this slot has an image, then destroy it when you pick it up
				_root.destroyImage(slotNumber); //had problem
			if (_root.itemHeld != 0){
				setImage(_root.itemHeld);
			}
			temp = _root.itemHeld;
			_root.itemHeld = thisTag;//if this has nothing in it, then itemHeld would be set to 0
			thisTag = temp;
			_root.inventory[slotNumber] = thisTag;
			if (isBottomSlot){
				_root.createEquipment(slotNumber, thisTag);
			}
			trace("Object tag after click: "+ thisTag);
			trace("holding tag :" + _root.itemHeld);
		}
		public function whenIn(Event:MouseEvent):void{
			_root.setDescriptor(thisTag);
		}
		public function whenOut(Event:MouseEvent):void{
			_root.setDescriptor(0);
			//_root.inventoryMenu.removeTemps();
		}
		public function setImage(passTag:int){//can also be called on the outside
		//trace("setting images");
			if (passTag == 2000){
				itemImage = new itemCrate();
			} else if (passTag == 2001){
				itemImage = new itemMill();
			} else if (passTag == 3000){
				itemImage = new itemSword();
			} else if (passTag == 3001){
				itemImage = new itemKnife();
			} else if (passTag == 3002){
				itemImage = new itemBow();
			} else if (passTag == 3003){
				itemImage = new itemAxe();
			} else if (passTag == 3004){
				itemImage = new itemPickaxe();
			} else {
				itemImage = new itemCrate();
			}
			if (passTag != 0){
			itemImage.mouseEnabled = false;
			itemImage.x = this.x;
			itemImage.y = this.y;
			//trace("before: "+ _root.itemData);
			_root.itemData[slotNumber] = itemImage;
			_root.MenuHolder.addChild(_root.itemData[slotNumber]); //maybe this code and destroyImages (all itemData references) should be put in main timeline
			//trace("after: " + _root.itemData);
			}
		}
		
    }
 
}
 