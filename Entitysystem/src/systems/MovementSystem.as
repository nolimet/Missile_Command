package systems {
	/**
	 * @author berendweij
	 */
	public class MovementSystem extends System {
		
		override public function update():void
		{
			// in deze update staat de logica om de objecten te laten bewegen
			for each( var target:Entity in targets )
			{
				if(target.position.x < 0)
				{
					// als we links uit het scherm zijn: rij dan weer terug (Math.abs() maakt de snelheid positief)
					target.velocity.velocityX	= Math.abs(target.velocity.velocityX);
				}
				else if(target.position.x > 600)
				{
					// als we rechts uit het scherm zijn: rij dan weer terug
					target.velocity.velocityX	= -Math.abs(target.velocity.velocityX); 
				}
				
				// zorg ervoor dat we visueel echt laten zien hoe de game er op dit moment uitziet
				target.position.x			+=	target.velocity.velocityX;
				target.position.y 			+=	target.velocity.velocityY;
				target.position.rotation	+=	target.velocity.angularVelocity;
			}
		}
		
	}
}
