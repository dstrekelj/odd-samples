package odd.samples.sample05;

import odd.math.Angle;
import odd.math.Mat4x4;
import odd.rasterizer.pipeline.Pipeline;
import odd.rasterizer.tools.PrimitiveGeometry;
import odd.rasterizer.Camera;
import odd.rasterizer.Mesh;
import odd.rasterizer.Scene;
import odd.Framebuffer;

class Sample
{
    // A reference to the rasterization pipeline
    var pipeline : Pipeline;

    public function new(width : Int, height : Int) : Void
    {
        // Create a new camera
        var camera = new Camera();
        camera.setProjectionTransform(Mat4x4.perspective(Angle.rad(60), width / height, 1, 20));
        camera.rotate(Angle.rad(-25), Angle.rad(-25), 0);
        camera.translate(0, 0, 10);

        // Create new plane mesh
        var mPlane = new Mesh(PrimitiveGeometry.plane());
        mPlane.transform *= Mat4x4.scale(4, 4, 0);
        mPlane.transform *= Mat4x4.rotateX(Angle.rad(-90));
        mPlane.transform *= Mat4x4.translate(0, -1, 0);

        // Create new cube mesh
        var mCube = new Mesh(PrimitiveGeometry.cube());
        mCube.transform *= Mat4x4.translate(-2, 0, 2);

        // Create new pyramid mesh
        var mPyramid = new Mesh(PrimitiveGeometry.pyramid());
        mPyramid.transform *= Mat4x4.translate(2, 0, -2);

        // Create a new scene
        var scene = new Scene();
        scene.setCamera(camera);
        scene.addMesh(mPlane);
        scene.addMesh(mCube);
        scene.addMesh(mPyramid);

        // Create a new rasterization pipeline with provided viewport dimensions
        pipeline = new Pipeline(width, height);
        pipeline.setShader(new SampleShader());
        pipeline.setScene(scene);
    }

    public function update() : Void
    {
        // Nothing to update
    }

    public function draw(framebuffer : Framebuffer) : Void
    {
        // Clear the framebuffer
        framebuffer.clear(0xffffff);
        // Execute the rasterization pipeline
        pipeline.execute(framebuffer);
    }
}