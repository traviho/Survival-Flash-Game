package  {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.media.Sound; 
	
	public class Player extends MovieClip{
		
		private var _root:*;
		public var speed:int;
		private var ran:Boolean;
		
		public function Player(passedSpeed:int):void {
			speed = passedSpeed;
			this.addEventListener(Event.ADDED, beginClass);
		}

		private function beginClass(e:Event):void{
			if (!ran){
				ran = true;
				_root = MovieClip(root);
				this.addEventListener(Event.ENTER_FRAME, loop);
				addEventListener(Event.REMOVED_FROM_STAGE, destroyThis);
			}
		}

		private function loop(e:Event):void{
			if (_root.leftPressed && _root.downPressed){
				rotation = -135;
				walk(-135);
			} else if (_root.leftPressed && _root.upPressed){
				rotation = -45;
				walk(-45);
			} else if (_root.upPressed && _root.rightPressed){
				rotation = 45;
				walk(45);
			} else if (_root.rightPressed && _root.downPressed){
				rotation = 135;
				walk(135);
			} else if(_root.leftPressed){
				rotation = -90;
				walk(-90);
            } else if(_root.rightPressed){
				rotation = 90;
				walk(90);
            } else if(_root.upPressed){
				walk(0);
				rotation = 0;
            } else if(_root.downPressed){
				walk(180);
				rotation = 180;
            } else {
				this.gotoAndPlay("stand");
			}
		}
		private function walk(ang:Number):void{
			if (this.currentFrame == 1){
				this.gotoAndPlay("walk1");
			}
			switch(ang){
				case -135:
					x -= (speed * 1.41421356) * .5;
					y += (speed * 1.41421356) * .5;;
					break;
				case -90:x -= speed;break;
				case -45:
					x -= (speed * 1.41421356) * .5;
					y -= (speed * 1.41421356) * .5;;
					break;
				case 0:y -= speed;break;
				case 45:
					x += (speed * 1.41421356) * .5;
					y -= (speed * 1.41421356) * .5;;
					break;
				case 90:x += speed;break;
				case 135:
					x += (speed * 1.41421356) * .5;
					y += (speed * 1.41421356) * .5;;
					break;
				case 180:y += speed;break;
			}
		}
		private function destroyThis(event:Event):void{
			removeEventListener(Event.ENTER_FRAME, loop);
		}

	}
	
}
