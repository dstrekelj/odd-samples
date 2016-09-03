package cube;

import cube.MyShader;

import odd.math.Mat4x4;
import odd.rasterizer.object.Camera;
import odd.rasterizer.object.Geometry;
import odd.rasterizer.object.Mesh;
import odd.rasterizer.object.Scene;
import odd.rasterizer.Pipeline;
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
            -1.0,-1.0,-1.0, /**/ 1.0,-1.0,-1.0, /**/ 1.0, 1.0,-1.0, /**/ -1.0, 1.0,-1.0,
            -1.0,-1.0, 1.0, /**/ 1.0,-1.0, 1.0, /**/ 1.0, 1.0, 1.0, /**/ -1.0, 1.0, 1.0 
        ];
        gCube.colors = [
            1.0, 0.0, 0.0, /**/ 0.0, 1.0, 0.0, /**/ 0.0, 0.0, 1.0, /**/ 0.0, 1.0, 1.0,
            1.0, 0.0, 1.0, /**/ 1.0, 1.0, 0.0, /**/ 1.0, 1.0, 1.0, /**/ 0.0, 0.0, 0.0
        ];
        gCube.indices = [
            2, 1, 0, /**/ 0, 3, 2,  // -z plane
            6, 5, 1, /**/ 1, 2, 6,  // +x plane
            7, 4, 5, /**/ 5, 6, 7,  // +z plane
            3, 0, 4, /**/ 4, 7, 3,  // -x plane
            5, 4, 0, /**/ 0, 1, 5,  // -y plane
            6, 2, 3, /**/ 3, 7, 6   // +y plane
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