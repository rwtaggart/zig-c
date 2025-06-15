//! MAIN – Test C API example
//!
//! QUESTION:
//! How do I include c-library with cImport and zig build?
//! https://discord.com/channels/605571803288698900/1274576428452548731
//!
//! Note: C-Pointer [*c] can be cast into Optional Pointer ?*
//! Note: Null-terminated C-string literals must be translated into Zig string literals with std.mem.span()
//!
//! USAGE:
//! Run tests:
//! zig test src/main.zig -lc -I src
//!
//! Run main:
//! zig build-exe src/main.zig -lc -I src
//! zig build-exe src/main.zig src/c_api.c -lc -I src   # ALT WITH HEADER FILE

const std = @import("std");

const z_api = @import("./root.zig");

const c_api = @cImport({
    // @cInclude("c_api.h");
    @cInclude("c_api.c");
});

const a_api = @cImport({
    @cInclude("a_api.c");
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

    const c = c_api.special_fn(12);
    c_api.special_print(12);
    c_api.special_print(c);

    const z = z_api.special_fn(22);
    try z_api.special_print(22);
    try z_api.special_print(z);

    const a = a_api.a_special_fn(11);
    try stdout.print("a_lib number: {d}\n", .{a});
    // _ = a;
    // try stdout.writeAll("a_lib number: \n");

    try bw.flush(); // don't forget to flush!
}

test "simple test" {
    var list = std.ArrayList(i32).init(std.testing.allocator);
    defer list.deinit(); // try commenting this out and see if zig detects the memory leak!
    try list.append(42);
    try std.testing.expectEqual(@as(i32, 42), list.pop());
}

test "a test" {
    const res = a_api.a_special_fn(11);
    try std.testing.expectEqual(@as(u32, 132), res);
}

test "c test" {
    const res = c_api.special_fn(12);
    try std.testing.expectEqual(@as(u32, 144), res);
}

test "c print test" {
    c_api.special_print(12);
}

test "z test" {
    const res = z_api.special_fn(22);
    try std.testing.expectEqual(@as(u32, 264), res);
}

// test "z print test" {
//     // FIXME: stdout breaks "zig build test" runner
//     try z_api.special_print(22);
// }
