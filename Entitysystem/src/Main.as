package 
{
	import adobe.utils.CustomActions;
	import components.CollisionComponent;
	import components.DisplayComponent;
	import components.PositionComponent;
	import components.VelocityComponent;
	import factories.CarFactory;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import systems.CollisionSystem;
	import systems.GravitySystem;
	import systems.MovementSystem;
	import systems.RenderSystem;

	public class Main extends Sprite
	{
		private var _engine	:	Engine;
		
		public function Main()
		{
			
			// we maken als eerste de engine aan. Deze is het belangrijkste
			_engine	=	new Engine();
			
			// vervolgens initieren wij de systemen
			// dit doen we door ze toe te voegen aan de engine
			_engine.addSystem(new GravitySystem());
			_engine.addSystem(new MovementSystem());
			_engine.addSystem(new CollisionSystem());
			_engine.addSystem(new RenderSystem());			
			
			// de wereld willen we ook als Entity hebben
			var world : Entity = new Entity();
			
			var worldPosition : PositionComponent = new PositionComponent();
			worldPosition.x = 0;
			worldPosition.y = 300;
			
			var worldDisplay	: DisplayComponent = new DisplayComponent();
			worldDisplay.view = new landscape();
			
			world.add(worldPosition);
			world.add(worldDisplay);
			
			// we hebben 1 component nodig die door alle objecten gebruikt kan worden
			// deze component bevat een verwijzing naar de wereld
			var collision : CollisionComponent = new CollisionComponent();
			collision.world	=	world;
			
			var carFactory	:	CarFactory	=	new CarFactory();
			
			for (var i : int = 0; i < 10; i++)
			{
				var car : Entity	=	carFactory.makeCar(CarFactory.SPORTSCAR);
				car.add(collision);
				addChild(car.get(DisplayComponent).view);
				// registreer de auto bij de engine zodat de game ook gaat werken
				_engine.addEntity(car);
			}
			
			
			_engine.addEntity(world);
			
			// laat de auto ook visueel zien
			// we voegen hem toe aan de stage
			addChild(world.get(DisplayComponent).view);
			
			// start het updaten van het spel
			stage.addEventListener(Event.ENTER_FRAME, updateEngine);
			
		}

		private function updateEngine(e : Event) : void
		{
			_engine.update();
		}
	}
}
