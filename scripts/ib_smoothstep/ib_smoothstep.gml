/// @description  ib_smoothstep(t)
/// @param t
// This is used internally by Interactive Books to smooth out movement. It takes a value from 0 to 1 and changes it to fit a smooth function, then returns that value.
// You can google smoothstep if you're interested.
//
// t: The value to apply smoothstep to.

return argument0 * argument0 * (3 - 2 * argument0);
