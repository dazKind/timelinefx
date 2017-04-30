package timelinefx;

import haxe.xml.Fast;

@:nativeGen
class Emitter extends Entity {
    
    public var path:String = "";
    public var dying:Bool = false;
    public var groupParticles:Bool = false;

    public var effects:Array<Effect>;

    public var parentEffect:Effect;

    public function new(_other:Entity, _effectsLib:EffectsLibrary, _particeManager:ParticleManager) {
        super(_other, _effectsLib);

        effects = [];
    }

    public function loadFromXML(_fast:Fast):Void {}

    override public function setGroupParticles(_v:Bool):Void {
        for (effect in effects)
            effect.setGroupParticles(_v);

        this.groupParticles = _v;
    }
}