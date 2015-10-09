package;
import flixel.FlxSprite;
import flixel.system.scaleModes.FillScaleMode;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.util.FlxPoint;

/**
 * ...
 * @author robert
 */
class Ogre extends FlxSprite  
{

	public var maxSpeed:Float = 200;
	//define AI variables
	private var _brain:FSM;
	private var stunTimer:Float;
	public var stunLimit:Int;
	public var swingDist:Float;
	public var playerPos(default, null):FlxPoint;
	
	
	
	
	public function new(X:Float=0, Y:Float=0) {
		super(X, Y);
		
		//Load Ogre art
		makeGraphic(256, 256, FlxColor.FUCHSIA); //replace with Ogre Art
		
		//horizontal drag
		drag.x = 450;	
	}
	
	
	override public function update():Void {
		//STUN STATE
		//Initial state
		//triggered when enough damage is sustained in other states
		//-run stunned animation, play until timer runs out
		//-when timer is done, goto Move State
		
		//MOVE STATE
		//-Track Player Position
		//-Update movement in direction of player, run move animation
		movement();
		//-If within certain range of player, goto Attack State
		//-If enough damage is sustained, goto Stun State
		
		//ATTACK STATE
		//-run attack animation; if weapon hitbox connects, deal damage
		//-delay short period of time
		//-If enough damage is sustained, goto Stun State
		//-otherwise, goto Move State
		
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
	
	
	override public function draw():Void {
		if (velocity.x < 0 ) facing = FlxObject.LEFT;
		super.draw();
	}
	
}

class FSM {
	
	public var activeState:Void->Void;

     public function new(?InitState:Void->Void):Void
     {
         activeState = InitState;
     }

     public function update():Void
     {
         if (activeState != null)
             activeState();
     }
}