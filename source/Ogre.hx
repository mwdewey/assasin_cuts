package;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.system.scaleModes.FillScaleMode;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.util.FlxPoint;
import flixel.util.FlxVelocity;
import flixel.util.FlxSpriteUtil;
import flixel.tweens.FlxEase;


/**
 * ...
 * @author Robert
 */

 
 class Ogre extends FlxSprite  
{
	//group that stores ogre sprites
	 public var spriteList:FlxGroup;
	 
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
		loadGraphic("assets/images/Characters/Ogre/Ogre.png", true, 160, 160);
		setFacingFlip(FlxObject.RIGHT, false, false);
		setFacingFlip(FlxObject.LEFT, true, false);
		//run animations
		animation.add("run_right", [0,1,2,1], 8, true);
		//attack animations
		animation.add("hammer_right", [3, 4, 5, 5, 5], 6, false);
		//idle animations
		animation.add("idle_right", [1]);
		
		//define variables
		drag.x = 450;
		maxSpeed = 200;
		centerX = this.width / 2;
		centerY = this.height / 2;
		
		//reference player sprite
		_player = player;
		//ogre moves horizontally towards player.  
		//Set a point using the player's x-position and a fixed y-position
		movePoint = new FlxPoint(_player.centerX, Y + 64);
		
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
	
		setPosition(X, Y);
	}
	
	
	//FSM states
	public function stun():Void {
		animation.play("idle_right");
		//when timer runs out, switch to move state
		if (Timer <= 0) {
			_brain.activeState = move;
			isMove = true;
		}
		else
			Timer -= 1;
	}
	
	public function move():Void {
		//move towards player
		FlxVelocity.moveTowardsPoint(this, movePoint, Std.int(maxSpeed));
		if (this.velocity.x > 0) { 
			facing = FlxObject.RIGHT; 
			animation.play("run_right");
		}
		else if (this.velocity.x < 0) { 
			facing = FlxObject.LEFT; 
			animation.play("run_right");
		}
		else {
			animation.play("idle_right");
		}
	}
	
	public function attack():Void {
		//when animation is finished, switch to move state
		if (animation.finished) {
			_brain.activeState = move;
			hitsPlayer = false;
			isMove = true;
		}
		animation.play("hammer_right");
		//If player is still overlapped with ogre, it takes damage
		if (animation.curAnim.curFrame == 1) {
			FlxG.overlap(this, _player, dealDamage);
		}
	}
	
	public function dealDamage(Object1:FlxObject, Object2:FlxObject):Void {
		if (!hitsPlayer) {
			hitsPlayer = true;	
			_player.takeDamage(damage);
		}
	}
	
	//takes damage; switches to stun
	public function takeDamage(damage:Float) {
		HP -= damage;
		//if not already stunned, set timer and switch to stun
		if (_brain.activeState != stun) {
			Timer = stunLimit;
			_brain.activeState = stun;
			//halt abruptly
			velocity.x = 0;
			isMove = false;
		}
	}
	
	//triggers transition to attack sprite-state
	public function startAttack():Void {
		Timer = attackLimit;
		_brain.activeState = attack;
		isMove = false;
	}
	
	
	override public function update():Void {
		//update movePoint with player's position
		movePoint.x = _player.x;
		//update FSM
		_brain.update();
		
		super.update();
	}
	
	//fades when kill is called
	override public function kill():Void
	{
		alive = false;
		FlxTween.tween(this, { alpha:0, y:y - 16 }, .5, { ease:FlxEase.circOut, complete:finishKill } );
	}

	private function finishKill(_):Void
	{
		exists = false;
	}
}