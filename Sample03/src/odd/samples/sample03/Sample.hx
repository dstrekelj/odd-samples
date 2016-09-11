package odd.samples.sample03;

import odd.math.Angle;
import odd.math.Mat4x4;
import odd.rasterizer.pipeline.Pipeline;
import odd.rasterizer.tools.Textures;
import odd.rasterizer.Camera;
import odd.rasterizer.Geometry;
import odd.rasterizer.Mesh;
import odd.rasterizer.Scene;
import odd.Color;
import odd.Framebuffer;

class Sample
{
    // A reference to the rasterization pipeline
    var pipeline : Pipeline;
    // A reference to the triangle mesh
    var mTriangle : Mesh;

    public function new(width : Int, height : Int) : Void
    {
        // Create a new camera
        var camera = new Camera();
        // Set camera projection transform
        camera.setProjectionTransform(Mat4x4.perspective(Angle.rad(90), width / height, 1, 10));
        // Set camera position in scene
        camera.translate(0, 0, 2);

        // Create new triangle geometry
        var gTriangle = new Geometry();
        gTriangle.positions = [-1.0, -1.0, 0.0, /**/ 1.0, -1.0, 0.0, /**/ 0.0, 1.0, 0.0];
        gTriangle.textureCoordinates = [0.0, 0.0, /**/ 1.0, 0.0, /**/ 0.5, 1.0];
        gTriangle.indices = [0, 1, 2];

        // Create a new triangle mesh
        mTriangle = new Mesh(gTriangle);
        mTriangle.texture = Textures.checkerboard(64, 64, 8, Color.RED, Color.WHITE);

        // Create a new scene
        var scene = new Scene();
        scene.setCamera(camera);
        scene.addMesh(mTriangle);

        // Create a new rasterization pipeline with provided viewport dimensions
        pipeline = new Pipeline(width, height);
        pipeline.setShader(new SampleShader());
        pipeline.setScene(scene);
    }

    public function update() : Void
    {
        // Rotate triangle along the scene Y-axis
        mTriangle.transform *= Mat4x4.rotateY(0.02);
    }

    public function draw(framebuffer : Framebuffer) : Void
    {
        // Clear the framebuffer
        framebuffer.clear(0x333333);
        // Execute the rasterization pipeline
        pipeline.execute(framebuffer);
    }
}