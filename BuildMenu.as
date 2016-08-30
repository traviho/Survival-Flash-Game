package  {
	import flash.display.MovieClip;
	import flash.events.*;
	import fl.motion.Color;
	import flash.geom.ColorTransform;
	public class BuildMenu extends MovieClip{
		private var _root:*;
		private var ran:Boolean = false;
		private var currentTab:int = 1;
		private var currentSelection:int = 100;
		private var dim:Color = new Color();
		private var bright:Color = new Color();
		private var charMaxSelections:int = 105-2;//-2 because current selection is the first one. This would be 5 selections
		private var fortMaxSelections:int = 203-2;
		private var wallsAndTowersMaxSelections:int = 306-2;
		private var miscMaxSelections:int = 508-2;
		private var startY:int;
		private var startX:int;
		private var incY:int = 120;
		private var SelectionArr:Array = new Array(3);
		private var tempImage;
		
		public function BuildMenu() {
			dim.brightness = -.7;
			bright.brightness = 0.0;
			startY = this.y + 152;
			startX = this.x + 250;
			addEventListener(Event.ADDED,beginClass);
			addEventListener(Event.REMOVED_FROM_STAGE, destroyThis);
			this.upBtn.addEventListener(MouseEvent.MOUSE_UP, function temp1(Event:MouseEvent):void{createSelections(currentSelection-1)});
			this.downBtn.addEventListener(MouseEvent.MOUSE_UP, function temp2(Event:MouseEvent):void{createSelections(currentSelection+1)});
			this.charTab.charBtn.addEventListener(MouseEvent.MOUSE_UP, function temp3(Event:MouseEvent):void{setTab(1)});
			this.fortTab.fortBtn.addEventListener(MouseEvent.MOUSE_UP, function temp4(Event:MouseEvent):void{setTab(2)});
			this.wallsAndTowersTab.wallsAndTowersBtn.addEventListener(MouseEvent.MOUSE_UP, function temp5(Event:MouseEvent):void{setTab(3)});
			this.miscTab.miscBtn.addEventListener(MouseEvent.MOUSE_UP, function temp6(Event:MouseEvent):void{setTab(5)});
		}
		private function beginClass(e:Event):void { //the problem was that this code was running twice
			if (!ran){
				ran = true;
				trace(this.numChildren);
				_root = MovieClip(root);
				setTab(1);
			}
		}
		private function setTab(precedenceTab:int):void{
			if (precedenceTab == 1){
				this.setChildIndex(charTab, this.numChildren-3);
				charTab.transform.colorTransform = bright;
				fortTab.transform.colorTransform = dim;
				wallsAndTowersTab.transform.colorTransform = dim;
				miscTab.transform.colorTransform = dim;
				currentSelection = 100;
				createSelections(currentSelection);
				
			} else if (precedenceTab == 2){
				this.setChildIndex(fortTab, this.numChildren-3);//-3 because of two up and down buttons
				charTab.transform.colorTransform = dim;
				fortTab.transform.colorTransform = bright;
				wallsAndTowersTab.transform.colorTransform = dim;
				miscTab.transform.colorTransform = dim;
				currentSelection = 200;
				createSelections(currentSelection);
			} else if (precedenceTab == 3){
				this.setChildIndex(wallsAndTowersTab, this.numChildren-3);//-3 because of two up and down buttons
				charTab.transform.colorTransform = dim;
				fortTab.transform.colorTransform = dim;
				wallsAndTowersTab.transform.colorTransform = bright;
				miscTab.transform.colorTransform = dim;
				currentSelection = 300;
				createSelections(currentSelection);
			} else if (precedenceTab == 5){
				this.setChildIndex(miscTab, this.numChildren-3);//-3 because of two up and down buttons
				charTab.transform.colorTransform = dim;
				fortTab.transform.colorTransform = dim;
				wallsAndTowersTab.transform.colorTransform = dim;
				miscTab.transform.colorTransform = bright;
				currentSelection = 500;
				createSelections(currentSelection);
			}
		}
		private function createSelections(startingSelection:int):void{
			var count:int = 0;
			currentSelection = startingSelection;
			for (var i:int = currentSelection;i < currentSelection+3;i++){
				if (currentSelection == 99 || currentSelection == 199 || currentSelection == 299 || currentSelection == 399 || currentSelection == 499){
				currentSelection++;
				break;
				} else if (currentSelection == charMaxSelections || currentSelection == fortMaxSelections || currentSelection == wallsAndTowersMaxSelections || currentSelection == miscMaxSelections){
				currentSelection--;
				break;
				}//if these conditions were true, wouldn't run three times
				if (count == 0)
				removeSelections();//so that it only removes them once
				trace(i);
				SelectionArr[count] = new Selectionee();
				SelectionArr[count].x = startX;
				SelectionArr[count].y = startY + (incY * count);
				
				if (i == 100){
					SelectionArr[count].nameTxt.text = "AXE";
					SelectionArr[count].equippableTxt.text = "*Equippable*";
					SelectionArr[count].descriptionTxt.text = "Chop dead logs";
					tempImage = new itemAxe(); tempImage.x = startX - 400; tempImage.y = 0; SelectionArr[count].addChild(tempImage);
					tempImage = new CloseRange(); tempImage.x = startX - 295; tempImage.y = 12; tempImage.width = 40; tempImage.height = 40; SelectionArr[count].addChild(tempImage);
					tempImage = new itemWood(); tempImage.x = startX - 330; tempImage.y = 40; SelectionArr[count].addChild(tempImage);
					tempImage = new itemStone(); tempImage.x = startX - 260; tempImage.y = 40; SelectionArr[count].addChild(tempImage);
					SelectionArr[count].cost1Txt.text = "40";
					SelectionArr[count].cost2Txt.text = "25";
					if (_root.woodSupply < 40 || _root.stoneSupply < 25){
						SelectionArr[count].transform.colorTransform = dim;
					}
					SelectionArr[count].buildBtn.addEventListener(MouseEvent.MOUSE_UP, function temp100(Event:MouseEvent):void{buyItem(100)});
				} else if (i == 101){
					SelectionArr[count].nameTxt.text = "SWORD";
					SelectionArr[count].equippableTxt.text = "*Equippable*";
					SelectionArr[count].descriptionTxt.text = "Swing at your enemies";
					tempImage = new itemSword(); tempImage.x = startX - 400; tempImage.y = 0; SelectionArr[count].addChild(tempImage);
					tempImage = new CloseRange(); tempImage.x = startX - 295; tempImage.y = 12; tempImage.width = 40; tempImage.height = 40; SelectionArr[count].addChild(tempImage);
					tempImage = new itemWood(); tempImage.x = startX - 330; tempImage.y = 40; SelectionArr[count].addChild(tempImage);
					SelectionArr[count].cost1Txt.text = "50";
					if (_root.woodSupply < 50){
						SelectionArr[count].transform.colorTransform = dim;
					}
					SelectionArr[count].buildBtn.addEventListener(MouseEvent.MOUSE_UP, function temp100(Event:MouseEvent):void{buyItem(101)});
				} else if (i == 102){
					SelectionArr[count].descriptionTxt.text = "BOW";
					SelectionArr[count].equippableTxt.text = "*Equippable*";
					SelectionArr[count].descriptionTxt.text = "Shoot at your enemies from a range";
					tempImage = new itemBow();tempImage.x = startX - 400; tempImage.y = 0; SelectionArr[count].addChild(tempImage);
					tempImage = new LongRange(); tempImage.x = startX - 295; tempImage.y = 12; tempImage.width = 40; tempImage.height = 40; SelectionArr[count].addChild(tempImage);
					tempImage = new itemWood(); tempImage.x = startX - 330; tempImage.y = 40; SelectionArr[count].addChild(tempImage);
					SelectionArr[count].cost1Txt.text = "30";
					if (_root.woodSupply < 30){
						SelectionArr[count].transform.colorTransform = dim;
					}
					SelectionArr[count].buildBtn.addEventListener(MouseEvent.MOUSE_UP, function temp101(Event:MouseEvent):void{buyItem(102)});
				} else if (i == 103){
					SelectionArr[count].descriptionTxt.text = "BOOMERANG";
					SelectionArr[count].equippableTxt.text = "*Equippable*";
					SelectionArr[count].descriptionTxt.text = "Bam";
					tempImage = new itemBoomerang();tempImage.x = startX - 400; tempImage.y = 0; SelectionArr[count].addChild(tempImage);
					tempImage = new LongRange(); tempImage.x = startX - 295; tempImage.y = 12; tempImage.width = 40; tempImage.height = 40; SelectionArr[count].addChild(tempImage);
					tempImage = new itemWood(); tempImage.x = startX - 330; tempImage.y = 40; SelectionArr[count].addChild(tempImage);
					SelectionArr[count].cost1Txt.text = "50";
					if (_root.woodSupply < 50){
						SelectionArr[count].transform.colorTransform = dim;
					}
					SelectionArr[count].buildBtn.addEventListener(MouseEvent.MOUSE_UP, function temp102(Event:MouseEvent):void{buyItem(103)});
				} else if (i == 104){
					SelectionArr[count].descriptionTxt.text = "LONG SWORD";
					SelectionArr[count].equippableTxt.text = "*Equippable*";
					SelectionArr[count].descriptionTxt.text = "Slice";
					tempImage = new itemStoneSword();tempImage.x = startX - 400; tempImage.y = 0; SelectionArr[count].addChild(tempImage);
					tempImage = new CloseRange(); tempImage.x = startX - 295; tempImage.y = 12; tempImage.width = 40; tempImage.height = 40; SelectionArr[count].addChild(tempImage);
					tempImage = new itemStone(); tempImage.x = startX - 330; tempImage.y = 40; SelectionArr[count].addChild(tempImage);
					tempImage = new itemSteel(); tempImage.x = startX - 260; tempImage.y = 40; SelectionArr[count].addChild(tempImage);
					SelectionArr[count].cost1Txt.text = "50";
					SelectionArr[count].cost2Txt.text = "10";
					if (_root.woodSupply < 50 || _root.ironSupply < 10){
						SelectionArr[count].transform.colorTransform = dim;
					}
					SelectionArr[count].buildBtn.addEventListener(MouseEvent.MOUSE_UP, function temp103(Event:MouseEvent):void{buyItem(104)});
				} else if (i == 200){
					SelectionArr[count].descriptionTxt.text = "LUMBER MILL";
					SelectionArr[count].equippableTxt.text = "*Equippable*";
					SelectionArr[count].descriptionTxt.text = "Make";
					tempImage = new itemMill();tempImage.x = startX - 400; tempImage.y = 0; SelectionArr[count].addChild(tempImage);
					tempImage = new repairImage(); tempImage.x = startX - 295; tempImage.y = 12; tempImage.width = 40; tempImage.height = 40; SelectionArr[count].addChild(tempImage);
					tempImage = new itemWood(); tempImage.x = startX - 330; tempImage.y = 40; SelectionArr[count].addChild(tempImage);
					tempImage = new itemStone(); tempImage.x = startX - 260; tempImage.y = 40; SelectionArr[count].addChild(tempImage);
					tempImage = new itemSteel(); tempImage.x = startX - 190; tempImage.y = 40; SelectionArr[count].addChild(tempImage);
					SelectionArr[count].cost1Txt.text = "40";
					SelectionArr[count].cost2Txt.text = "20";
					SelectionArr[count].cost3Txt.text = "5";
					if (_root.woodSupply < 40 || _root.stoneSupply < 20 || _root.ironSupply < 5){
						SelectionArr[count].transform.colorTransform = dim;
					}
					SelectionArr[count].buildBtn.addEventListener(MouseEvent.MOUSE_UP, function temp200(Event:MouseEvent):void{buyItem(200)});
				} else {
					SelectionArr[count].descriptionTxt.text = "INSERT NAME";
					tempImage = new itemSword(); tempImage.x = startX - 400; tempImage.y = 0; SelectionArr[count].addChild(tempImage);
					tempImage = new CloseRange(); tempImage.x = startX - 295; tempImage.y = 12; tempImage.width = 40; tempImage.height = 40; SelectionArr[count].addChild(tempImage);
					tempImage = new itemWood(); tempImage.x = startX - 330; tempImage.y = 40; SelectionArr[count].addChild(tempImage);
					tempImage = new itemStone(); tempImage.x = startX - 260; tempImage.y = 40; SelectionArr[count].addChild(tempImage);
					tempImage = new itemSteel(); tempImage.x = startX - 190; tempImage.y = 40; SelectionArr[count].addChild(tempImage);
					SelectionArr[count].buildBtn.addEventListener(MouseEvent.MOUSE_UP, function temp1000(Event:MouseEvent):void{buyItem(1000)});
				}
				this.addChild(SelectionArr[count]);
				count++;
				if (count == 3){
					this.setChildIndex(upBtn, this.numChildren-1);
					this.setChildIndex(downBtn, this.numChildren-1);
				}
			}
		}
		private function removeSelections():void{
			for (var i:int = 0;i < 3;i++){
				if (SelectionArr[i]){
					SelectionArr[i].parent.removeChild(SelectionArr[i]);
				}
			}
		}
		private function buyItem(whichItemBuying:int):void{
			var inventoryHasOpenSlot:Boolean;
			for (var i:int = 4;i < _root.inventory.length;i++){
				if (_root.inventory[i] == 0 || _root.inventory[i] == null){
					inventoryHasOpenSlot = true;
					break;
				}
			}
			if (inventoryHasOpenSlot){
				if (whichItemBuying == 100){
					if (_root.woodSupply >= 40 && _root.stoneSupply >= 25){
						_root.woodSupply -= 40;
						_root.stoneSupply -= 25;
						_root.pickUpItemUsingTag(3003);
						if (_root.instructionalStep == 1){
							_root.instructionalStep = 2;
							_root.createTopMessage();
						}
					}
				} else if (whichItemBuying == 101){
					if (_root.woodSupply >= 50){
						_root.woodSupply -= 50;
						_root.pickUpItemUsingTag(3000);
						if (_root.instructionalStep == 5){
							_root.instructionalStep = 6;
							_root.createTopMessage();
						}
					}
				} else if (whichItemBuying == 102){
					if (_root.woodSupply >= 30){
						_root.woodSupply -= 30;
						_root.pickUpItemUsingTag(3002);
					}
				} else if (whichItemBuying == 103){
					if (_root.woodSupply >= 50){
						_root.woodSupply -= 50;
						_root.pickUpItemUsingTag(3005);
					}
				} else if (whichItemBuying == 104){
					if (_root.stoneSupply >= 50 && _root.ironSupply >= 10){
						_root.stoneSupply -= 50;
						_root.ironSupply -= 10;
						_root.pickUpItemUsingTag(3006);
					}
				} else if (whichItemBuying == 200){
					if (_root.woodSupply >= 40 && _root.stoneSupply >= 20 && _root.ironSupply >= 5){
						_root.woodSupply -= 40;
						_root.stoneSupply -= 20;
						_root.ironSupply -= 5;
						_root.pickUpItemUsingTag(2001);
					}
				}
				setTab((int)(whichItemBuying/100));
			}
		}
		private function destroyThis(event:Event):void{
			
		}
	}
	
}
