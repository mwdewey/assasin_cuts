package;

import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.Lib;
import flixel.FlxGame;
import flixel.FlxState;
import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.tile.FlxTilemap;
import openfl.Assets;
import flixel.FlxBasic;

/**
 * ...
 * @author ...
 */
class GameState2 extends FlxState
{
	var hairDresser: HairDresser;
	var enemygroup: FlxGroup;
	var pProjectile: FlxGroup;
	
	public function new() 
	{
		super();
		
	}
	
	override public function create():Void
    {
        super.create();
		
		var hairDresser = new HairDresser();
		
		FlxG.sound.playMusic(AssetPaths.Level2__wav, 1, true);
		
		//load in tile map
		
		
		//set up enemies
		
		
		//set up player
		
		
		
	}
	
	override public function update() {
		super.update();
		
		//check for level win condition
		
		if (FlxG.keys.justPressed.R) FlxG.switchState(new RestartState(new CutScene2()));
		if (FlxG.keys.justPressed.F5) FlxG.switchState(new CutScene3());
	}
	
}