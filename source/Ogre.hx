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
 * @author Robert
 */

 
 class Ogre extends FlxSprite  
{
	//movement and position
	public var maxSpeed:Float;
	public var movePoint:FlxPoint;  //this is the point that the ogre automatically walks towards
	public var centerX:Float;
	public var centerY:Float;
	
	//health
	public var startHP:Float;
	public var HP:Float;
	
	//AI variables
	public var _brain:FSM; //FSM that keeps track of current sprite-state
	private var Timer:Float; //timer used for time-dependent sprite-states
	private var stunLimit:Float; //length of stun sprite-state
	private var attackLimit:Float; //length of attack sprite-state
	public var isMove:Bool; //checks if in move state
	
	//attack
	public var swingDist:Float; //Range of ogre's swing attack
	public var damage:Float; //damage dealt by attack
	public var hitsPlayer:Bool; //becomes true if an attakc connects with the player
	
	public var _player:HairDresser;
	
	
	public function new(X:Float=0, Y:Float=0, player:HairDresser) {
		super(X, Y);
		
		//Load Ogre art
		this.makeGraphic(256, 256, FlxColor.FUCHSIA); //replace with Ogre Art
		
		//define variables
		drag.x = 450;
		maxSpeed = 200;
		centerX = this.width / 2;
		centerY = this.height / 2;
		
		//reference player sprite
		_player = player;
		//ogre moves horizontally towards player.  
		//Set a point using the player's x-position and a fixed y-position
		movePoint = new FlxPoint(_player.centerX, Y + 128);
		
		//_brain starts in stun
		_brain = new FSM(stun);
		isMove = false;
		stunLimit = 50;
		attackLimit = 50;
		Timer = stunLimit;
		
		//set attack variables
		swingDist = 100;
		damage = 20;
		hitsPlayer = false;
		
		//set HP
		startHP = 100;
		HP = startHP;
	}
	
	
	//FSM states
	public function stun():Void {
		//when timer runs out, switch to move state
		if (Timer <= 0) {
			_brain.activeState = move;
			isMove = true;
			this.color = FlxColor.BLUE;
		}
		else
			Timer -= 1;
	}
	
	public function move():Void {
		//move towards player
		FlxVelocity.moveTowardsPoint(this, movePoint, Std.int(maxSpeed));
		//if player is within swingDist AND not above ogre, switch to attack state
		/*if (Math.abs((this.x + this.centerX) - (_player.x + _player.centerX)) <= swingDist && (_player.y + _player.centerY) >= this.y) {
			Timer = stunLimit;	
			_brain.activeState = attack;
			this.color = FlxColor.RED;
		}*/
	}
	
	public function attack():Void {
		//If player is still overlapped with ogre, it takes damage
		if (Timer < (attackLimit * .75) && !hitsPlayer) {
			FlxG.overlap(this, _player, dealDamage);
		}
		//when timer runs out, switch to move state
		if (Timer <= 0) {
			_brain.activeState = move;
			hitsPlayer = false;
			isMove = true;
			this.color = FlxColor.BLUE;
		}
		else
			Timer -= 1;
	}
	
	public function dealDamage(Object1:FlxObject, Object2:FlxObject):Void {
		_player.takeDamage(damage);
		hitsPlayer = true;
	}
	
	//takes damage; switches to stun
	public function takeDamage(damage:Float) {
		HP -= damage;
		//if not already stunned, set timer and switch to stun
		if (_brain.activeState != stun) {
			Timer = stunLimit;
			_brain.activeState = stun;
			isMove = false;
			this.color = FlxColor.FUCHSIA;
		}
	}
	
	//triggers transition to attack sprite-state
	public function startAttack():Void {
		Timer = attackLimit;
		_brain.activeState = attack;
		isMove = false;
		this.color = FlxColor.RED;
	}
	
	
	override public function update():Void {
		//update movePoint with player's position
		movePoint.x = _player.x;
		//update FSM
		_brain.update();
		
		super.update();
	}
	
	override public function draw():Void {
		if (velocity.x < 0 ) facing = FlxObject.LEFT;
		else if (velocity.x > 0) facing = FlxObject.RIGHT;
		super.draw();
	}
	
}