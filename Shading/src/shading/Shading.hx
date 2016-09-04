package shading;

import odd.math.Mat4x4;
import odd.rasterizer.pipeline.Pipeline;
import odd.rasterizer.Camera;
import odd.rasterizer.Geometry;
import odd.rasterizer.Mesh;
import odd.rasterizer.Scene;
import odd.Framebuffer;

import shading.MyShader;

class Shading
{
    // A reference to the rasterization pipeline
    var pipeline : Pipeline;

    public function new(width : Int, height : Int) : Void
    {
        // Create a new rasterization pipeline with provided viewport dimensions
        pipeline = new Pipeline(width, height);
        // Set shader program
        pipeline.setShader(new MyShader());
        // Create a new camera
        var camera = new Camera();
        // Position camera away from the origin point
        camera.translate(0, 0, 5);
        // Set camera projection transform
        camera.setProjectionTransform(Mat4x4.perspective(100, 4 / 3, 1, 100));
        // Create new triangle geometry
        var gTriangle = new Geometry();
        gTriangle.positions = [ -1.0, -1.0, 0.0, /**/ 1.0, -1.0, 0.0, /**/ 0.0, 1.0, 0.0 ];
        gTriangle.indices = [ 0, 1, 2 ];
        // Create a new triangle mesh
        var mTriangle = new Mesh(gTriangle);
        // Create a new scene
        var scene = new Scene();
        scene.setCamera(camera);
        scene.addMesh(mTriangle);
        // Set the scene the pipeline will rasterize
        pipeline.setScene(scene);
    }

    public function update() : Void
    {
        // No need to update anything in this sample
    }

    public function draw(framebuffer : Framebuffer) : Void
    {
        // Clear the framebuffer
        framebuffer.clear(0x123456);
        // Execute the rasterization pipeline
        pipeline.execute(framebuffer);
    }
}