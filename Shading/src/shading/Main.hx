package shading;

import odd.Context;

import shading.Shading;

class Main
{
    static inline var WIDTH : Int = 320;
    static inline var HEIGHT : Int = 240;

    static function main() : Void
    {
        Context.init(WIDTH, HEIGHT);

        var shading = new Shading(WIDTH, HEIGHT);

        Context.run(shading.update, shading.draw);
    }
}