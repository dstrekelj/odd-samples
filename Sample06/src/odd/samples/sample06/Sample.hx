package odd.samples.sample06;

import odd.math.Angle;
import odd.math.Mat4x4;
import odd.rasterizer.pipeline.Pipeline;
import odd.rasterizer.Camera;
import odd.rasterizer.Geometry;
import odd.rasterizer.Mesh;
import odd.rasterizer.Scene;
import odd.Assets;
import odd.Framebuffer;

class Sample
{
    // A reference to the rasterization pipeline
    var pipeline : Pipeline;
    // A reference to the Suzanne mesh
    var mSuzanne : Mesh;

    public function new(width : Int, height : Int) : Void
    {
        // Create a new camera
        var camera = new Camera();
        camera.setProjectionTransform(Mat4x4.perspective(Angle.rad(90), width / height, 1, 20));
        camera.rotate(Angle.rad(-25), 0, 0);
        camera.translate(0, 0, 4);

        // Create new Suzanne geometry
        var gSuzanne = new Geometry();
        gSuzanne.positions = Assets.suzanne_obj.positions;
        gSuzanne.indices = Assets.suzanne_obj.indices;

        // Create new Suzanne mesh
        mSuzanne = new Mesh(gSuzanne);
        mSuzanne.transform *= Mat4x4.scale(2, 2, 2);

        // Create a new scene
        var scene = new Scene();
        scene.setCamera(camera);
        scene.addMesh(mSuzanne);

        // Create a new rasterization pipeline with provided viewport dimensions
        pipeline = new Pipeline(width, height);
        pipeline.setShader(new SampleShader());
        pipeline.setScene(scene);
    }

    public function update() : Void
    {
        // Rotate Suzanne mesh
        mSuzanne.transform *= Mat4x4.rotateY(-0.02);
    }

    public function draw(framebuffer : Framebuffer) : Void
    {
        // Clear the framebuffer
        framebuffer.clear(0x000000);
        // Execute the rasterization pipeline
        pipeline.execute(framebuffer);
    }
}