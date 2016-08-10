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
    var m2 : Mesh;
    var m3 : Mesh;
    
    public function new()
    {
        var g = new Geometry();
        
        g.positions = [
          -1.0,-1.0,-1.0,  -1.0,-1.0, 1.0,  -1.0, 1.0, 1.0,
           1.0, 1.0,-1.0,  -1.0,-1.0,-1.0,  -1.0, 1.0,-1.0,
           1.0,-1.0, 1.0,  -1.0,-1.0,-1.0,   1.0,-1.0,-1.0,
           1.0, 1.0,-1.0,   1.0,-1.0,-1.0,  -1.0,-1.0,-1.0,
          -1.0,-1.0,-1.0,  -1.0, 1.0, 1.0,  -1.0, 1.0,-1.0,
           1.0,-1.0, 1.0,  -1.0,-1.0, 1.0,  -1.0,-1.0,-1.0,
          -1.0, 1.0, 1.0,  -1.0,-1.0, 1.0,   1.0,-1.0, 1.0,
           1.0, 1.0, 1.0,   1.0,-1.0,-1.0,   1.0, 1.0,-1.0,
           1.0,-1.0,-1.0,   1.0, 1.0, 1.0,   1.0,-1.0, 1.0,
           1.0, 1.0, 1.0,   1.0, 1.0,-1.0,  -1.0, 1.0,-1.0,
           1.0, 1.0, 1.0,  -1.0, 1.0,-1.0,  -1.0, 1.0, 1.0,
           1.0, 1.0, 1.0,  -1.0, 1.0, 1.0,   1.0,-1.0, 1.0
        ];
        g.colors = [
            0.583, 0.771, 0.014,   0.609, 0.115, 0.436,   0.327, 0.483, 0.844,
            0.822, 0.569, 0.201,   0.435, 0.602, 0.223,   0.310, 0.747, 0.185,
            0.597, 0.770, 0.761,   0.559, 0.436, 0.730,   0.359, 0.583, 0.152,
            0.483, 0.596, 0.789,   0.559, 0.861, 0.639,   0.195, 0.548, 0.859,
            0.014, 0.184, 0.576,   0.771, 0.328, 0.970,   0.406, 0.615, 0.116,
            0.676, 0.977, 0.133,   0.971, 0.572, 0.833,   0.140, 0.616, 0.489,
            0.997, 0.513, 0.064,   0.945, 0.719, 0.592,   0.543, 0.021, 0.978,
            0.279, 0.317, 0.505,   0.167, 0.620, 0.077,   0.347, 0.857, 0.137,
            0.055, 0.953, 0.042,   0.714, 0.505, 0.345,   0.783, 0.290, 0.734,
            0.722, 0.645, 0.174,   0.302, 0.455, 0.848,   0.225, 0.587, 0.040,
            0.517, 0.713, 0.338,   0.053, 0.959, 0.120,   0.393, 0.621, 0.362,
            0.673, 0.211, 0.457,   0.820, 0.883, 0.371,   0.982, 0.099, 0.879
        ];
        g.indices = [for (i in 0...Std.int(g.positions.length / 3)) i];
        
        m = new Mesh(g);
        m2 = new Mesh(g);
        m2.transform *= Mat4x4.translate(4, 4, -10);
        m3 = new Mesh(g);
        m3.transform *= Mat4x4.translate(4, -4, -2);
        
        pipeline = new Pipeline(800, 600);
        pipeline.shader = new MyShader();
        pipeline.addMesh(m);
        pipeline.addMesh(m2);
        pipeline.addMesh(m3);
    }
    
    public function update() : Void
    {
        //m.transform *= Mat4x4.translate(0, 0, -0.01);
        m.transform *= Mat4x4.rotateX(0.01);
        m.transform *= Mat4x4.rotateY(0.02);
        m.transform *= Mat4x4.rotateZ(0.03);
        m2.transform *= Mat4x4.rotateX(-0.01);
        //m2.transform *= Mat4x4.rotateY(0.02);
        m2.transform *= Mat4x4.rotateZ( -0.03);
        m3.transform *= Mat4x4.rotateX(-0.01);
        //m3.transform *= Mat4x4.rotateY(0.02);
        m3.transform *= Mat4x4.rotateZ(0.03);
    }
    
    public function draw(framebuffer : Framebuffer) : Void
    {
        framebuffer.clear(0x000000);
        pipeline.execute(framebuffer);
    }
}