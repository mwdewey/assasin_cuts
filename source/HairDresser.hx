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
	public static var SPEED:Int = 100;
	
	public function new() 
	{
		super();
		
		this.makeGraphic(96,192, FlxColor.TRANSPARENT, true);
		this.drawRect(0, 0, 96, 192, FlxColor.GREEN);
		
		this.maxVelocity.set(MAX_SPEED);
	}
	
	override public function update():Void
	{
		this.acceleration.y = 1000;
		this.acceleration.x = 0;
		
		this.velocity.x *= 0.9;
		
		if (FlxG.keys.pressed.W || FlxG.keys.pressed.UP)    this.velocity.y -= SPEED;
		if (FlxG.keys.pressed.S || FlxG.keys.pressed.DOWN)  this.velocity.y += SPEED;
		if (FlxG.keys.pressed.A || FlxG.keys.pressed.LEFT)  this.velocity.x -= SPEED;
		if (FlxG.keys.pressed.D || FlxG.keys.pressed.RIGHT) this.velocity.x += SPEED;
		
		if (FlxG.keys.justPressed.SPACE) this.velocity.y = -500;
		
		super.update();
		
		// update velocity for collisions
		if (this.x < 0 || this.x+this.width > FlxG.width) this.velocity.x *= -0.5;
		if (this.y < 0 || this.y+this.height > FlxG.height) this.velocity.y *= -0.5;
		
		this.bound();
		
		
	}
	
	
}