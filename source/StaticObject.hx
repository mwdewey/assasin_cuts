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

class StaticObject extends FlxSprite
{
	var pos_x:Int;
	var pos_y:Int;
	
	var w:Int;
	var h:Int;

	public function new(pos_x:Int, pos_y:Int, w:Int, h:Int) 
	{
		super();
		
		this.makeGraphic(w,h, FlxColor.TRANSPARENT, true);
		this.drawRect(0, 0, w, h, FlxColor.RED);
		
		this.setPosition(pos_x,pos_y);
		this.immovable = true;
	}
	
	override public function update():Void
	{
		super.update();
		
	}
	
	
	
}