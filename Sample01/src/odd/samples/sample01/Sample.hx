package odd.samples.sample01;

import odd.rasterizer.pipeline.Pipeline;
import odd.rasterizer.Geometry;
import odd.rasterizer.Mesh;
import odd.rasterizer.Scene;
import odd.rasterizer.Shader;
import odd.Framebuffer;

class Sample
{
    // A reference to the rasterization pipeline
    var pipeline : Pipeline;

    public function new(width : Int, height : Int) : Void
    {
        // Create new triangle geometry
        var gTriangle = new Geometry();
        gTriangle.positions = [ -1.0, -1.0, 0.0, /**/ 1.0, -1.0, 0.0, /**/ 0.0, 1.0, 0.0 ];
        gTriangle.indices = [ 0, 1, 2 ];

        // Create a new triangle mesh
        var mTriangle = new Mesh(gTriangle);

        // Create a new scene
        var scene = new Scene();
        scene.addMesh(mTriangle);
        
        // Create a new rasterization pipeline with provided viewport dimensions
        pipeline = new Pipeline(width, height);
        // Set shader program
        pipeline.setShader(new Shader());
        // Set the scene to be rasterized
        pipeline.setScene(scene);
    }

    public function update() : Void
    {
        // No need to update anything in this sample
    }

    public function draw(framebuffer : Framebuffer) : Void
    {
        // Clear the framebuffer
        framebuffer.clear(0x333333);
        // Execute the rasterization pipeline
        pipeline.execute(framebuffer);
    }
}