package factories 
{
	import adobe.utils.CustomActions;
	import components.DisplayComponent;
	import components.PositionComponent;
	import components.VelocityComponent;
	/**
	 * ...
	 * @author Berend Weij
	 */
	public class CarFactory 
	{
		
		public static var SPORTSCAR	:	String	=	"sportsCar";
		
		public function CarFactory() 
		{
			
		}
		
		public  function makeCar(type : String) : Entity
		{
			
			// we maken de componenten aan. Hier kan het systeem zijn 'data' in opslaan
			// met data kunnen we waardes opslaan (positie, rotatie, etc.)
			if (type == SPORTSCAR)
			{
				var display	:	DisplayComponent		=	new DisplayComponent();
				display.view							=	new CarImage();
			}
			
			var position	:	PositionComponent	=	new PositionComponent();
			position.x								=	Math.random() * 600;
			position.y								=	200;
			
			var velocity	:	VelocityComponent	=	new VelocityComponent();
			velocity.velocityX						=	Math.random() * 10 - 5;
			velocity.velocityY						=	0;
			
			// als laatste maken we onze entity aan
			// de entity bestaat uit componenten.
			var car	:	Entity						=	new Entity();
			
			// we voegen de componenten toe aan de entity car
			// hiermee bepalen we het gedrag van deze entity
			car.add(display);
			car.add(position);
			car.add(velocity);
			
			
			return car;
		}
		
	}

}