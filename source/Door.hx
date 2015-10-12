package;

/**
 * ...
 * @author ...
 */
class Door extends FlxSprite
{

	var pos_x:Int;
	var pos_y:Int;

	public function new(pos_x:Int, pos_y:Int) 
	{
		super();
		
		this.loadGraphic("assets/images/Door.png", true, 64, 96);
		animation.add("run_right", [5, 7, 9, 11,9,7], 8, true);
		
		this.setPosition(pos_x,pos_y);
		this.immovable = true;
	}
	
	override public function update():Void
	{
		super.update();
		
	}
	
}