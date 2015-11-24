package  
{
	/**
	 * ...
	 * @author UnknownGuardian
	 */
	public class Child extends ChildGraphic
	{
		public var isReloading:Boolean = false;
		public var shootMax:int;
		public var shootReload:int;
		public var bullets:Number;
		public var bulletMax:int;
		
		public var lifeMax:int;
		public var force:int;
		
		public var reloadBulletDelay:int = 0;
		public var reloadBulletDelayMax:int = 2;
		
		public var isHeld:Boolean = false;
		
		public function Child() 
		{
			shootMax = DataManager.childShotSpeed;
			shootReload = 0;
			bulletMax = DataManager.childMaxAmmo;
			bullets = bulletMax;
			lifeMax = DataManager.childLife;
			life = lifeMax;
			force = DataManager.childForce;
			reloadBulletDelayMax = DataManager.childTransferRate;
			reloadBulletDelay = 0;
		}
		
		override public function frame():void
		{
			if (isHeld)
			{
				x = stage.mouseX;
				y = stage.mouseY;
				return;
			}
			
			updateInfoDisplay();
			life-=0.15;
			if (life < 0)
			{
				kill();
				return;
			}
			
			if (isReloading)
			{
				//Layers.Effects.graphics.lineStyle(2, 0xFF00FF);
				//Layers.Effects.graphics.moveTo(x, y);
				//Layers.Effects.graphics.lineTo(DataManager.mother.x, DataManager.mother.y);
				reloadBulletDelay++;
				if (reloadBulletDelay > reloadBulletDelayMax)
				{
					reloadBulletDelay = 0;
					if (DataManager.mother.bulletReserve > 0)
					{
						DataManager.mother.bulletReserve--;
						bullets++;
						if (bullets == bulletMax)
						{
							isReloading = false;
							Layers.Effects.graphics.clear();
						}
					}
				}
				
				/*
				bullets += 0.5;
				if (bullets % 1 == 0)
				{
					DataManager.mother.bulletReserve--;
				}
				if (bullets == bulletMax)
				{
					isReloading = false;
				}
				*/
				return;
			}
			
			shootReload++;
			if (shootReload >= shootMax)
			{
				shootReload = 0;
				bullets--;
				if (bullets <= 0)
				{
					isReloading = true;
				}
				
				var bu:Bullet = new Bullet(8);
				bu.x = x;
				bu.y = y;
				bu.rotation = Math.random() * 360;
				DataManager.allyBullets.push(bu);
				Layers.Bullets.addChild(bu);
			}
		}
		
		public function updateInfoDisplay():void
		{
			graphics.clear();
			graphics.beginFill(0xFF00FF, 1);
			graphics.drawRect( -20, -15, (bullets/bulletMax)*40, 4);
			graphics.endFill();
			graphics.beginFill(0x5DFC0A, 1);
			graphics.drawRect( -20, -19, (life / lifeMax) * 40, 4);

			if (isReloading)
			{
				graphics.lineStyle(2, 0xFF00FF);
				//graphics.moveTo(width / 2, height / 2);
				graphics.moveTo(0, 0);
				graphics.lineTo(DataManager.mother.x-x, DataManager.mother.y-y);
				//graphics.lineTo(100, 100);
			}
		}
		
		override public function kill():void
		{
			graphics.clear();
			super.kill();
			DataManager.children.splice(DataManager.children.indexOf(this), 1);
		}
		
	}

}