package room;

import odd.math.Vec2i;
import odd.math.Vec4;
import odd.rasterizer.Shader;

class MyShader extends Shader
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
        if (texture != null)
        {
            var textureSample = texture.sample(fragmentTextureCoordinate.x, fragmentTextureCoordinate.y);
            fragmentColor.x = textureSample.Rf;
            fragmentColor.y = textureSample.Gf;
            fragmentColor.z = textureSample.Bf;
        }
        else
        {
            fragmentColor.x = 1;
            fragmentColor.y = 1;
            fragmentColor.z = 1;
        }

        fragmentColor *= (1 - fragCoord.z);

        return true;
    }
}