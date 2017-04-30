package timelinefx;

@:enum
abstract BlendMode(Int)
from Int to Int {
    var AlphaBlend:Int = 0;
    var AdditiveBlend:Int = 1;
}

@:nativeGen
class Entity {
    public var x:Float = 0.0;
    public var y:Float = 0.0;
    public var name:String = "";

    public var oldX:Float = 0.0;
    public var oldY:Float = 0.0;
    public var wx:Float = 0.0;
    public var wy:Float = 0.0;
    public var oldWX:Float = 0.0;
    public var oldWY:Float = 0.0;
    public var z:Float = 1.0;
    public var oldZ:Float = 1.0;
    public var relative:Bool = true;

    /*
    public var r:Int = 0;
    public var g:Int = 0;
    public var b:Int = 0;
    */
    public var red:Int = 255;
    public var green:Int = 255;
    public var blue:Int = 255;
    public var oldRed:Int = 255;
    public var oldGreen:Int = 255;
    public var oldBlue:Int = 255;

    public var width:Float = 0.0;
    public var height:Float = 0.0;
    public var weight:Float = 0.0;
    public var gravity:Float = 0.0;
    public var baseWeight:Float = 0.0;
    public var oldWeight:Float = 0.0;
    public var scaleX:Float = 1.0;
    public var scaleY:Float = 1.0;
    public var sizeX:Float = 1.0;
    public var sizeY:Float = 1.0;
    public var oldScaleX:Float = 1.0;
    public var oldScaleY:Float = 1.0;

    public var speed:Float = 0.0;
    public var baseSpeed:Float = 0.0;
    public var oldSpeed:Float = 0.0;
    public var updateSpeed:Bool = true;

    public var direction:Float = 0.0;
    public var directionLocked:Bool = false;
    public var angle:Float = 0.0;
    public var oldAngle:Float = 0.0;
    public var relativeAngle:Float = 0.0;
    public var oldRelativeAngle:Float = 0.0;

    public var avatar:AnimImage = null;
    public var frameOffset:Int = 0;
    public var framerate:Float = 1.0;
    public var currentFrame:Int = 0;
    public var oldCurrentFrame:Int = 0;
    public var animating:Bool = false;
    public var animateOnce:Bool = false;
    public var animAction:Bool = false;
    public var handleX:Int = 0;
    public var handleY:Int = 0;
    public var autoCenter:Bool = true;
    public var okToRender:Bool = true;

    public var dob:Float = 0.0;
    public var age:Float = 0.0;
    public var rptAgeA:Int = 0;
    public var rptAgeC:Int = 0;
    public var aCycles:Int = 0;
    public var cCycles:Int = 0;
    public var oldAge:Int = 0;
    public var dead:Bool = false;
    public var destroyed:Bool = false;
    public var lifeTime:Float = 0.0;
    public var timediff:Float = 0.0;

    public var aabb_Calculate:Bool = true;
    public var collisionXMin:Float = 0.0;
    public var collisionYMin:Float = 0.0;
    public var collisionXMax:Float = 0.0;
    public var collisionYMax:Float = 0.0;
    public var aabb_XMin:Float = 0.0;
    public var aabb_YMin:Float = 0.0;
    public var aabb_XMax:Float = 0.0;
    public var aabb_YMax:Float = 0.0;
    public var aabb_MaxWidth:Float = 0.0;
    public var aabb_MaxHeight:Float = 0.0;
    public var aabb_MinWidth:Float = 0.0;
    public var aabb_MinHeight:Float = 0.0;
    public var radiusCalculate:Bool = true;
    public var imageRadius:Float = 0.0;
    public var entityRadius:Float = 0.0;
    public var imageDiameter:Float = 0.0;

    public var parent:Entity = null;
    public var rootParent:Entity = null;

    public var childrenOwner:Bool = true;

    public var blendMode:Int = BlendMode.AlphaBlend;

    public var alpha:Float = 1.0;
    public var oldAlpha:Float = 0.0;

    public var runChildren:Bool = false;
    public var pixelsPerSecond:Float = 0.0;

    public var effectsLib:EffectsLibrary = null;

    // no copy!
    public var matrix:Matrix2;
    public var speedVec:Vec2;
    public var children:Array<Entity>;

    inline public function new(_other:Entity, _effecsLib:EffectsLibrary) {
        effectsLib = _effecsLib;

        if (_other != null) {
            x = _other.x;
            y = _other.y;
            name = _other.name;

            oldX = _other.oldX;
            oldY = _other.oldY;
            wx = _other.wx;
            wy = _other.wy;
            oldWX = _other.oldWX;
            oldWY = _other.oldWY;
            z = _other.z;
            oldZ = _other.oldZ;
            relative = _other.relative;

            /*
            r = _other.r;
            g = _other.g;
            b = _other.b;
            */
            red = _other.red;
            green = _other.green;
            blue = _other.blue;
            oldRed = _other.oldRed;
            oldGreen = _other.oldGreen;
            oldBlue = _other.oldBlue;

            width = _other.width;
            height = _other.height;
            weight = _other.weight;
            gravity = _other.gravity;
            baseWeight = _other.baseWeight;
            oldWeight = _other.oldWeight;
            scaleX = _other.scaleX;
            scaleY = _other.scaleY;
            sizeX = _other.sizeX;
            sizeY = _other.sizeY;
            oldScaleX = _other.oldScaleX;
            oldScaleY = _other.oldScaleY;

            speed = _other.speed;
            baseSpeed = _other.baseSpeed;
            oldSpeed = _other.oldSpeed;
            updateSpeed = _other.updateSpeed;

            direction = _other.direction;
            directionLocked = _other.directionLocked;
            angle = _other.angle;
            oldAngle = _other.oldAngle;
            relativeAngle = _other.relativeAngle;
            oldRelativeAngle = _other.oldRelativeAngle;

            avatar = _other.avatar;
            frameOffset = _other.frameOffset;
            framerate = _other.framerate;
            currentFrame = _other.currentFrame;
            oldCurrentFrame = _other.oldCurrentFrame;
            animating = _other.animating;
            animateOnce = _other.animateOnce;
            animAction = _other.animAction;
            handleX = _other.handleX;
            handleY = _other.handleY;
            autoCenter = _other.autoCenter;
            okToRender = _other.okToRender;

            dob = _other.dob;
            age = _other.age;
            rptAgeA = _other.rptAgeA;
            rptAgeC = _other.rptAgeC;
            aCycles = _other.aCycles;
            cCycles = _other.cCycles;
            oldAge = _other.oldAge;
            dead = _other.dead;
            destroyed = _other.destroyed;
            lifeTime = _other.lifeTime;
            timediff = _other.timediff;

            aabb_Calculate = _other.aabb_Calculate;
            collisionXMin = _other.collisionXMin;
            collisionYMin = _other.collisionYMin;
            collisionXMax = _other.collisionXMax;
            collisionYMax = _other.collisionYMax;
            aabb_XMin = _other.aabb_XMin;
            aabb_YMin = _other.aabb_YMin;
            aabb_XMax = _other.aabb_XMax;
            aabb_YMax = _other.aabb_YMax;
            aabb_MaxWidth = _other.aabb_MaxWidth;
            aabb_MaxHeight = _other.aabb_MaxHeight;
            aabb_MinWidth = _other.aabb_MinWidth;
            aabb_MinHeight = _other.aabb_MinHeight;
            radiusCalculate = _other.radiusCalculate;
            imageRadius = _other.imageRadius;
            entityRadius = _other.entityRadius;
            imageDiameter = _other.imageDiameter;

            parent = _other.parent;
            rootParent = _other.rootParent;

            childrenOwner = _other.childrenOwner;

            blendMode = _other.blendMode;

            alpha = _other.alpha;
            oldAlpha = _other.oldAlpha;

            runChildren = _other.runChildren;
            pixelsPerSecond = _other.pixelsPerSecond;

            effectsLib = _other.effectsLib;
        }

        matrix = new Matrix2();
        speedVec = new Vec2(0.0,0.0);

        children = [];
    }

    public function capture():Void {
        this.oldZ = this.z;
        this.oldWX = this.wx;
        this.oldWY = this.wy;
        this.oldX = this.x;
        this.oldY = this.y;
        this.oldAngle = this.angle;
        this.oldRelativeAngle = this.relativeAngle;
        this.oldScaleX = this.scaleX;
        this.oldScaleY = this.scaleY;
        this.oldCurrentFrame = this.currentFrame;
    }

    public function captureAll():Void {
        this.capture();
        for (e in children)
            e.capture();
    }

    public function destroy() {
        parent = null;
        avatar = null;
        rootParent = null;
        clearChildren();
        destroyed = true;
    }

    public function removeChild(_e:Entity):Void {
        if (children.remove(_e))
            _e.parent = null;
    }

    public function clearChildren():Void {
        for (e in children)
            e.destroy();
        children = [];
    }

    public function killChildren():Void {
        for (e in children) {
            e.killChildren();
            e.dead = true;
        }
    }

    public function update():Bool {
        var currentUpdateTime:Float = effectsLib.currentUpdateTime;

        if (updateSpeed && speed != 0) {
            pixelsPerSecond = speed / currentUpdateTime;
            speedVec.x = Math.sin(direction / 180.0 * MathUtils.PI) * pixelsPerSecond;
            speedVec.y = Math.cos(direction / 180.0 * MathUtils.PI) * pixelsPerSecond;

            this.x = speedVec.x * this.z;
            this.y = speedVec.y * this.z;
        }

        if (weight != 0) {
            gravity += weight / currentUpdateTime;
            this.y += (gravity / currentUpdateTime) * this.z;
        }

        if (relative) {
            var radians = angle / 180 * MathUtils.PI;
            matrix.set(Math.cos(radians), Math.sin(radians), -Math.sin(radians), Math.cos(radians));
        }

        if (parent != null && relative) {
            this.z = parent.z;
            matrix.transformSelf(parent.matrix);

            var rotVec:Vec2 = parent.matrix.transformVec2(this.x, this.y);

            this.wx = parent.wx + rotVec.x * this.z;
            this.wy = parent.wy + rotVec.y * this.z;

            relativeAngle = parent.relativeAngle + angle;
        } else {
            this.wx = this.x;
            this.wy = this.y;
        }

        if (parent != null) {
            relativeAngle = angle;
        }

        if (avatar != null && animating) {
            currentFrame += Math.floor(framerate / currentUpdateTime);
            if (animateOnce) {
                if (currentFrame > avatar.frames-1)
                    currentFrame = avatar.frames-1
                else if (currentFrame <= 0)
                    currentFrame = 0;
            }
        }

        if (aabb_Calculate)
            updateBoundingBox();

        if (radiusCalculate)
            updateEntityRadius();

        updateChildren();

        return true;
    }

    public function updateChildren():Void {
        var i:Int = 0;
        while (i < children.length) {
            if (!children[i].update()) {
                children.splice(i, 1);
                i--;
            }
            i++;
        }
    }

    public function updateBoundingBox():Void {
        collisionXMin = aabb_MinWidth * scaleX * this.z;
        collisionYMin = aabb_MinHeight * scaleY * this.z;
        collisionXMax = aabb_MaxWidth * scaleX * this.z;
        collisionYMax = aabb_MaxHeight * scaleY * this.z;

        aabb_XMin = collisionXMin;
        aabb_YMin = collisionYMin;
        aabb_XMax = collisionXMax;
        aabb_YMax = collisionYMax;

        if (children.length == 0)
            updateParentBoundingBox();
    }

    public function updateEntityRadius():Void {
        if (autoCenter) {
            if (avatar != null) {
                var aMaxRadius = avatar.maxRadius;
                var aWidth = avatar.width;
                var aHeight = avatar.height;

                if (aMaxRadius != 0)
                    imageRadius = Math.max(aMaxRadius * scaleX * this.z, aMaxRadius * scaleY * this.z);
                else
                    imageRadius = MathUtils.dist2D( 
                        aWidth / 2.0 * scaleX * this.z, 
                        aHeight / 2.0 * scaleY * this.z, 
                        aWidth * scaleX * this.z, 
                        aHeight * scaleY * this.z 
                    );
            } else {
                imageRadius = 0;
            }
        } else {
            var aMaxRadius = avatar.maxRadius;
            var aWidth = avatar.width;
            var aHeight = avatar.height;

            if (aMaxRadius != 0)
                imageRadius = MathUtils.dist2D( 
                    handleX * scaleX * this.z, 
                    handleY * scaleY * this.z, 
                    aWidth / 2.0 * scaleX * this.z, 
                    aHeight / 2.0 * scaleY * this.z 
                ) + Math.max( aMaxRadius * scaleX * this.z, aMaxRadius * scaleY * this.z );
            else
                imageRadius = MathUtils.dist2D( 
                    handleX * scaleX * this.z, 
                    handleY * scaleY * this.z, 
                    aWidth * scaleX * this.z, 
                    aHeight * scaleY * this.z 
                );
        }

        entityRadius = imageRadius;
        imageDiameter = imageRadius * 2.0;

        if (rootParent != null)
            updateRootParentEntityRadius();
    }

    public function updateParentEntityRadius():Void {
        if (parent != null) {
            if (children.length > 0)
                parent.entityRadius += Math.max(
                    0.0,
                    MathUtils.dist2D(this.wx, this.wy, parent.wx, parent.wy) + entityRadius - parent.entityRadius
                );
            else
                parent.entityRadius += Math.max(
                    0.0,
                    MathUtils.dist2D(this.wx, this.wy, parent.wx, parent.wy) + imageRadius - parent.entityRadius
                );
            parent.updateParentEntityRadius();
        }
    }

    public function updateRootParentEntityRadius():Void {
        if (rootParent != null && alpha != 0) {
            rootParent.entityRadius += Math.max(
                0.0,
                MathUtils.dist2D(this.wx, this.wy, rootParent.wx, rootParent.wy) + imageRadius - rootParent.entityRadius
            );
        }
    }

    public function updateParentBoundingBox():Void {
        if (parent != null) {
            parent.aabb_XMax += Math.max( 0.0, this.wx - parent.wx + this.aabb_XMax - parent.aabb_XMax );
            parent.aabb_YMax += Math.max( 0.0, this.wy - parent.wx + this.aabb_YMax - parent.aabb_YMax );
            parent.aabb_XMin += Math.max( 0.0, this.wx - parent.wx + this.aabb_XMin - parent.aabb_XMin );
            parent.aabb_YMin += Math.max( 0.0, this.wy - parent.wy + this.aabb_YMin - parent.aabb_YMin );
        }
    }

    public function assignRootParent(_e:Entity):Void {
        if (parent != null)
            parent.assignRootParent(_e);
        else
            _e.rootParent = this;
    }

    public function setParent(_e:Entity):Void {
        _e.addChild(this); // TODO: this is highly questionable. Why would you do it this way round?
    }

    public function addChild(_e:Entity):Void {
        children.push(_e);
        _e.parent = this;
        _e.radiusCalculate = radiusCalculate;
        _e.assignRootParent(_e);
    }

    public function setAvatar(_avatar:AnimImage):Void {
        avatar = _avatar;
        aabb_MinWidth = -avatar.width * 0.5;
        aabb_MinHeight = -avatar.height * 0.5;
        aabb_MaxWidth = avatar.width * 0.5;
        aabb_MaxHeight = avatar.height * 0.5;
    }

    public function setWidthHeightAabb(_minw:Float, _minh:Float, _maxw:Float, _maxh:Float):Void {
        aabb_MinWidth = _minw;
        aabb_MinHeight = _minh;
        aabb_MaxWidth = _maxw;
        aabb_MaxHeight = _maxh;
    }

    public function setEntityColor(_r:Int, _g:Int, _b:Int):Void {
        this.red = _r;
        this.green = _g;
        this.blue = _b;
    }

    public function move(_xAmount:Float, _yAmount:Float):Void {
        this.x += _xAmount;
        this.y += _yAmount;
    }

    public function compileAll():Void {}

    public function setGroupParticles(_v:Bool):Void {
        for (e in children)
            e.setGroupParticles(_v);
    }

    public function getImages(_images:Array<String>):Void {
        for (e in children)
            e.getImages(_images);
    }
}