package;

import odd.Framebuffer;
import odd.Context;

class Main
{
    static function main()
    {
        Context.init(800, 600);
        
        var sandbox = new Sandbox();
        
        Context.run(sandbox.update, sandbox.draw);
    }
}