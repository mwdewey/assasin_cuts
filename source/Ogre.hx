package;
import flixel.FlxSprite;
import flixel.system.scaleModes.FillScaleMode;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.util.FlxPoint;
import flixel.util.FlxVelocity;

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
	public var stunLimit:Float;
	public var swingDist:Float;
	public var movePoint:FlxPoint;
	public var _player:FlxSprite;
	
	
	public function new(X:Float=0, Y:Float=0, player:FlxSprite) {
		super(X, Y);
		
		//Load Ogre art
		this.makeGraphic(256, 256, FlxColor.FUCHSIA); //replace with Ogre Art
		this.
		//horizontal drag
		drag.x = 450;
		
		//_brain is the FSM
		_brain = new FSM(stun);
		//set limit to stun time, initialize stunTimer to that
		stunLimit = 50;
		stunTimer = stunLimit;
		//radius of ogre's swing. Player takes damage if collides with ogre's swing
		swingDist = 100;
		//reference player sprite
		_player = player;
		//ogre moves horizontally towards player.  
		//Set a point using the player's x-position and a fixed y-position
		movePoint = new FlxPoint(_player.x, Y+128);
	}
	
	
	//FSM states
	public function stun():Void {
		//when timer runs out, switch to move state
		if (stunTimer <= 0) {
			_brain.activeState = move;
			this.color = FlxColor.BLUE;
		}
		else
			stunTimer -= 1;
	}
	
	public function move():Void {
		//move towards player
		FlxVelocity.moveTowardsPoint(this, movePoint, Std.int(maxSpeed));
		
		//if player is within swingDist AND not above ogre, switch to attack state
		if (Math.abs(this.x - _player.x) <= swingDist && _player.y >= movePoint.y) {
			stunTimer = stunLimit;	
			_brain.activeState = attack;
			this.color = FlxColor.RED;
		}
	}
	
	public function attack():Void {
		//when timer runs out, switch to move state
		if (stunTimer <= 0) {
			_brain.activeState = move;
			this.color = FlxColor.BLUE;
		}
		else
			stunTimer -= 1;
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
		//-If within certain range of player, goto Attack State
		//-If enough damage is sustained, goto Stun State
		
		//ATTACK STATE
		//-run attack animation; if weapon hitbox connects, deal damage
		//-delay short period of time
		//-If enough damage is sustained, goto Stun State
		//-otherwise, goto Move State
		
		//update movePoint with player's position
		movePoint.x = _player.x;
		_brain.update();
		super.update();
	}
	
	
	override public function draw():Void {
		if (velocity.x < 0 ) facing = FlxObject.LEFT;
		else if (velocity.x > 0) facing = FlxObject.RIGHT;
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