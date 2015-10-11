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

using flixel.util.FlxSpriteUtil;

class HairDresser extends FlxSprite
{
	public static var MAX_SPEED:Int = 1000;
	public static var SPEED:Int = 1000;
	public var centerX:Float;
	public var centerY:Float;
	
	public var isOnGround:Bool;
	
	private var face_left:Bool = false;
	
	public function new() 
	{
		super();
		
		isOnGround = false;
		
		FlxG.camera.follow(this, FlxCamera.STYLE_PLATFORMER,null,0);
		FlxG.camera.zoom = 1;
		
		//this.makeGraphic(96,192, FlxColor.TRANSPARENT, true);
		//this.drawRect(0, 0, 96, 192, FlxColor.GREEN);
		loadGraphic("assets/images/Characters/Main/Running.png", true, 64, 96);
		animation.add("run_right", [5, 7, 9, 11], 5, true);
		animation.add("run_left", [4, 6, 8, 10], 5, true);
		
		animation.add("jump_left", [8]);
		animation.add("jump_right", [5]);
		
		animation.add("idle_left", [0]);
		animation.add("idle_right", [1]);
		
		this.maxVelocity.set(MAX_SPEED);
		
		//set the center x and y coordinates of hairDresser
		centerX = this.width / 2;
		centerY = this.height / 2;
		
		// set gravity
		this.acceleration.y = 1500;
		this.acceleration.x = 0;
	}
	
	override public function update():Void
	{		
		// friction horizontal movement
		this.velocity.x *= 0;
		if (this.velocity.x < 10 && this.velocity.x > -10) this.velocity.x = 0;
		
		// movement
		if (FlxG.keys.pressed.W || FlxG.keys.pressed.UP) this.velocity.y    = -SPEED;
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
		
		// jump
		if (FlxG.keys.justPressed.SPACE && isOnGround) this.velocity.y = -1000;
		
		super.update();
		FlxG.camera.update();
		
	}
	
	
}