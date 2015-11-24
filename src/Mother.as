package  
{
	import flash.events.Event;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class Mother extends MotherGraphic
	{
		public var bulletReserve:int = 0;
		public var bulletReserveMax:int = 500;
		public var bulletReloadRate:int = 1;
		
		public function Mother() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		public function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		override public function frame():void
		{
			if (bulletReserve < bulletReserveMax)
			{
				bulletReserve += bulletReloadRate;
			}
			updateBulletMeter();
		}
		
		public function updateBulletMeter():void
		{
			graphics.clear();
			graphics.beginFill(0xFF00FF, 1);
			graphics.drawRect( -50, -30, (bulletReserve/bulletReserveMax)*100, 5);
			graphics.endFill();
			graphics.lineStyle(1, 0xFFFFFF);
			graphics.drawRect( -51, -31, 101, 6);
		}
	}

}