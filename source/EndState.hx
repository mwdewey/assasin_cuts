package;
import flixel.FlxState;
import flixel.FlxG;

/**
 * ...
 * @author ...
 */
class EndState extends FlxState
{

	public function new() 
	{
		super();
	}
	
	public override function create() {
		super.create();
		
		FlxG.sound.pause();
	}
}