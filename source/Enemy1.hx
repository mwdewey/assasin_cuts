package;

import flixel.FlxSprite;
import flixel.util.FlxColor;

class Enemy1 extends FlxSprite
{

	var pos_x:Int;
	var pos_y:Int;
	
	var w:Int;
	var h:Int;

	public function new(pos_x:Int, pos_y:Int) 
	{
		super();
		
		//this.makeGraphic(64, 128, FlxColor.AZURE);
		this.loadGraphic("assets/images/Characters/Enemy/enemy0.png", true, 64, 96);
		this.animation.add("walk", [2,3,4,3], 8, true);
		this.animation.add("fire", [1, 0], 8, false);
		this.animation.add("idle", [2], 1, true);
		
		
		this.animation.play("walk");
		
		this.setPosition(pos_x,pos_y);
	}
	
	override public function update():Void
	{
		super.update();
		
	}
	
	public function killEnemy():Void {
			this.velocity.y = -100;
	}
	
}