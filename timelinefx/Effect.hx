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

    var cAmount:EmitterArray;
    var cLife:EmitterArray;
    var cSizeX:EmitterArray;
    var cSizeY:EmitterArray;
    var cVelocity:EmitterArray;
    var cWeight:EmitterArray;
    var cSpin:EmitterArray;
    var cStretch:EmitterArray;
    var cGlobalZ:EmitterArray;
    var cAlpha:EmitterArray;
    var cEmissionAngle:EmitterArray;
    var cEmissionRange:EmitterArray;
    var cWidth:EmitterArray;
    var cHeight:EmitterArray;
    var cEffectAngle:EmitterArray;

    var arrayOwner:Bool = false;
    var inUse:Array<Array<Particle>>;

    public function new(_other:Effect, _effectsLib:EffectsLibrary, _particleManager:ParticleManager = null) {
        super(_other, _effectsLib);

        this.inUse = [];
        for (i in 0...10)
            this.inUse.push([]);

        if (_other == null) {

            arrayOwner = true;

            this.cAmount = new EmitterArray(_effectsLib, EffectsLibrary.globalPercentMin, EffectsLibrary.globalPercentMax);
            this.cLife = new EmitterArray(_effectsLib, EffectsLibrary.globalPercentMin, EffectsLibrary.globalPercentMax);
            this.cSizeX = new EmitterArray(_effectsLib, EffectsLibrary.globalPercentMin, EffectsLibrary.globalPercentMax);
            this.cSizeY = new EmitterArray(_effectsLib, EffectsLibrary.globalPercentMin, EffectsLibrary.globalPercentMax);
            this.cVelocity = new EmitterArray(_effectsLib, EffectsLibrary.globalPercentMin, EffectsLibrary.globalPercentMax);
            this.cWeight = new EmitterArray(_effectsLib, EffectsLibrary.globalPercentMin, EffectsLibrary.globalPercentMax);
            this.cSpin = new EmitterArray(_effectsLib, EffectsLibrary.globalPercentMin, EffectsLibrary.globalPercentMax);
            this.cStretch = new EmitterArray(_effectsLib, EffectsLibrary.globalPercentMin, EffectsLibrary.globalPercentMax);
            this.cGlobalZ = new EmitterArray(_effectsLib, EffectsLibrary.globalPercentMin, EffectsLibrary.globalPercentMax);
            this.cAlpha = new EmitterArray(_effectsLib, 0.0, 1.0);
            this.cEmissionAngle = new EmitterArray(_effectsLib, EffectsLibrary.angleMin, EffectsLibrary.angleMax);
            this.cEmissionRange = new EmitterArray(_effectsLib, EffectsLibrary.emissionRangeMin, EffectsLibrary.emissionRangeMax);
            this.cWidth = new EmitterArray(_effectsLib, EffectsLibrary.dimensionsMin, EffectsLibrary.dimensionsMax);
            this.cHeight = new EmitterArray(_effectsLib, EffectsLibrary.dimensionsMin, EffectsLibrary.dimensionsMax);
            this.cEffectAngle = new EmitterArray(_effectsLib, EffectsLibrary.angleMin, EffectsLibrary.angleMax);

        } else {
            particleManager = _particleManager;
            arrayOwner = false;

            this.cAmount = _other.cAmount;
            this.cLife = _other.cLife;
            this.cSizeX = _other.cSizeX;
            this.cSizeY = _other.cSizeY;
            this.cVelocity = _other.cVelocity;
            this.cWeight = _other.cWeight;
            this.cSpin = _other.cSpin;
            this.cStretch = _other.cStretch;
            this.cGlobalZ = _other.cGlobalZ;
            this.cAlpha = _other.cAlpha;
            this.cEmissionAngle = _other.cEmissionAngle;
            this.cEmissionRange = _other.cEmissionRange;
            this.cWidth = _other.cWidth;
            this.cHeight = _other.cHeight;
            this.cEffectAngle = _other.cEffectAngle;

            setEllipseArc(_other.ellipseArc);

            this.dob = particleManager.getCurrentTime();
            this.okToRender = false;

            for (c in _other.children) {
                var e = new Emitter(c, effectsLib, particleManager);
                e.parentEffect = this;
                e.setParent(this);
            }
        }
    }

    public function loadFromXML(_fast:Fast):Void {
        this._class = Std.parseInt(_fast.att.TYPE);
        this.emitAtPoints = cast(Std.parseInt(_fast.att.EMITATPOINTS), Bool);
        this.mgx = Std.parseInt(_fast.att.MAXGX);
        this.mgy = Std.parseInt(_fast.att.MAXGY);

        this.emissionType = Std.parseInt(_fast.att.EMISSION_TYPE);
        this.effectLength = Std.parseInt(_fast.att.EFFECT_LENGTH);
        this.ellipseArc = Std.parseInt(_fast.att.ELLIPSE_ARC);

        this.handleX = Std.parseInt(_fast.att.HANDLE_X);
        this.handleY = Std.parseInt(_fast.att.HANDLE_Y);

        this.lockAspect = cast(Std.parseInt(_fast.att.UNIFORM), Bool);
        this.handleCenter = cast(Std.parseInt(_fast.att.HANDLE_CENTER), Bool);
        this.traverseEdge = cast(Std.parseInt(_fast.att.TRAVERSE_EDGE), Bool);

        this.name = _fast.att.NAME;
        this.endBehavior = cast(Std.parseInt(_fast.att.END_BEHAVIOUR), Bool);
        this.distanceSetByLife = cast(Std.parseInt(_fast.att.DISTANCE_SET_BY_LIFE), Bool);
        this.reverseSpawn = cast(Std.parseInt(_fast.att.REVERSE_SPAWN_DIRECTION), Bool);

        this.path = this.name;
        // TODO: building path, why is this even necessary? to a have unique id or something?!
    }

    public function setEllipseArc(_degrees:Float):Void {
        this.ellipseArc = _degrees;
        this.ellipseOffset = 90.0 - (_degrees * 0.5);
    }
}