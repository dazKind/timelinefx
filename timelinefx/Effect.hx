package timelinefx;

import haxe.xml.Fast;

@:enum
abstract EffectTypes(Int)
from Int to Int {
	var TypePoint:Int = 0;
    var TypeArea:Int = 1;
    var TypeLine:Int = 2;
    var TypeEllipse:Int = 3;
}

@:enum
abstract EmissionTypes(Int)
from Int to Int {
	var EmInwards:Int = 0;
	var EmOutwards:Int = 1;
	var EmSpecified:Int = 2;
	var EmInAndOut:Int = 3;
}

@:enum
abstract EndTypes(Int)
from Int to Int {
	var EndKill:Int = 0;
	var EndLoopAround:Int = 1;
	var EndLetFree:Int = 2;
}

@:nativeGen
class Effect extends Entity {

	public var path:String = "";

	public var _class:Int = EffectTypes.TypePoint;
	public var currentEffectFrame:Int = 0;
	public var handleCenter:Bool = false;

	public var source:String = null;
  	public var lockAspect:Bool = true;
  	public var particlesCreated:Bool = false;
  	public var suspendTime:Float = 0.0;
	public var gx:Int = 0;
	public var gy:Int = 0;
	public var mgx:Int = 0;
	public var mgy:Int = 0;
	public var emitAtPoints:Bool = false;
	public var emissionType:Int = EmissionTypes.EmInwards;
	public var effectLength:Int = 0;
	public var parentEmitter:Effect = null;
	public var spawnAge:Float = 0.0;
	public var index:Int = 0;
	public var particleCount:Int = 0;
	public var idleTime:Float = 0.0;
	public var traverseEdge:Bool = false;
	public var endBehavior:Int = EndTypes.EndKill;
	public var distanceSetByLife:Bool = false;
	public var reverseSpawn:Bool = false;
	public var spawnDirection:Int = 1;
	public var dying:Bool = false;
	public var allowSpawning:Bool = true;
	public var ellipseArc:Float = 360.0;
	public var ellipseOffset:Float = 0.0;
	public var effectLayer:Int = 0;
	public var doesNotTimeout:Bool = false;

	public var particleManager:ParticleManager = null;

	public var frames:Int = 32;
	public var animWidth:Int = 128;
	public var animHeight:Int = 128;
	public var looped:Bool = false;
	public var animX:Int = 0;
	public var animY:Int = 0;
	public var seed:Int = 0;
	public var zoom:Float = 1.0;

	public var currentLife:Float = 0.0;
	public var currentAmount:Float = 0.0;
	public var currentSizeX:Float = 0.0;
	public var currentSizeY:Float = 0.0;
	public var currentVelocity:Float = 0.0;
	public var currentSpin:Float = 0.0;
	public var currentWeight:Float = 0.0;
	public var currentWidth:Float = 0.0;
	public var currentHeight:Float = 0.0;
	public var currentAlpha:Float = 0.0;
	public var currentEmissionAngle:Float = 0.0;
	public var currentEmissionRange:Float = 0.0;
	public var currentStretch:Float = 0.0;
	public var currentGlobalZ:Float = 0.0;

	public var overrideSize:Bool = false;
	public var overrideEmissionAngle:Bool = false;
	public var overrideEmissionRange:Bool = false;
	public var overrideAngle:Bool = false;
	public var overrideLife:Bool = false;
	public var overrideAmount:Bool = false;
	public var overrideVelocity:Bool = false;
	public var overrideSpin:Bool = false;
	public var overrideSizeX:Bool = false;
	public var overrideSizeY:Bool = false;
	public var overrideWeight:Bool = false;
	public var overrideAlpha:Bool = false;
	public var overrideStretch:Bool = false;
	public var overrideGlobalZ:Bool = false;

	public var bypassWeight:Bool = false;
	public var isCompiled:Bool = false;

	public function new(_other:Effect, _particleManager:ParticleManager = null) {
		super(_other);
		//TODO: 
	}

	public function loadFromXML(_fast:Fast):Void {}
}