package;

import flixel.FlxSprite;
import flixel.group.FlxTypedGroup;

class Background extends FlxTypedGroup<FlxSprite>
{
	var w:Int;
	var h:Int;
	
	var b1:FlxSprite;
	var b2:FlxSprite;
	var b3:FlxSprite;
	var b4:FlxSprite;

	public function new() 
	{
		super();
		
		w = 1240;
		h = 585;
		
		b1 = new FlxSprite();
		b1.loadGraphic("assets/images/Cloudy.png", false, w, h);
		
		b2 = new FlxSprite();
		b2.loadGraphic("assets/images/Cloudy.png", false, w, h);
		
		b3 = new FlxSprite();
		b3.loadGraphic("assets/images/Cloudy.png", false, w, h);
		
		b4 = new FlxSprite();
		b4.loadGraphic("assets/images/Cloudy.png", false, w, h);
		
		add(b1);
		add(b2);
		add(b3);
		add(b4);
	}
	
	override public function update():Void
	{
		var x:Float = Reg.ref_x + w/2 - (Reg.ref_x * 0.5) % w;
		var y:Float = Reg.ref_y + h/2 - (Reg.ref_y * 0.5) % h;
		
		b1.x = x - w;
		b1.y = y - h;
		
		b2.x = x;
		b2.y = y - h;
		
		b3.x = x - w;
		b3.y = y;
		
		b4.x = x;
		b4.y = y;
		
		super.update();
	}
	
}