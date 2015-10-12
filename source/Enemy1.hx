package;

import flixel.FlxSprite;
import flixel.util.FlxColor;

class Enemy1 extends FlxSprite
{

	public function new() 
	{
		super();
		
		//this.loadGraphic("assets/images/background.png", false, w, h);
		this.makeGraphic(96, 192, FlxColor.AZURE);
		
	}
	
	override public function update():Void
	{
		super.update();
	}
	
}