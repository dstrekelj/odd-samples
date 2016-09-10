package triangleShaded;

import odd.math.Angle;
import odd.math.Mat4x4;
import odd.rasterizer.pipeline.Pipeline;
import odd.rasterizer.Camera;
import odd.rasterizer.Geometry;
import odd.rasterizer.Mesh;
import odd.rasterizer.Scene;
import odd.Framebuffer;

import triangleShaded.MyShader;

class TriangleShaded
{
    static inline var TIME_STEP = 1 / 60;
    
    var time : Float;

    var pipeline : Pipeline;
    var mTriangle : Mesh;

    public function new(width : Int, height : Int) : Void
    {
        time = 0;

        var camera = new Camera();
        camera.setProjectionTransform(Mat4x4.perspective(Angle.rad(60), width / height, 1, 10));
        camera.translate(0, 0, 3);

        var gTriangle = new Geometry();
        gTriangle.positions = [-1.0, -1.0, 0.0, /**/ 1.0, -1.0, 0.0, /**/ 0.0, 1.0, 0.0];
        gTriangle.colors = [1.0, 0.0, 0.0, /**/ 0.0, 1.0, 0.0, /**/ 0.0, 0.0, 1.0];
        gTriangle.indices = [0, 1, 2];

        mTriangle = new Mesh(gTriangle);

        var scene = new Scene();
        scene.setCamera(camera);
        scene.addMesh(mTriangle);

        pipeline = new Pipeline(width, height);
        pipeline.setShader(new MyShader());
        pipeline.setScene(scene);
    }

    public function update() : Void
    {
        time += TIME_STEP;

        mTriangle.transform *= Mat4x4.rotateY(Math.cos(time) / 100);
    }

    public function draw(framebuffer : Framebuffer) : Void
    {
        framebuffer.clear(0x333333);
        pipeline.execute(framebuffer);
    }
}