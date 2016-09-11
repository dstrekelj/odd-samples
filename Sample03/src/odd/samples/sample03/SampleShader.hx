package odd.samples.sample03;

import odd.math.Vec2i;
import odd.math.Vec4;
import odd.rasterizer.Shader;

class SampleShader extends Shader
{
    public function new() : Void
    {
        super();
    }

    override public function vertex(position : Vec4) : Vec4
    {
        return position * transformModel * transformView * transformProjection;
    }

    override public function fragment(fragCoord : Vec4, pointCoord : Vec2i) : Bool
    {
        var textureSample = texture.sample(fragmentTextureCoordinate.x, fragmentTextureCoordinate.y); 
        fragmentColor.x = textureSample.Rf;
        fragmentColor.y = textureSample.Gf;
        fragmentColor.z = textureSample.Bf;
        
        return true;
    }
}