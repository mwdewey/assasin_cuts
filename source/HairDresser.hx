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
	public static var MAX_SPEED:Int = 2000;
	public static var SPEED:Int = 100;
	public var centerX:Float;
	public var centerY:Float;
	
	public function new() 
	{
		super();
		
		FlxG.camera.follow(this, FlxCamera.STYLE_PLATFORMER,new FlxPoint(0,0),1);
		
		this.makeGraphic(96,192, FlxColor.TRANSPARENT, true);
		this.drawRect(0, 0, 96, 192, FlxColor.GREEN);
		
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
		this.velocity.x *= 0.93;
		
		// movement
		if (FlxG.keys.pressed.W || FlxG.keys.pressed.UP)    this.velocity.y -= SPEED;
		if (FlxG.keys.pressed.S || FlxG.keys.pressed.DOWN)  this.velocity.y += SPEED;
		if (FlxG.keys.pressed.A || FlxG.keys.pressed.LEFT)  this.velocity.x -= SPEED;
		if (FlxG.keys.pressed.D || FlxG.keys.pressed.RIGHT) this.velocity.x += SPEED;
		
		// jump
		if (FlxG.keys.justPressed.SPACE) this.velocity.y = -1000;
		
		super.update();
	}
	
	
}