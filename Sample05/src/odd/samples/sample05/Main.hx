package odd.samples.sample05;

import odd.Context;

class Main
{
    static inline var WIDTH : Int = 640;
    static inline var HEIGHT : Int = 480;

    static function main() : Void
    {
        var sample = new Sample(WIDTH, HEIGHT);

        Context.init(WIDTH, HEIGHT);
        Context.run(sample.update, sample.draw);
    }
}