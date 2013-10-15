package systems {
	import components.VelocityComponent;
	import components.PositionComponent;
	import components.CollisionComponent;
	import components.DisplayComponent;
	/**
	 * @author berendweij
	 */
	public class CollisionSystem extends System {
		
		override public function update():void
		{
			var position : PositionComponent;
			var world	: Entity;
			
			// in deze update staat de logica om de objecten te checken op collision
			for each( var target:Entity in targets )
			{
				// aangezien we door alle targets heen loopen moeten we ook kijken of deze target wel de components
				// die wij nodig hebben
				if (target.get(VelocityComponent) && target.get(PositionComponent))
				{
					// voor de leesbaarheid sla ik de positie op in een lokale variabele
					position = target.get(PositionComponent) as PositionComponent;
					world = (target.get(CollisionComponent) as CollisionComponent).world;
					
					// als de positie binnen de wereld valt dan zitten we in de grond. Dat willen we niet
					// dus: we moeten ons object met logica naar boven zetten
					if ( world.get(DisplayComponent).view.hitTestPoint(position.x, position.y, true) )
					{
						// we zetten de velocity op 0 aangezien we niet meer kunnen vallen
						target.get(VelocityComponent).velocityY = 0;
						while (world.get(DisplayComponent).view.hitTestPoint(position.x, position.y, true))
						{
							// we loopen net zo langs totdat we boven de grond staan
							position.y--;
						}
						
					}
					
				}
			}
		}
		
	}
}
