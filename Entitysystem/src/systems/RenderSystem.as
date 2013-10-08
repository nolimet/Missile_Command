package systems {
	/**
	 * @author berendweij
	 */
	public class RenderSystem extends System {
		
		override public function update():void
		{
			// in deze update staat de logica om de objecten visueel te laten zien
			for each( var target:Entity in targets )
			{
				if(target.velocity.velocityX > 0)
				{
					// we rijden naar rechts, dus laat de auto naar rechts kijken
					target.display.view.scaleX	=	1;
				}
				else
				{
					// we rijden naar links, dus laat de auto naar links kijken
					target.display.view.scaleX	=	-1;
				}
				target.display.view.x			=	target.position.x;
				target.display.view.y			=	target.position.y;
				target.display.view.rotation	=	target.position.rotation;
			}
		}
		
	}
}
