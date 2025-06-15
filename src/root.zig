//! API equivalent of c_api.h
//! Implemented in native Zig

const std = @import("std");
const testing = std.testing;

pub fn add(a: i32, b: i32) i32 {
    return a + b;
}

pub fn special_fn(a: u32) u32 {
    return 12 * a;
}

pub fn special_print(a: u32) !void {
    const stdout = std.io.getStdOut().writer();
    try stdout.print("Dis a number: {d}\n", .{a});
}

test "basic add functionality" {
    try testing.expect(add(3, 7) == 10);
}
