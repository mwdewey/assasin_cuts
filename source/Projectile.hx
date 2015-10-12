package;

import flixel.util.FlxColor;
import flixel.FlxSprite;

class Projectile extends FlxSprite
{
	
	static var projectileSpeed:Int = 500;
	var pos_x:Float;
	var pos_y:Float;
	var aim_x:Float;
	var aim_y:Float;
	public var damage:Float;

	public function new(pos_x:Float, pos_y:Float,aim_x:Float, aim_y:Float) 
	{
		super();
		
		//this.loadGraphic(path,false,64,64);
		this.makeGraphic(64,64, FlxColor.GRAY);
		
		// set init position
		this.setPosition(pos_x, pos_y);
		
		// set velocity
		var dX:Float = aim_x - pos_x;
		var dY:Float = aim_y - pos_y;
		var dMax:Float = Math.sqrt(Math.pow(dX,2) + Math.pow(dY,2));
		
		this.velocity.x = (dX / dMax) * projectileSpeed;
		this.velocity.y = (dY / dMax) * projectileSpeed;
		
		damage = 10;
	}
	
	override public function update():Void
	{
		super.update();
		
	}
	
}