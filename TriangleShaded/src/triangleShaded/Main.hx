package triangleShaded;

import odd.Context;

import triangleShaded.TriangleShaded;

class Main
{
    static inline var WIDTH : Int = 640;
    static inline var HEIGHT : Int = 480;

    static function main() : Void
    {
        Context.init(WIDTH, HEIGHT);

        var triangleShaded = new TriangleShaded(WIDTH, HEIGHT);

        Context.run(triangleShaded.update, triangleShaded.draw);
    }
}