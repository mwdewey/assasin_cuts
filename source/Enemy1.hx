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
		
		//this.loadGraphic(path,false,64,64);
		this.makeGraphic(64,128, FlxColor.AZURE);
		
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