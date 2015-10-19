

b = Buffer.alloc(s,44100 * 2, 8);

{ PingPong.ar(b, {Impulse.ar(2.0.rand)}!8, 0.3, 0.8, 1)}.play


b = Buffer.alloc(s,44100 * 2, 8);


{ PingPong.ar(b, [Saw.ar(1), Impulse.ar(0.3), Impulse.ar(0.9), Impulse.ar(0.7), Impulse.ar(0.38), Impulse.ar(3.9), Impulse.ar(0.7), Impulse.ar(0.7)], 0.7, 0.8, 1)}.play


b = Buffer.alloc(s,44100 * 2, 8);

{ PingPong.ar(b, [Saw.ar(3), Impulse.ar(0.3), Impulse.ar(0.9), Impulse.ar(0.7), Impulse.ar(0.38), Impulse.ar(3.9), Impulse.ar(0.7), Impulse.ar(0.7)], 0.7, 0.8, 3)}.play // every 3rd channel





{WhiteNoise.ar(0.2)!8}.play

{{WhiteNoise.ar(0.2)}!8}.play

{Saw.ar(110, 0.3)!8}.play

{{Saw.ar(110, 0.3)}!8}.play // doesn't do much (compared to the noise)


{{Saw.ar(110+(1.0.rand), 0.3)}!8}.play

s.scope(8)

{[Saw.ar(33, 0.3), DelayN.ar(Saw.ar(33, 0.3), 0.011231)]}.play


b = Buffer.read(s, "/Users/thor/Library/Application Support/SuperCollider/sounds/holeMONO.aif");
b = Buffer.read(s, "/Users/thor/Library/Application Support/SuperCollider/sounds/banjo.wav");

{PlayBuf.ar(1,b)}.play
{PlayBuf.ar(1,b)!2}.play

{
	l = PlayBuf.ar(1, b, loop:1);
 	r = DelayN.ar(l, 1, MouseX.kr(1/44100, 0.05));
 	[l, r] // [l, 0, 0, r] // if you want speaker 1 and 4
}.play

s.scope(8)



{
	l = PlayBuf.ar(1,b, loop:1);
 	r = DelayN.ar(l, 1, MouseX.kr(1/44100, 0.1));
 	[l, r]
}.play



// SPEED OF SOUND


// the speed of sound in 20C normal humidity, sea level is 343.2 m/sec

343.2/1000 // 0.3432 m per ms, i.e., 34.32 cm per ms

1/343.2 // 0.0029137529137529 seconds per meter, i.e., ~3 ms per meter

2/343.2 // two meters are 0.0058275058275058  seconds, i.e. ~6 milliseconds
 
// out of interest there are 7350 samples in 6 ms at the 44.1 k sample rate  

44100/6

// so let's arrange speakers. and we need to take their location into account


// Test 
// Move speaker 0 two meters in front of speaker 1 pointing towards your direction

// play this
{ Impulse.ar(1)!2 }.play;

// then play the same, but with a delay on the front speaker of ~6 ms
{
	i = Impulse.ar(1);
	d = DelayN.ar(i, 0.5, 0.0058275058275058);
	[ d, i] // put speaker 0 two meters in front of speaker 1 and the sound should arrive at the same time
	// [ i, d] // try the opposite (or swap the physical speakers if you can be bothered : ) 
}.play;



b = Buffer.read(s, "/Users/thor/Library/Application Support/SuperCollider/sounds/holeMONO.aif");
b = Buffer.read(s, "/Users/thor/Library/Application Support/SuperCollider/sounds/banjo.wav");

{
	l = PlayBuf.ar(1,b, loop:1);
 	r = DelayN.ar(l, 1, 0.0058275058275058); // up to two meters deleay
 	[r*MouseX.kr(0, 1), l] // delay and amplitude control of speaker 0
// 	[l*MouseX.kr(0, 1), l] // no delay, but amplitude control of speaker 0
}.play


{
	l = PlayBuf.ar(1,b, loop:1);
 	r = DelayN.ar(l, 1, MouseX.kr(0, 0.0058275058275058)); // up to two meters deleay
 	[r, l]
}.play





// WAVELENGTH

1 Hz sound wave has the wave length of 343.2 m
10 Hz has the wave length of 34.32 m
100 Hz has the wave length of 3.432 m
1000 Hz has the wave length of 0.3432 cm

// explore the sine panning and saw panning in file 01-Mono and note how the saw can be much better located than the sine 