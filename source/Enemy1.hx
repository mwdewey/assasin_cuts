package;

import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.util.FlxColor;
import flixel.FlxG;

class Enemy1 extends FlxSprite
{

	var pos_x:Int;
	var pos_y:Int;
	
	var w:Int;
	var h:Int;
	
	public var spriteGroup:FlxGroup;
	
	//bullets
	public var bullet_group:FlxGroup;
	var bullet:FlxSprite;
	
	//timer for fire
	private var firetime:Float = 2; //fire a bullet every n seconds
	private var firetimer:Float = 0;

	public function new(pos_x:Int, pos_y:Int) 
	{
		super();
		
		//this.makeGraphic(64, 128, FlxColor.AZURE);
		this.loadGraphic("assets/images/Characters/Enemy/enemy0.png", true, 64, 96);
		this.animation.add("walk", [2,3,4,3], 8, true);
		this.animation.add("fire", [1, 0], 8, false);
		this.animation.add("idle", [2], 1, true);
		
		
		//make spriteGroup
		bullet_group = new FlxGroup();
		spriteGroup = new FlxGroup();
		
		spriteGroup.add(bullet_group);
		spriteGroup.add(this);
		
		
		this.animation.play("walk");
		
		this.setPosition(pos_x,pos_y);
	}
	
	override public function update():Void
	{
		super.update();
		
		if (firetimer >= firetime) {
			//play the fire animaiton
			this.animation.play("fire");
		//add another bullet
			//add animaiton
			bullet = new FlxSprite();
			bullet.loadGraphic("assets/images/Characters/Enemy/bullet.png", true, 32, 32);
			bullet.animation.add("move", [0, 1, 2, 3, 4, 5], 8, true);
			bullet.animation.play("move");
			
			//set postiion and velocity
			bullet.velocity.x = -1000;
			
			bullet_group.add(bullet);
			//reset time
			firetime = 0;
		}
		else {
			firetime += FlxG.elapsed;
		}
		
	}
	
	public function killEnemy():Void {
			this.velocity.y = -100;
	}
	
}