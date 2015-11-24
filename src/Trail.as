package  
{
	import com.greensock.plugins.ColorTransformPlugin; 
	import com.greensock.plugins.TintPlugin;
	import com.greensock.plugins.TweenPlugin;
	import com.greensock.TweenMax;
	import flash.geom.ColorTransform;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class Trail extends TrailGraphic
	{
		public function Trail(speed:int = 15, tintColor:uint = 0xFF0000 ) 
		{
			TweenPlugin.activate([ColorTransformPlugin, TintPlugin]);
			TweenMax.to(this,  speed, { useFrames:true, colorTransform: { tint:tintColor, tintAmount:1 }, alpha:0, scaleX:0.5, scaleY:0.5, onComplete:kill} );
		}
		
		
		
		override public function frame():void
		{
			
		}
		
		override public function kill():void
		{
			DataManager.effects.splice(DataManager.effects.indexOf(this), 1);
			super.kill();
		}
		
	}

}