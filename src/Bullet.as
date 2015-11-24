package  
{
	import flash.events.Event;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class Bullet extends BulletGraphic
	{
		public var speed:Number;
		public var xSpeed:Number = 0;
		public var ySpeed:Number = 0;
		
		public function Bullet(s:Number) 
		{
			speed = s;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		public function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			xSpeed = Math.cos(rotation * (Math.PI / 180)) * speed;
			ySpeed = Math.sin(rotation * (Math.PI / 180)) * speed;
		}
		
		
		
		//overrides
		override public function frame():void
		{
			x += xSpeed;
			y += ySpeed;
			if (x > 640 + width || x < -width || y > 480 + height || y < -height)
			{
				kill();
			}
			var t:Trail = new Trail();
			t.x = x;
			t.y = y;
			Layers.Effects.addChild(t);
			DataManager.effects.push(t);
		}
		override public function kill():void
		{
			super.kill()
			DataManager.allyBullets.splice(DataManager.allyBullets.indexOf(this), 1);
		}
	}

}