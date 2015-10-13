package;
import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.Lib;
import flixel.FlxGame;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxCamera;
import flixel.util.FlxPoint;
import flixel.FlxObject;

using flixel.util.FlxSpriteUtil;




class HairDresser extends FlxSprite
{
	//movement and position
	public static var MAX_SPEED:Int = 1000;
	public static var SPEED:Int = 850;
	public var centerX:Float;
	public var centerY:Float;
	public var isOnGround:Bool;
	public var face_left:Bool = false;
	
	//Attack and Control variables
	public var _brain:FSM; //FSM that keeps track of current sprite-state
	private var Timer:Float; //timer used for time-dependent sprite-states
	private var stunLimit:Float; //length of stun sprite-state
	private var attackLimit:Float; //length of attack sprite-state
	public var isMove:Bool; //checks if in move state
	
	//health
	public var startHP:Float;
	public var HP:Float;
	
	public function new() 
	{
		super();
		
		//player starts in air
		isOnGround = false;
		
		//camera follows this object
		FlxG.camera.follow(this, FlxCamera.STYLE_PLATFORMER,null,0);
		FlxG.camera.zoom = 1;
		
		//load hairdresser graphic
		loadGraphic("assets/images/Characters/Main/Running.png", true, 64, 96);
		//run animations
		animation.add("run_right", [5, 7, 9, 11,9,7], 8, true);
		animation.add("run_left", [4, 6, 8, 10,8,6], 8, true);
		//jump animations
		animation.add("jump_left", [8]);
		animation.add("jump_right", [5]);
		//idle animations
		animation.add("idle_left", [0]);
		animation.add("idle_right", [1]);
		
		this.maxVelocity.set(MAX_SPEED);
		
		//set the center x and y coordinates of hairDresser
		centerX = this.width / 2;
		centerY = this.height / 2;
		
		// set gravity
		this.acceleration.y = 1500;
		this.acceleration.x = 0;
		
		//_brain starts in move
		_brain = new FSM(move);
		//set stun, attack times
		stunLimit = 35;
		attackLimit = 15;
		isMove = true;
		
		//set HP
		startHP = 100;
		HP = startHP;
	}
	
	override public function update():Void
	{	
		this.velocity.x = 0;
		
		_brain.update();
		
		super.update();
		FlxG.camera.update();
		
	}
	
	//FSM states
	public function stun():Void {
		if (face_left) animation.play("idle_left");
		else animation.play("idle_right");
		//when timer runs out, switch to move state
		if (Timer <= 0) {
			_brain.activeState = move;
			isMove = true;
		}
		else
			Timer -= 1;
	}
	
	public function move():Void {
		// movement
		if (isOnGround && this.isTouching(FlxObject.FLOOR) && (FlxG.keys.pressed.W || FlxG.keys.pressed.UP)) this.velocity.y    = -SPEED;
		if (FlxG.keys.pressed.S || FlxG.keys.pressed.DOWN)  this.velocity.y = SPEED;
		if (FlxG.keys.pressed.A || FlxG.keys.pressed.LEFT) this.velocity.x  = -SPEED;
		if (FlxG.keys.pressed.D || FlxG.keys.pressed.RIGHT) this.velocity.x = SPEED;
		
		// animation control
		if (this.velocity.x > 0) { 
			face_left = false; 
			if (isOnGround) animation.play("run_right");
			else animation.play("jump_right");
			}
		else if (this.velocity.x < 0) { 
			face_left = true; 
			if (isOnGround) animation.play("run_left");
			else animation.play("jump_left");
			}
		else if (face_left) {
			if (isOnGround) animation.play("idle_left");
			else animation.play("jump_left");
		}
		else {
			if (isOnGround) animation.play("idle_right");
			else animation.play("jump_right");
		}
		
	}
	
	public function attack():Void {
		//when timer runs out, switch to move state
		if (Timer <= 0) {
			_brain.activeState = move;
			isMove = true;
		}
		else
			Timer -= 1;
	}
	
	//triggers transition to attack sprite-state
	public function startAttack():Void {
			Timer = attackLimit;
			_brain.activeState = attack;
			isMove = false;
	}
	
	//takes damage; switches to stun
	public function takeDamage(damage:Float) {
		HP -= damage;
		trace(HP);
		//if not already stunned, set timer and switch to stun
		if (_brain.activeState != stun) {
			Timer = stunLimit;
			_brain.activeState = stun;
			isMove = false;
		}
	}
}