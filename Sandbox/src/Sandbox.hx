package;

import odd.Framebuffer;
import odd.geom.Geometry;
import odd.geom.Mesh;
import odd.math.Mat4x4;
import odd.rasterizer.RenderMethod;
import odd.rasterizer.Pipeline;
import odd.rasterizer.Shader;

/**
 * ...
 * @author 
 */
class Sandbox
{
    var pipeline : Pipeline;
    var m : Mesh;
    
    public function new()
    {
        var g = new Geometry();
        
        g.positions = [
            -1.0, -1.0, 0.0,    1.0, -1.0, 0.0,     1.0, 1.0, 0.0,      -1.0, 1.0, 0.0
        ];
        g.colors = [
            1.0, 0.0, 0.0,      0.0, 1.0, 0.0,     0.0, 0.0, 1.0,       1.0, 1.0, 0.0
        ];
        g.indices = [
            0, 1, 2,    2, 3, 0
        ];
        
        m = new Mesh(g);
        
        pipeline = new Pipeline(800, 600);
        pipeline.shader = new MyShader();
        pipeline.addMesh(m);
    }
    
    public function update() : Void
    {
        //m.transform *= Mat4x4.translate(0, 0, -0.01);
        m.transform *= Mat4x4.rotateY(0.01);
    }
    
    public function draw(framebuffer : Framebuffer) : Void
    {
        framebuffer.clear(0x222222);
        pipeline.execute(framebuffer);  
    }
}