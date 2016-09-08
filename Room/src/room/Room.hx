package room;

import odd.math.Angle;
import odd.math.Mat4x4;
import odd.rasterizer.pipeline.Pipeline;
import odd.rasterizer.tools.PrimitiveGeometry;
import odd.rasterizer.tools.Textures;
import odd.rasterizer.Camera;
import odd.rasterizer.Mesh;
import odd.rasterizer.Scene;
import odd.Color;
import odd.Framebuffer;

import room.MyShader;

class Room
{
    var pipeline : Pipeline;

    var mDiamond : Mesh;

    public function new(width : Int, height : Int) : Void
    {
        pipeline = new Pipeline(width, height);
        pipeline.setShader(new MyShader());

        var gPlane = PrimitiveGeometry.plane();
        var gOctahedron = PrimitiveGeometry.octahedron();
        
        var camera = new Camera();
        camera.setProjectionTransform(Mat4x4.perspective(90, 4 / 3, 1, 100));
        camera.translate(0, 0, 5);

        var mFloor = new Mesh(gPlane);
        mFloor.texture = Textures.noise(64, 64, 2);
        mFloor.geometry.textureCoordinates = [0.0, 1.0, 1.0, 1.0, 1.0, 0.0, 0.0, 0.0];
        mFloor.transform *= Mat4x4.scale(20, 5, 0);
        mFloor.transform *= Mat4x4.rotateX(Angle.rad(-90));
        mFloor.transform *= Mat4x4.translate(0, -5, -5);
        
        var mWallN = new Mesh(gPlane);
        mWallN.texture = Textures.solid(Color.RED);
        mWallN.geometry.textureCoordinates = [0.0, 1.0, 1.0, 1.0, 1.0, 0.0, 0.0, 0.0];
        mWallN.transform *= Mat4x4.scale(20, 10, 0);
        mWallN.transform *= Mat4x4.translate(0, 5, -5);

        var mWallE = new Mesh(gPlane);
        mWallE.texture = Textures.checkerboard(64, 64, 8, Color.RED, Color.WHITE);
        mWallE.geometry.textureCoordinates = [0.0, 1.0, 1.0, 1.0, 1.0, 0.0, 0.0, 0.0];
        mWallE.transform *= Mat4x4.scale(2, 10, 0);
        mWallE.transform *= Mat4x4.rotateY(Angle.rad(90));
        mWallE.transform *= Mat4x4.translate(-5, 0, 0);

        var mWallW = new Mesh(gPlane);
        mWallW.texture = Textures.checkerboard(64, 64, 8, Color.BLUE, Color.WHITE);
        mWallW.geometry.textureCoordinates = [0.0, 1.0, 1.0, 1.0, 1.0, 0.0, 0.0, 0.0];
        mWallW.transform *= Mat4x4.scale(2, 10, 0);
        mWallW.transform *= Mat4x4.rotateY(Angle.rad(-90));
        mWallW.transform *= Mat4x4.translate(5, 0, 0);

        mDiamond = new Mesh(gOctahedron);
        mDiamond.transform *= Mat4x4.scale(1.5, 2, 1.5);
        
        var scene = new Scene();
        scene.setCamera(camera);
        scene.addMesh(mFloor);
        scene.addMesh(mWallN);
        scene.addMesh(mWallE);
        scene.addMesh(mWallW);
        scene.addMesh(mDiamond);
        pipeline.setScene(scene);
    }

    public function update() : Void
    {
        mDiamond.transform *= Mat4x4.rotateY(0.1);
    }

    public function draw(framebuffer : Framebuffer) : Void
    {
        framebuffer.clear(0x123456);
        pipeline.execute(framebuffer);
    }
}