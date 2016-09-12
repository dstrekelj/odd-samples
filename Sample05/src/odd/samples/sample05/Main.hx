package odd.samples.sample05;

import odd.Context;

class Main
{
    #if odd_target_android
    static inline var WIDTH : Int = 160;
    static inline var HEIGHT : Int = 120;
    #else
    static inline var WIDTH : Int = 640;
    static inline var HEIGHT : Int = 480;
    #end

    static function main() : Void
    {
        var sample = new Sample(WIDTH, HEIGHT);

        Context.init(WIDTH, HEIGHT);
        Context.run(sample.update, sample.draw);
    }
}