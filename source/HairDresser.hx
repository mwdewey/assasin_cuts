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

using flixel.util.FlxSpriteUtil;

class HairDresser extends FlxSprite
{
	public static var MAX_SPEED:Int = 2000;
	public static var SPEED:Int = 1000;
	public var centerX:Float;
	public var centerY:Float;
	
	public function new() 
	{
		super();
		
		this.makeGraphic(96,192, FlxColor.TRANSPARENT, true);
		this.drawRect(0, 0, 96, 192, FlxColor.GREEN);
		
		this.maxVelocity.set(MAX_SPEED);
		
		//set the center x and y coordinates of hairDresser
		centerX = this.width / 2;
		centerY = this.height / 2;
	}
	
	override public function update():Void
	{
		this.acceleration.y = 500;
		this.acceleration.x = 0;
		
		//this.velocity.x *= 0.8;
		
		if (FlxG.keys.pressed.W || FlxG.keys.pressed.UP)    this.acceleration.y -= SPEED;
		if (FlxG.keys.pressed.S || FlxG.keys.pressed.DOWN)  this.acceleration.y += SPEED;
		if (FlxG.keys.pressed.A || FlxG.keys.pressed.LEFT)  this.acceleration.x -= SPEED;
		if (FlxG.keys.pressed.D || FlxG.keys.pressed.RIGHT) this.acceleration.x += SPEED;
		
		if (FlxG.keys.justPressed.SPACE) this.velocity.y = -500;
		
		super.update();
		
		this.bound();
		
	}
	
	
}