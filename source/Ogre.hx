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
	public var centerX:Float;
	public var centerY:Float;
	public var HP:Float;
	//define AI variables
	private var _brain:FSM;
	private var stunTimer:Float;
	private var stunLimit:Float;
	public var swingDist:Float;
	public var movePoint:FlxPoint;
	public var _player:HairDresser;
	
	
	
	public function new(X:Float=0, Y:Float=0, player:HairDresser) {
		super(X, Y);
		
		//Load Ogre art
		this.makeGraphic(256, 256, FlxColor.FUCHSIA); //replace with Ogre Art
		
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
		//set the center x and y coordinates of ogre
		centerX = this.width / 2;
		centerY = this.height / 2;
		//ogre moves horizontally towards player.  
		//Set a point using the player's x-position and a fixed y-position
		movePoint = new FlxPoint(_player.centerX, Y + 128);
		//set HP
		HP = 100;
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
		if (Math.abs((this.x + this.centerX) - (_player.x + _player.centerX)) <= swingDist && (_player.y + _player.centerY) >= this.y) {
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
	
	//function for taking damage; switches to stun
	public function takeDamage(damage:Float) {
		HP -= damage;
		//if not already stunned, set timer and switch to stun
		if (_brain.activeState != stun) {
			stunTimer = stunLimit;
			_brain.activeState = stun;
			this.color = FlxColor.FUCHSIA;
		}
	}
	
	
	override public function update():Void {
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