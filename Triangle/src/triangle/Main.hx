package triangle;

import triangle.Triangle;

import odd.Context;

class Main
{
    static inline var WIDTH : Int = 320;
    static inline var HEIGHT : Int = 240;

    static function main() : Void
    {
        Context.init(WIDTH, HEIGHT);

        var triangle = new Triangle(WIDTH, HEIGHT);

        Context.run(triangle.update, triangle.draw);
    }
}