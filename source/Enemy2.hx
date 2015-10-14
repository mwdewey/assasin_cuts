package;

import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.util.FlxColor;
import flixel.FlxG;

class Enemy2 extends FlxSprite
{

	var pos_x:Int;
	var pos_y:Int;
	
	var w:Int;
	var h:Int;
	
	public var isThrowing:Bool;
	
	public var spriteGroup:FlxGroup;
	
	//Projectiles
	public var projectile_group:FlxGroup;
	var projectile:FlxSprite;
	
	//throw timer
	private var throwtime:Float = 2; //throw stuff every n seconds
	private var throwtimer:Float = 0;

	public function new(pos_x:Int, pos_y:Int) 
	{
		super();
		
		//this.makeGraphic(64, 128, FlxColor.AZURE);
		this.loadGraphic("assets/images/Characters/Enemy/enemy1.png", true, 64, 96);
		this.animation.add("throw", [1,2,3,4,4,4], 8, false);
		this.animation.add("idle", [5]);
		this.animation.add("idle_attack", [0]);
		
		//make spriteGroup
		projectile_group = new FlxGroup();
		spriteGroup = new FlxGroup();
		
		spriteGroup.add(projectile_group);
		spriteGroup.add(this);	
		
		this.animation.play("throw");
		
		this.setPosition(pos_x, pos_y);
		
		isThrowing = false;
	}
	
	override public function update():Void
	{
		super.update();
		
		if (throwtimer >= throwtime) {
			//play the throw animation
			this.animation.play("throw");
			
		//add a new projectile to the group
		isThrowing = true;
			
		//reset the timer
		throwtimer = 0;
		}
		else {
			throwtimer += FlxG.elapsed;
		}
	}
	
	public function projectile_movement():Void {
		
	}
	
	public function killEnemy():Void {
			this.velocity.y = -100;
	}
	
}