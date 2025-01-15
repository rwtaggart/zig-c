//!
//! zig test
//! QUESTION:
//! How do I include c-library with cImport and zig build?
//! https://discord.com/channels/605571803288698900/1274576428452548731
//!
//! BUILD
//! zig build-exe -I /opt/homebrew/Cellar/sqlite/3.46.0/include -L /opt/homebrew/Cellar/sqlite/3.46.0/lib -lsqlite3 ./src/note.zig
//!
//! Note: C-Pointer [*c] can be cast into Optional Pointer ?*
//! Note: Null-terminated C-string literals must be translated into Zig string literals with std.mem.span()
//!
//! USAGE:
//!   zig test -I /opt/homebrew/Cellar/sqlite/3.46.0/include -L /opt/homebrew/Cellar/sqlite/3.46.0/lib -lsqlite3 ./src/sqlite_db.zig
//!
//! zig test src/main.zig -lc -I src
//! zig build-exe src/main.zig -lc -I src

const std = @import("std");

const c_api = @cImport({
    @cInclude("./c_api.c");
});

pub fn main() !void {
    // Prints to stderr (it's a shortcut based on `std.io.getStdErr()`)
    std.debug.print("All your {s} are belong to us.\n", .{"codebase"});

    // stdout is for the actual output of your application, for example if you
    // are implementing gzip, then only the compressed bytes should be sent to
    // stdout, not any debugging messages.
    const stdout_file = std.io.getStdOut().writer();
    var bw = std.io.bufferedWriter(stdout_file);
    const stdout = bw.writer();

    try stdout.print("Run `zig build test` to run the tests.\n", .{});

    try bw.flush(); // don't forget to flush!
}

test "simple test" {
    var list = std.ArrayList(i32).init(std.testing.allocator);
    defer list.deinit(); // try commenting this out and see if zig detects the memory leak!
    try list.append(42);
    try std.testing.expectEqual(@as(i32, 42), list.pop());
}

test "c test" {
    const res = c_api.special_fn(12);
    try std.testing.expectEqual(@as(u32, 144), res);
}
