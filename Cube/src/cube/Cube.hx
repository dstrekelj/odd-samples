package cube;

import cube.MyShader;

import odd.math.Mat4x4;
import odd.rasterizer.pipeline.Pipeline;
import odd.rasterizer.Camera;
import odd.rasterizer.Geometry;
import odd.rasterizer.Mesh;
import odd.rasterizer.Scene;
import odd.Framebuffer;

class Cube
{
    // A reference to the rasterization pipeline
    var pipeline : Pipeline;
    // A reference to the cube mesh
    var mCube : Mesh;

    public function new(width : Int, height : Int)
    {
        // Create a new rasterization pipeline with provided viewport dimensions
        pipeline = new Pipeline(width, height);
        // Set shader program
        pipeline.setShader(new MyShader());
        // Create a new camera
        var camera = new Camera();
        camera.translate(0, 0, 5);
        camera.setProjectionTransform(Mat4x4.perspective(100, 4 / 3, 1, 100));
        // Create new cube geometry
        var gCube = new Geometry();
        gCube.positions = [
            -1.0,-1.0, 1.0, /**/ 1.0,-1.0, 1.0, /**/ 1.0, 1.0, 1.0, /**/ -1.0, 1.0, 1.0,
            -1.0,-1.0,-1.0, /**/ 1.0,-1.0,-1.0, /**/ 1.0, 1.0,-1.0, /**/ -1.0, 1.0,-1.0
        ];
        gCube.colors = [
            1.0, 0.0, 0.0, /**/ 0.0, 1.0, 0.0, /**/ 0.0, 0.0, 1.0, /**/ 0.0, 1.0, 1.0,
            1.0, 0.0, 1.0, /**/ 1.0, 1.0, 0.0, /**/ 1.0, 1.0, 1.0, /**/ 0.0, 0.0, 0.0
        ];
        gCube.indices = [
            0, 1, 2, /**/ 2, 3, 0,  // +z plane
            1, 5, 6, /**/ 6, 2, 1,  // +x plane
            5, 4, 7, /**/ 7, 6, 5,  // -z plane
            4, 0, 3, /**/ 3, 7, 4,  // -x plane
            0, 4, 5, /**/ 5, 1, 0,  // -y plane
            3, 2, 6, /**/ 6, 7, 3   // +y plane
        ];
        // Create a new cube mesh
        mCube = new Mesh(gCube);
        // Create a new Scene
        var scene = new Scene();
        scene.setCamera(camera);
        scene.addMesh(mCube);
        // Set the scene the pipeline will rasterize
        pipeline.setScene(scene);
    }

    public function update() : Void
    {
        // Rotate cube mesh
        mCube.transform *= Mat4x4.rotateX(0.02);
        mCube.transform *= Mat4x4.rotateY(0.04);
        mCube.transform *= Mat4x4.rotateZ(0.06);
    }

    public function draw(framebuffer : Framebuffer) : Void
    {
        // Clear the framebuffer
        framebuffer.clear(0x123456);
        // Execute the rasterization pipeline
        pipeline.execute(framebuffer);
    }
}