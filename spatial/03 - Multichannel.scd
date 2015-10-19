

s.scope(8)
// The PanAz Ugen ("Az" for the Azimuth axis - horizontal)

{PanAz.ar(8, BrownNoise.ar(0.1)+Saw.ar(111, 0.1), MouseX.kr(0, 2).poll, 0.5, MouseY.kr(0.9, 4), 0)}.play


// mouse X controls the direction and mouse Y the spread

{PanAz.ar(8, Saw.ar(111, 0.1), MouseX.kr(0, 2), 0.5, MouseY.kr(0.9, 4), 0)}.play

// random movement and random spread

{PanAz.ar(8, Saw.ar(55, 0.1), LFNoise2.kr(1).range(0, 2), 0.5, LFNoise2.kr(1).range(0.9, 4), 0)}.play

// a bit more playful

{PanAz.ar(8, MoogFF.ar(Saw.ar(55, 0.3), LFNoise2.kr(1).range(110, 11000), LFNoise2.kr(2).range(0.1, 3.9)), LFNoise2.kr(1).range(0, 2), 0.5, LFNoise2.kr(1).range(0.9, 4), 0)}.play

// bumble bee ?

{PanAz.ar(8, MoogFF.ar(Saw.ar([450,452], 0.3).sum+PinkNoise.ar(0.12), LFNoise2.kr(2).range(3110, 4000), 1), LFNoise2.kr(0.7).range(0, 2), 0.5, LFNoise2.kr(1).range(0.9, 2), 0)}.play

// mosquito ?

{PanAz.ar(8, MoogFF.ar(Saw.ar([6000,6002], 0.03).sum, LFNoise2.kr(2).range(1110, 11000), LFNoise2.kr(2).range(2, 3)), LFNoise2.kr(1).range(0, 2), 0.5, LFNoise2.kr(1).range(0.9, 4), 0)}.play

s.scope(8)




b = Buffer.read(s, "/Users/thor/Library/Application Support/SuperCollider/sounds/banjo.wav");
b = Buffer.read(s, "/Users/thor/Library/Application Support/SuperCollider/sounds/holeMONO.aif");

SynthDef(\playAzsound, {arg buffer=0, rate=1;
	var signal;
	signal = PlayBuf.ar(1, buffer, rate, loop:1);
	signal = PanAz.ar(8, signal, MouseX.kr(0, 2), 1, MouseY.kr(0.1, 4), 0);
	Out.ar(0, signal);
}).add

a = Synth(\playAzsound, [\buffer, b])
a.set(\rate, 0.5)

s.scope(8)




SynthDef(\panAzgrain, {arg out=0, freq=440, amp=0.5, dur=1, cutoff=4, gain=2.5, pan=0, width=2;
	var signal;
	signal = MoogFF.ar(Saw.ar(freq, amp), freq*cutoff, gain);
	signal = signal * EnvGen.ar(Env.perc(0.01, dur), doneAction:2);
	Out.ar(out, PanAz.ar(8, signal, pan, 1, width, 0));
}).add


Synth(\pangrain, [\freq, 118, \amp, 1, \out, 0, \cutoff, 12, \gain, 3.5, \pan, 0, \width, 1])


// compare a and b and notise how sounds with more harmonics (high frequency) are better localisable

// a)
Pbind(
	\instrument, \panAzgrain,
	\freq, 111, // Prand( (60+ (Scale.major.degrees ++ 12)).midicps, inf),
	\out, 0,
	\pan, Pseq([1, 2, 3, 4, 5, 6, 7, 8]/4, inf),
	\cutoff, 2,
	\dur, 0.25
).play


// b)
Pbind(
	\instrument, \panAzgrain,
	\freq, 111, // Prand( (60+ (Scale.major.degrees ++ 12)).midicps, inf),
	\out, 0,
	\amp, 0.25,
	\pan, Pseq([1, 2, 3, 4, 5, 6, 7, 8]/4, inf),
	\cutoff, 12,
	\dur, 0.025
).play


// random frequency

Pbind(
	\instrument, \panAzgrain,
	\amp, 1,
	\freq, Prand( (48+ (Scale.minorPentatonic.degrees ++ 12)).midicps, inf),
	\out, 0,
	\pan, Pseq([1, 2, 3, 4, 5, 6, 7, 8]/4, inf),
	\width, 1,
	\cutoff, 12,
	\dur, 0.1
).play



// random frequency and random speaker

Pbind(
	\instrument, \panAzgrain,
	\amp, 1,
	\freq, Prand( (48+ (Scale.minorPentatonic.degrees ++ 12)).midicps, inf),
	\out, 0,
	\pan, Prand([1, 2, 3, 4, 5, 6, 7, 8]/4, inf),
	\width, 1,
	\cutoff, 12,
	\dur, 0.1
).play


s.scope(8)

{PanAz.ar(8, BrownNoise.ar(0.1)+Saw.ar(111, 0.1), MouseX.kr(0, 2).poll, 0.5, MouseY.kr(0.9, 4), 0)}.play




// VBAP - Vector Based Amplitude Panning

Server.default = s = Server.internal;

// 2D VBAP - An 8 channel speaker circle 

a = VBAPSpeakerArray.new(2, [0, 45, 90, 135, 180, -135, -90, -45]); // speaker degrees

b = a.loadToBuffer;

{ VBAP.ar(8, PinkNoise.ar(0.2), b.bufnum, MouseX.kr(0, 360), 0, MouseY.kr(0, 100)) }.scope(8);




// Ambisonics

{
	// PanB returns a 4 channel array, inserted into the w, x, y and z variables 
	// try to evaluate:  #a, b = [11 , 22];
Ê Ê #w, x, y, z = PanB.ar(Saw.ar(55, 0.3), MouseX.kr(-pi, pi), MouseY.kr(-0.5*pi, 0.5pi), 0.3);
Ê Ê DecodeB2.ar(8, w, x, y, 0.5);
}.play;

s.scope(8)


