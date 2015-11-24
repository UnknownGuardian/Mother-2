package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class PlayState extends GameState
	{
		public var isPaused:Boolean = false;
		
		public function PlayState() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		public function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			stage.addEventListener(Event.ENTER_FRAME, frame);
			stage.addEventListener(KeyboardEvent.KEY_UP, kUp);
			
			createGame();
			createBackgroundLayer();
			createItemsLayer();
			createBulletsLayer();
			createShipLayer();
			createEffectsLayer();
			createHUDLayer();
			createMother();
		}
		public function createGame():void {
			Layers.Game = this;
		}
		public function createBackgroundLayer():void {
			//var b:Background = new Background();
			var b:Sprite = new Sprite();
			Layers.Background = b;
			stage.addChild(b);
		}
		public function createItemsLayer():void {
			var i:Sprite = new Sprite();
			Layers.Background.addChild(i);
			Layers.Items = i;
		}
		public function createBulletsLayer():void {
			var b:Sprite = new Sprite();
			Layers.Background.addChild(b);
			Layers.Bullets = b;
		}
		public function createShipLayer():void {
			var s:Sprite = new Sprite();
			Layers.Background.addChild(s);
			Layers.Ships = s;
		}
		public function createEffectsLayer():void {
			var e:Sprite = new Sprite();
			Layers.Background.addChild(e);
			Layers.Effects = e;
		}
		public function createHUDLayer():void {
			var h:Sprite = new Sprite();
			Layers.Display = h;
			stage.addChild(h);
			
			var d:BetterUpgradeBar = new BetterUpgradeBar();
			d.x = 560;
			d.y = 240;
			h.addChild(d);
			
			//_hud = new HUD();
			//stage.addChild(_hud);
			//Layers.Display = _hud;
		}
		public function createMother():void {
			DataManager.mother = new Mother();
			DataManager.mother.x = 240;
			DataManager.mother.y = 240;
			DataManager.effects.push(DataManager.mother);
			
			/*
			var c:Child = new Child();
			c.x = Math.random()*300 + 170;
			c.y = Math.random()*140 + 170;
			DataManager.children.push(c);
			Layers.Ships.addChild(c);
			*/
			
			for (var i:int = 0; i < 5; i++)
			{
				var c:Child = new Child();
				//c.x = Math.random()*300 + 170;
				c.x = Math.random()*440 + 20;
				//c.y = Math.random()*140 + 170;
				c.y = Math.random()*440 + 20;
				DataManager.children.push(c);
				Layers.Ships.addChild(c);
			}
			
			
			Layers.Ships.addChild(DataManager.mother);
		}
		
		
		
		//util
		public function kUp(e:KeyboardEvent):void {
			if (e.keyCode == 32) //space
			{
				isPaused = !isPaused;
			}
		}
		public function frame(e:Event):void	{
			if (isPaused) return;
			
			for (var i:int = DataManager.effects.length-1; i >=0; i--)
			{
				DataManager.effects[i].frame();
			}
			var b:Entity;
			for (i = DataManager.allyBullets.length - 1; i >= 0; i--)
			{
				b = DataManager.allyBullets[i];
				b.frame();
			}
			for (i = DataManager.children.length-1; i >= 0; i--)
			{
				b = DataManager.children[i];
				b.frame();
			}
			
			/*
			if (DataManager.children.length == 0)
			{
				//game over
				isPaused = true;
				stage.removeEventListener(Event.ENTER_FRAME, frame);
				stage.removeEventListener(KeyboardEvent.KEY_UP, kUp);
			}
			*/
		}
		
	}

}