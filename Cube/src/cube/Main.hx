package cube;

import cube.Cube;

import odd.Context;

class Main
{
    static inline var WIDTH = 320;
    static inline var HEIGHT = 240;

    static function main() : Void
    {
        Context.init(WIDTH, HEIGHT);

        var cube = new Cube(WIDTH, HEIGHT);

        Context.run(cube.update, cube.draw);
    }
}