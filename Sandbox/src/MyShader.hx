package;
import odd.math.Vec2i;
import odd.math.Vec3;
import odd.math.Vec4;
import odd.rasterizer.Shader;

class MyShader extends Shader
{
    public function new() {
        super();
    }
    
    override public function vertex(position : Vec4) : Vec4
    {
        var p = new Vec4(
            position.x,
            position.y,
            position.z,
            1
        );
        
        return p * transformModel * transformView;
    }
    
    override public function fragment(fragCoord : Vec4, frontFacing : Bool, pointCoord : Vec2i) : Bool
    {
        fragmentColor.x *= (1 - fragCoord.z);
        fragmentColor.y *= (1 - fragCoord.z);
        fragmentColor.z *= (1 - fragCoord.z);
        
        return true;
    }
}