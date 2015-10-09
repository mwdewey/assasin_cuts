package;

import flixel.FlxSprite;

class StaticObject extends FlxSprite
{
	
	var x:Int;
	var y:Int;
	var w:Int;
	var h:Int;

	public function new() 
	{
		super();
		
		this.makeGraphic(w,h, FlxColor.TRANSPARENT, true);
		this.drawRect(0, 0, w, h, FlxColor.RED);
		
		this.setPosition(x,y);
		this.immovable = true;
	}
	
	override public function update():Void
	{
		super.update();
		
		
	}
	
	
	
}