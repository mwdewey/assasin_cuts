package;
import flixel.FlxSprite;
import flixel.system.scaleModes.FillScaleMode;
import flixel.util.FlxColor;
import flixel.FlxG;

/**
 * ...
 * @author robert
 */
class Ogre extends FlxSprite  
{

	public var maxSpeed:Float = 200;
	//define AI variables
	
	
	public function new(X:Float=0, Y:Float=0) {
		super(X, Y);
		
		//Load Ogre art
		makeGraphic(256, 256, FlxColor.FUCHSIA); //replace with Ogre Art
		
		//horizontal drag
		drag.x = 450;	
	}
	
	override public function update():Void {
		movement();
		super.update();
	}
	
	private function movement():Void {
		//define variables checking left/right movement
		var _left:Bool = false;
		var _right:Bool = false;
		//check if left or right keys are pressed
		_left = FlxG.keys.anyPressed(["LEFT", "A"]);
		_right = FlxG.keys.anyPressed(["RIGHT", "D"]);
		
		//cannot move left and right at the same time
		if (_left && _right) _left = _right = false;
		//change speed and direction
		if (_left) {
			velocity.x = -maxSpeed;
		}
		else if (_right) {
				velocity.x = maxSpeed;
		}
	}
	
}
