package;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.Lib;
import flixel.FlxGame;
import flixel.FlxState;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.util.FlxColor;

/**
 * ...
 * @author ...
 */
class CutScene1 extends FlxState
{
	var labelTest:FlxText;

	public function new() 
	{
		super();
		
	}
	
	override public function create():Void
    {
		labelTest = new FlxText(0, FlxG.height / 2, FlxG.width, "");
		labelTest.setFormat(null, 40, FlxColor.WHITE, "center");
		add(labelTest);
		
        super.create();
    }
	
	override public function update():Void
	{
		super.update();
		
	}	
	
}