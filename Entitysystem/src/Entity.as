package {
	import components.VelocityComponent;
	import components.PositionComponent;
	import components.DisplayComponent;
	/**
	 * @author berendweij
	 */
	public class Entity {
		
		// de entity heeft standaard de volgende componenten
		// volgende week maken we dit 'abstracter'
		private var _display 	:	DisplayComponent;
		private var _position	:	PositionComponent;
		private var _velocity	:	VelocityComponent;
		
		public function Entity(display : DisplayComponent, position : PositionComponent, velocity : VelocityComponent) : void
		{
			this.display	=	display;
			this.position	=	position;
			this.velocity	=	velocity;
		}
		
		public function get display() : DisplayComponent {
			return _display;
		}

		public function set display(display : DisplayComponent) : void {
			_display = display;
		}

		public function get position() : PositionComponent {
			return _position;
		}

		public function set position(position : PositionComponent) : void {
			_position = position;
		}

		public function get velocity() : VelocityComponent {
			return _velocity;
		}

		public function set velocity(velocity : VelocityComponent) : void {
			_velocity = velocity;
		}
		
	}
}
