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
    public var currentEffectFrame:Float = 0.0;
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
    public var parentEmitter:Emitter = null;
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
        this.endBehavior = Std.parseInt(_fast.att.END_BEHAVIOUR);
        this.distanceSetByLife = cast(Std.parseInt(_fast.att.DISTANCE_SET_BY_LIFE), Bool);
        this.reverseSpawn = cast(Std.parseInt(_fast.att.REVERSE_SPAWN_DIRECTION), Bool);

        this.path = this.name;
        var p = _fast.x.parent;
        while(p != null) {
            if (p.nodeName != "")
                this.path = p.nodeName + "/" + this.path;
            p = p.parent;
        }

        if (_fast.hasNode.ANIMATION_PROPERTIES) {
            var a = _fast.node.ANIMATION_PROPERTIES;
            this.frames = Std.parseInt(_fast.att.FRAMES);
            this.animWidth = Std.parseInt(_fast.att.WIDTH);
            this.animHeight = Std.parseInt(_fast.att.HEIGHT);
            this.animX = Std.parseInt(_fast.att.X);
            this.animY = Std.parseInt(_fast.att.Y);
            this.seed = Std.parseInt(_fast.att.SEED);
            this.looped = cast(Std.parseInt(_fast.att.LOOPED), Bool);
            this.zoom = Std.parseFloat(_fast.att.ZOOM);
            this.frameOffset = Std.parseInt(_fast.att.FRAME_OFFSET);
        }

        _readEmitterArray(_fast.nodes.AMOUNT, cAmount);
        _readEmitterArray(_fast.nodes.LIFE, cLife);
        _readEmitterArray(_fast.nodes.SIZEX, cSizeX);
        _readEmitterArray(_fast.nodes.SIZEY, cSizeY);
        _readEmitterArray(_fast.nodes.VELOCITY, cVelocity);
        _readEmitterArray(_fast.nodes.WEIGHT, cWeight);
        _readEmitterArray(_fast.nodes.SPIN, cSpin);
        _readEmitterArray(_fast.nodes.ALPHA, cAlpha);
        _readEmitterArray(_fast.nodes.EMISSIONANGLE, cEmissionAngle);
        _readEmitterArray(_fast.nodes.EMISSIONRANGE, cEmissionRange);
        _readEmitterArray(_fast.nodes.AREA_WIDTH, cWidth);
        _readEmitterArray(_fast.nodes.AREA_HEIGHT, cHeight);
        _readEmitterArray(_fast.nodes.ANGLE, cEffectAngle);
        _readEmitterArray(_fast.nodes.GLOBAL_ZOOM, cGlobalZ);

        if (_fast.hasNode.STRETCH) {
            for (n in _fast.nodes.STRETCH) {
                var attr = cStretch.add(Std.parseFloat(n.att.FRAME), Std.parseFloat(n.att.VALUE));
                if (n.hasNode.CURVE) attr.loadFromXML(n.node.CURVE);
            }
        } else
            cStretch.add(0.0, 1.0);

        for (p in _fast.nodes.PARTICLE) {
            var em = new Emitter(null, effectsLib, particleManager);
            em.loadFromXML(p);
            this.addChild(em);
        }
        
    }

    override public function update():Bool {
        capture();
        this.age = this.particleManager.getCurrentTime() - this.dob;

        if (this.spawnAge < this.age)
            this.spawnAge = this.age;

        if (this.effectLength > 0 && this.age > this.effectLength) {
            this.dob = this.particleManager.getCurrentTime();
            this.age = 0;
        }

        this.currentEffectFrame = this.age / effectsLib.lookupFrequency;
        var cFrame:Int = Math.round(this.currentEffectFrame);

        if (!this.overrideSize) {
            switch(this._class) {
                case TypePoint: 
                    this.currentWidth = 0.0; 
                    this.currentHeight = 0.0;
                case TypeArea:
                case TypeEllipse:
                    this.currentWidth = this.cWidth.get(cFrame);
                    this.currentHeight = this.cHeight.get(cFrame);
                case TypeLine:
                    this.currentWidth = this.cWidth.get(cFrame);
                    this.currentHeight = 0.0;
            }
        }

        if (this.handleCenter && this._class != TypePoint) {
            this.handleX = Math.round(this.currentWidth * 0.5);
            this.handleY = Math.round(this.currentHeight * 0.5);
        } else {
            this.handleX = 0;
            this.handleY = 0;
        }

        if (this.hasParticles() || this.doesNotTimeout)
            this.idleTime = 0;
        else
            ++this.idleTime;

        if (this.parentEmitter != null) {
            var parentEffect = this.parentEmitter.parentEffect;
            if (!this.overrideLife) this.currentLife = this.cLife.get(cFrame) * parentEffect.currentLife;
            if (!this.overrideAmount) this.currentAmount = this.cAmount.get(cFrame) * parentEffect.currentAmount;
            if (!this.overrideSizeX) this.currentSizeX = this.cSizeX.get(cFrame) * parentEffect.currentSizeX;
            if (this.lockAspect)                
                if (!this.overrideSizeY) this.currentSizeY = this.currentSizeX * parentEffect.currentSizeY;
            else
                if (!this.overrideSizeY) this.currentSizeY = this.cSizeY.get(cFrame) * parentEffect.currentSizeY;
            if (!this.overrideVelocity) this.currentVelocity = this.cVelocity.get(cFrame) * parentEffect.currentVelocity;
            if (!this.overrideWeight) this.currentWeight = this.cWeight.get(cFrame) * parentEffect.currentWeight;
            if (!this.overrideSpin) this.currentSpin = this.cSpin.get(cFrame) * parentEffect.currentSpin;
            if (!this.overrideAlpha) this.currentAlpha = this.cAlpha.get(cFrame) * parentEffect.currentAlpha;
            if (!this.overrideEmissionAngle) this.currentEmissionAngle = this.cEmissionAngle.get(cFrame) * parentEffect.currentEmissionAngle;
            if (!this.overrideEmissionRange) this.currentEmissionRange = this.cEmissionRange.get(cFrame) * parentEffect.currentEmissionRange;
            if (!this.overrideAngle) this.angle = this.cEffectAngle.get(cFrame);
            if (!this.overrideStretch) this.currentStretch = this.cStretch.get(cFrame) * parentEffect.currentStretch;
            if (!this.overrideGlobalZ) this.currentGlobalZ = this.cGlobalZ.get(cFrame) * parentEffect.currentGlobalZ;

            this.dying = parentEmitter.dying;

        } else {
            if (!this.overrideLife) this.currentLife = this.cLife.get(cFrame);
            if (!this.overrideAmount) this.currentAmount = this.cAmount.get(cFrame);
            if (!this.overrideSizeX) this.currentSizeX = this.cSizeX.get(cFrame);
            if (this.lockAspect)                
                if (!this.overrideSizeY) this.currentSizeY = this.currentSizeX;
            else
                if (!this.overrideSizeY) this.currentSizeY = this.cSizeY.get(cFrame);

            if (!this.overrideVelocity) this.currentVelocity = this.cVelocity.get(cFrame);
            if (!this.overrideWeight) this.currentWeight = this.cWeight.get(cFrame);
            if (!this.overrideSpin) this.currentSpin = this.cSpin.get(cFrame);
            if (!this.overrideAlpha) this.currentAlpha = this.cAlpha.get(cFrame);
            if (!this.overrideEmissionAngle) this.currentEmissionAngle = this.cEmissionAngle.get(cFrame);
            if (!this.overrideEmissionRange) this.currentEmissionRange = this.cEmissionRange.get(cFrame);
            if (!this.overrideAngle) this.angle = this.cEffectAngle.get(cFrame);
            if (!this.overrideStretch) this.currentStretch = this.cStretch.get(cFrame);
            if (!this.overrideGlobalZ) this.currentGlobalZ = this.cGlobalZ.get(cFrame);
        }

        if (!this.overrideGlobalZ) this.z = this.currentGlobalZ;
        if (this.currentWeight == 0.0)
            this.bypassWeight = true;

        super.update();

        if (this.idleTime > this.particleManager.getIdleTime())
            this.dead = true;

        if (this.dead) {
            if (this.children.length == 0) {
                this.destroy();
                return false;
            } else {
                this.killChildren();
            }
        }

        return true;
    }

    public function hasParticles():Bool {
        for (e in children)
            if (e.children.length > 0)
                return true;
        return false;
    }

    public function setEllipseArc(_degrees:Float):Void {
        this.ellipseArc = _degrees;
        this.ellipseOffset = 90.0 - (_degrees * 0.5);
    }

    function _readEmitterArray(_nodes:List<Fast>, _emArray:EmitterArray) {
        for (n in _nodes) {
            var attr = _emArray.add(Std.parseFloat(n.att.FRAME), Std.parseFloat(n.att.VALUE));
            if (n.hasNode.CURVE) attr.loadFromXML(n.node.CURVE);
        }
    }
}