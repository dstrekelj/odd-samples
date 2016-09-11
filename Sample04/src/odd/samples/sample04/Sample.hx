package odd.samples.sample04;

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
    // A reference to the plane mesh
    var mPlane : Mesh;

    public function new(width : Int, height : Int) : Void
    {
        // Create a new camera
        var camera = new Camera();
        // Set camera projection transform
        camera.setProjectionTransform(Mat4x4.perspective(Angle.rad(90), width / height, 1, 10));
        // Set camera position in scene
        camera.translate(0, 0, 4);

        // Create new plane geometry
        var gPlane = new Geometry();
        gPlane.positions = [
            -1.0,-1.0, 0.0,
             1.0,-1.0, 0.0,
             1.0, 1.0,-2.0,
            -1.0, 1.0,-2.0
        ];
        gPlane.textureCoordinates = [
            0.0, 0.0,
            1.0, 0.0,
            1.0, 1.0,
            0.0, 1.0
        ];
        gPlane.indices = [
            0, 1, 2, 2, 3, 0
        ];

        // Create a new plane mesh
        mPlane = new Mesh(gPlane);
        mPlane.texture = Textures.checkerboard(64, 64, 8, Color.RED, Color.WHITE);

        // Create a new scene
        var scene = new Scene();
        scene.setCamera(camera);
        scene.addMesh(mPlane);

        // Create a new rasterization pipeline with provided viewport dimensions
        pipeline = new Pipeline(width, height);
        pipeline.setShader(new SampleShader());
        pipeline.setScene(scene);
    }

    public function update() : Void
    {
        // Rotate plane along the scene Y-axis
        mPlane.transform *= Mat4x4.rotateY(0.02);
    }

    public function draw(framebuffer : Framebuffer) : Void
    {
        // Clear the framebuffer
        framebuffer.clear(0x333333);
        // Execute the rasterization pipeline
        pipeline.execute(framebuffer);
    }
}