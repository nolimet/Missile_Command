package systems {
	import components.VelocityComponent;
	import components.PositionComponent;
	import components.DisplayComponent;
	/**
	 * @author berendweij
	 */
	public class MovementSystem extends System {
		
		override public function update():void
		{
			// in deze update staat de logica om de objecten te laten bewegen
			for each( var target:Entity in targets )
			{
				// aangezien we door alle targets heen loopen moeten we ook kijken of deze target wel de components
				// die wij nodig hebben
				if (target.get(PositionComponent) && target.get(VelocityComponent))
				{
					if(target.get(PositionComponent).x < 15)
					{
						// als we links uit het scherm zijn: rij dan weer terug (Math.abs() maakt de snelheid positief)
						target.get(VelocityComponent).velocityX	= Math.abs(target.get(VelocityComponent).velocityX);
					}
					else if(target.get(PositionComponent).x > 700)
					{
						// als we rechts uit het scherm zijn: rij dan weer terug
						target.get(VelocityComponent).velocityX	= -Math.abs(target.get(VelocityComponent).velocityX); 
					}
					
					// kijken welke k
					if(target.get(VelocityComponent).velocityX > 0)
					{
						// we rijden naar rechts, dus laat de auto naar rechts kijken
						target.get(DisplayComponent).view.scaleX	=	1;
					}
					else
					{
						// we rijden naar links, dus laat de auto naar links kijken
						target.get(DisplayComponent).view.scaleX	=	-1;
					}///////
					
					// zorg ervoor dat we visueel echt laten zien hoe de game er op dit moment uitziet
					target.get(PositionComponent).x			+=	target.get(VelocityComponent).velocityX;
					target.get(PositionComponent).y 		+=	target.get(VelocityComponent).velocityY;
					target.get(PositionComponent).rotation	+=	target.get(VelocityComponent).angularVelocity;
				}
			}
		}
		
	}
}
