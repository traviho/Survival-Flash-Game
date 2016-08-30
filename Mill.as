package  {
	import flash.display.MovieClip;
	import flash.events.*;
	import fl.motion.Color;
	import flash.geom.ColorTransform;
	public class Mill extends MovieClip{
		private var _root:*;
		private var ran:Boolean;
		private var red;
		private var blue;
		private var dy:int;
		private var dx:int;
		public var xRef:int;
		public var yRef:int;
		private var bar;
		private var tempBoolean:Boolean;
		public var hasUse:Boolean = true;
		public var isMove:Boolean;
		private var isPlaceable:Boolean;
		private var clickCount:int;
		private var timeSinceLastClick:int;
		private var curSlot:int;
		private var isInventory:Boolean = false;
		public var thisTag:int;
		public var capacity:Number = 0;
		public var counter:Number = 0;
		private var maxCapacity:Number = 3;
		private var incrementCounter:Number = .01;
		private var droppedItem;
		
		public function Mill(passSlot:int) {
			curSlot = passSlot;
			if (curSlot <= 3){
				isInventory = true;
			}
			red = new ColorTransform();
			red.color = 0x990000;
			red.alphaOffset = -50;
			blue = new ColorTransform();
			blue.color = 0x0066CC;
			blue.alphaOffset = -125;
			addEventListener(Event.ADDED,beginClass);
			addEventListener(Event.ENTER_FRAME, eFrame);
			addEventListener(MouseEvent.MOUSE_UP, theClick);
			addEventListener(Event.REMOVED_FROM_STAGE, destroyThis);
		}
		private function beginClass(e:Event):void {
			if (!ran){
				ran = true;
				_root = MovieClip(root);
				if (isInventory){
					this.visible = false;
					this.mouseEnabled = false;
				} else {
					this.place.visible = false;
				}
				bar = new hpBar();
				bar.width = 60;
				bar.height = 8;
				bar.x = this.x - 30;
				bar.y = this.y - 60;
				bar.healthSize.transform.colorTransform = blue;
				_root.ObjectHolder.addChild(bar);
			}
		}
			
		private function eFrame(e:Event):void{
			counter = _root.StructureStatusData[thisTag][0];
			if (counter < 24){
				capacity = 0;
			} else if (counter < 48){
				capacity = 1;
			} else if (counter < 72){
				capacity = 2;
			} else if (counter >= 72){
				capacity = 3;
			}
			if (isMove){
				this.x = stage.mouseX;
				this.y = stage.mouseY;
				for (var i:int = 0;i < _root.placementData.length;i++){
					if (_root.placementData[i].place){
						if (this.place.hitTestObject(_root.placementData[i].place)){
							tempBoolean = true;
							isPlaceable = false;
						}
					}
				}
				for (var j:int = 0;j < _root.hitObjectData.length;j++){
					if (_root.hitObjectData[j].hit){
						if (this.place.hitTestObject(_root.hitObjectData[j].hit)){
							tempBoolean = true;
							isPlaceable = false;
						}
					}
				}
				if (this.y + (this.place.height * .3) > _root.lowerBound-100 || this.y - (this.place.height * .3)+25 < _root.upperBound || this.x + (this.place.width * .3) > _root.rightBound || this.x - (this.place.width * .3) < _root.leftBound){
					isPlaceable = false;
					tempBoolean = true;
				}
				if (_root.settingTag > 9){
					isPlaceable = false;
					tempBoolean = true;
				}
				if (!tempBoolean){
					isPlaceable = true;
				}
				tempBoolean = false;
				if (_root.spacePressed == true){
					this.visible = false;
					this.mouseEnabled = false;
					isMove = false;
				}
				if (isPlaceable){
					this.place.transform.colorTransform = blue;
				} else {
					this.place.transform.colorTransform = red;
				}
			} else {
				if (_root.spacePressed == true && this.interact.hitTestObject(_root.player.hit) && !isInventory){
					spit();
				}
			}
			bar.healthSize.width = 158 * (capacity/maxCapacity);
			if (clickCount != 0){
				timeSinceLastClick++;
				if (timeSinceLastClick >= 36){
					timeSinceLastClick = 0;
					clickCount = 0;
				}
			}
			if (clickCount >= 10){
				destroyThis();
			}
		}
		public function theClick(Event:MouseEvent):void{
			if (isMove){
				if (isInventory){
					if (isPlaceable){
					_root.inventory[curSlot] = 0;
					_root.createEquipment(curSlot,0);
					_root.bottomMenu.itemArr[curSlot].thisTag = 0;
					if (_root.itemData[curSlot])
					_root.destroyImage(curSlot);
					this.place.visible = false;
					setNewStructure();
					isMove = false;
					}
				} else {
					if (isPlaceable){
						this.place.visible = false;
						isMove = false;
					}
				}
			} else {
				this.gotoAndPlay("clickAnim");
				clickCount++;
				timeSinceLastClick = 0;
				trace(clickCount);
			}
		}
		public function useItem():void{
			_root.createMessage("Press space to cancel");
			isMove = true;
			isInventory = true;
			this.visible = true;
			this.mouseEnabled = true;
		}
		private function setNewStructure(){
			_root.structureHolderTag++;
			thisTag = _root.structureHolderTag;
			_root.StructurePlacementData[_root.settingTag-1].push(10007);
			_root.StructurePlacementData[_root.settingTag-1].push(this.x);
			_root.StructurePlacementData[_root.settingTag-1].push(this.y);
			_root.StructurePlacementData[_root.settingTag-1].push(thisTag);
			_root.StructureStatusData[thisTag].push(0);
			_root.StructureStatusData[thisTag].push(incrementCounter);
			if (_root.StaticHolder.contains(this)){
				_root.createNewStructure(10007, this.x, this.y, thisTag);
				_root.StaticHolder.removeChild(this);
			}
		}
		private function spit(){
			for (var i:int = 0;i < capacity;i++){
				droppedItem = new woodDrop();
				droppedItem.rotation = _root.randomNumbers(-179,180);
				droppedItem.x = x + _root.randomNumbers(-40,40);
				droppedItem.y = y + _root.randomNumbers(56,75);
				_root.droppedItemsData.push(droppedItem);
				_root.SettingHolder.addChild(droppedItem);
			}
			_root.StructureStatusData[thisTag][0] = 0;
		}
		public function destroyThis(event:Event = null):void{
			if (event == null){
				droppedItem = new itemMill();
				droppedItem.x = this.x;
				droppedItem.y = this.y;
				droppedItem.width = 30;
				droppedItem.height = 30;
				_root.droppedItemsData.push(droppedItem);
				_root.SettingHolder.addChild(droppedItem);
				if (bar){
				bar.parent.removeChild(bar);
				}
				trace("remoavl");
				_root.hitObjectData.splice(_root.hitObjectData.indexOf(this),1);
				_root.placementData.splice(_root.placementData.indexOf(this),1);
				for (var i:int = 0;i < _root.StructurePlacementData[_root.settingTag-1].length;i++){
					if (_root.StructurePlacementData[_root.settingTag-1][i] == thisTag){
						trace("detect");
						if (_root.StructurePlacementData[_root.settingTag-1][i-1] == this.y){
							trace("detect");
							if (_root.StructurePlacementData[_root.settingTag-1][i-2] == this.x){
								trace("detect");
								if (_root.StructurePlacementData[_root.settingTag-1][i-3] == 10007){
									trace("detect");
								_root.StructurePlacementData[_root.settingTag-1].splice(i-3,4);
								_root.StructureStatusData[thisTag].splice(0,1);
								//_root.StructureStatusData.splice(thisTag,1);
								}
							}
						}
					}
				}
				this.parent.removeChild(this);
			}
			this.removeEventListener(Event.ENTER_FRAME, eFrame);
		}


	}
	
}
