package timelinefx;

import haxe.xml.Fast;

@:nativeGen
class EffectsLibrary {

    public static var c_particleLimit:Int = 5000;

    public static var globalPercentMin:Float = 0.0;
    public static var globalPercentMax:Float = 20.0;
    public static var globalPercentSteps:Float = 100.0;

    public static var globalPercentVMin:Float = 0.0;
    public static var globalPercentVMax:Float = 10.0;
    public static var globalPercentVSteps:Float = 200.0;

    public static var angleMin:Float = 0.0;
    public static var angleMax:Float = 1080.0;
    public static var angleSteps:Float = 54.0;

    public static var emissionRangeMin:Float = 0.0;
    public static var emissionRangeMax:Float = 180.0;
    public static var emissionRangeSteps:Float = 30.0;

    public static var dimensionsMin:Float = 0.0;
    public static var dimensionsMax:Float = 200.0;
    public static var dimensionsSteps:Float = 40.0;

    public static var lifeMin:Float = 0.0;
    public static var lifeMax:Float = 100000.0;
    public static var lifeSteps:Float = 200.0;

    public static var amountMin:Int = 0;
    public static var amountMax:Int = 2000;
    public static var amountSteps:Int = 100;

    public static var velocityMin:Float = 0.0;
    public static var velocityMax:Float = 10000.0;
    public static var velocitySteps:Float = 100.0;

    public static var velocityOverTimeMin:Float = -20.0;
    public static var velocityOverTimeMax:Float = 20.0;
    public static var velocityOverTimeSteps:Float = 200.0;

    public static var weightMin:Float = -2500.0;
    public static var weightMax:Float = 2500.0;
    public static var weightSteps:Float = 200.0;

    public static var weightVariationMin:Float = 0.0;
    public static var weightVariationMax:Float = 2500.0;
    public static var weightVariationSteps:Float = 250.0;

    public static var spinMin:Float = -2000.0;
    public static var spinMax:Float = 2000.0;
    public static var spinSteps:Float = 100.0;

    public static var spinVariationMin:Float = 0.0;
    public static var spinVariationMax:Float = 2000.0;
    public static var spinVariationSteps:Float = 100.0;

    public static var spinOverTimeMin:Float = -20.0;
    public static var spinOverTimeMax:Float = 20.0;
    public static var spinOverTimeSteps:Float = 200.0;

    public static var directionOverTimeMin:Float = 0.0;
    public static var directionOverTimeMax:Float = 4320.0;
    public static var directionOverTimeSteps:Float = 216.0;

    public static var framerateMin:Float = 0.0;
    public static var framerateMax:Float = 200.0;
    public static var framerateSteps:Float = 100.0;

    public static var maxDirectionVariation:Float = 22.5;
    public static var maxVelocityVariation:Float = 30.0;
    public static var motionVariationInterval:Float = 30.0;

    //var name:String;

    var shapeList:Array<AnimImage>;
    var effects:Map<String, Effect>;
    var emitters:Map<String, Emitter>;

    var updateTime:Float;
    var updateFrequency:Float;
    public var currentUpdateTime:Float;
    var lookupFrequency:Float;
    var lookupFrequencyOverTime:Float;

    public function new() {
        setUpdateFrequency(30.0);
        lookupFrequency = updateTime;
        lookupFrequencyOverTime = 1.0;
        clearAll();
    }

    public function clearAll():Void {
        //name = "";
        shapeList = [];
        effects = new Map<String, Effect>();
        emitters = new Map<String, Emitter>();
    }

    public function loadFromXML(_xml:String):Void {
        clearAll();
        var xml = Xml.parse(_xml);
        var fast = new Fast(xml.firstElement());
        for (s in fast.node.SHAPES.nodes.IMAGE) {
            var img = new AnimImage();
            img.loadFromXML(s);
            shapeList.push(img);
        }
        loadEffects(fast.node.EFFECTS);
    }

    function loadEffects(_fast:Fast):Void {
        for (e in _fast.nodes.EFFECT) {
            var effect = new Effect(null);
            effect.effectsLib = this;
            effect.loadFromXML(e);
            addEffect(effect);
        }
    }

    public function addEffect(_e:Effect):Void {
        var name = _e.path;
        effects.set(name, _e);
        for (e in _e.children)
            addEmitter(cast(e, Emitter));
    }

    public function addEmitter(_e:Emitter):Void {
        var name = _e.path;
        emitters.set(name, _e);
        for (e in _e.effects)
            addEffect(e);
    }

    public function setUpdateFrequency(_freq:Float):Void {
        updateFrequency = _freq; // fps
        updateTime = 1000.0 / updateFrequency;
        currentUpdateTime = updateFrequency;
    }

}