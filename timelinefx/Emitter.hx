package timelinefx;

import haxe.xml.Fast;

@:nativeGen
class Emitter extends Entity {
    
    public var path:String = "";
    public var dying:Bool = false;

    public var effects:Map<String, Effect>;

    public var parentEffect:Effect;

    public function new(_other:Entity, _effectsLib:EffectsLibrary, _particeManager:ParticleManager) {
        super(_other, _effectsLib);

        effects = new Map<String, Effect>();
    }

    public function loadFromXML(_fast:Fast):Void {}
}