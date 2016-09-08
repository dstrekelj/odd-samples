package room;

import room.Room;

import odd.Context;

class Main
{
    static inline var WIDTH = 640;
    static inline var HEIGHT = 480;

    static function main() : Void
    {
        Context.init(WIDTH, HEIGHT);

        var room = new Room(WIDTH, HEIGHT);

        Context.run(room.update, room.draw);
    }
}