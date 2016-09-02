package triangle;

import odd.Framebuffer;
import odd.geom.Geometry;
import odd.geom.Mesh;
import odd.rasterizer.Pipeline;
import odd.rasterizer.Shader;

class Triangle
{
    var pipeline : Pipeline;
    var triangleGeometry : Geometry;

    public function new(width : Int, height : Int) : Void
    {
        pipeline = new Pipeline(width, height);
        pipeline.shader = new Shader();

        triangleGeometry = new Geometry();
        triangleGeometry.positions = [
            -1.0, -1.0, 0.0,    1.0, -1.0, 0.0,     0.0, 1.0, 0.0
        ];
        triangleGeometry.indices = [
            0, 1, 2
        ];

        pipeline.scene.meshes.push(new Mesh(triangleGeometry));
    }

    public function update() : Void
    {

    }

    public function draw(framebuffer : Framebuffer) : Void
    {
        framebuffer.clear(0x0000ff);
        pipeline.execute(framebuffer);
    }
}