

SynthDef(\sinegrain, {arg out=0, freq=440, amp=0.5, dur=1;
	var signal;
	signal = SinOsc.ar(freq, 0, amp);
	signal = signal * EnvGen.ar(Env.perc(0.01, dur), doneAction:2);
	Out.ar(out, signal);
}).add

Synth(\sinegrain, [\freq, 888, \amp, 0.1, \out, 4])

SynthDef(\sawgrain, {arg out=0, freq=440, amp=0.5, dur=1, cutoff=2, gain=2.5;
	var signal;
	signal = MoogFF.ar(Saw.ar(freq, amp), freq*cutoff, gain);
	signal = signal * EnvGen.ar(Env.perc(0.01, dur), doneAction:2);
	Out.ar(out, signal);
}).add


Synth(\sawgrain, [\freq, 118, \amp, 0.1, \out, 4, \cutoff, 12, \gain, 3.5])


Pbind(
	\instrument, \sinegrain,
	\freq, Pseq( (60+ (Scale.major.degrees ++ 12)).midicps, inf),
	\out, Pseq([0, 1, 2, 3, 4, 5, 6, 7], inf),
	\dur, 0.061
).play


Pbind(
	\instrument, \sawgrain,
	\freq, Pseq( (60+ (Scale.major.degrees ++ 12)).midicps, inf),
	\out, Pseq([0, 1, 2, 3, 4, 5, 6, 7], inf),
	\cutoff, 6,
	\dur, 0.061
).play;


Pbind(
	\instrument, \sawgrain,
	\freq, Pseq( (60+ (Scale.major.degrees ++ 12)).midicps, inf),
	\out, Pseq([0, 1, 2, 3, 4, 5, 6, 7], inf),
	\cutoff, Pseq([1, 2, 3, 4, 5, 6, 7, 8].dup(8).flatten.sort, 8),
	\dur, 0.2
).play;
	

// random

Pbind(
	\instrument, \sawgrain,
	\freq, Prand( (60+ (Scale.minor.degrees ++ 12)).midicps, inf),
	\out, Pseq([0, 1, 2, 3, 4, 5, 6, 7], inf),
	\dur, Pexprand(0.1, 0.5, inf)
).play;
	


// irregular outs

Pbind(
	\instrument, \sawgrain,
	\freq, Pseq( (60+ (Scale.major.degrees ++ 12)).midicps, inf),
	\out, [1, 3, 4, 5, 7],
	\cutoff, 10,
	\dur, 0.5
).play;
		

s.scope(8)

// random out on 4 channels

Pbind(
	\instrument, \sawgrain,
	\freq, Pseq( (60+ (Scale.major.degrees ++ 12)).midicps, inf),
	\out, Pfunc({{8.rand}!4}), // out on random 4 channels
	\cutoff, 10,
	\dur, 0.5
).play;
		
		

// random out on random 1 to 8 channels

Pbind(
	\instrument, \sawgrain,
	\freq, Pseq( (60+ (Scale.major.degrees ++ 12)).midicps, inf),
	\out, Pfunc({{8.rand}!8.rand}), // out on random 4 channels
	\cutoff, 10,
	\dur, 0.5
).play;
		
		

// Sum multiple channels into one:

{
	a = SinOsc.ar(110, 0, 0.1);
	b = SinOsc.ar(220, 0, 0.1);
	c = SinOsc.ar(330, 0, 0.1);
	d = SinOsc.ar(440, 0, 0.1);
	e = SinOsc.ar(550, 0, 0.1);
	Mix.ar([a, b, c, d, e]);
}.play
		
// or simply

{ ( {|i| SinOsc.ar((i+1)*110, 0, 0.1)} ! 5 ).sum }.play


// you can select one source from many channels


{ a = ( {|i| SinOsc.ar((i+1)*110, 0, 0.1)} ! 5 ); // note, no sum
	SelectX.ar(2, a);
}.play



{ a = ( {|i| SinOsc.ar((i+1)*110, 0, 0.1)} ! 5 ); // note, no sum
	SelectX.ar(MouseX.kr(0, 4), a);
}.play




// SelectXFocus allows you to mix channels into one
// width argument supported

(
{
Ê Ê var a;
Ê Ê a = [
Ê Ê Ê Ê Ê Ê Saw.ar(LFSaw.kr(3 * [1, 1.01], 0, 100, 230)),
Ê Ê Ê Ê Ê Ê SinOsc.ar,
Ê Ê Ê Ê Ê Ê Pulse.ar(LFPulse.kr(3 * [1, 1.02], 0, 0.4, 100, 230)),
Ê Ê Ê Ê Ê Ê SinOsc.ar(SinOsc.kr(4 * [1, 1.03], 0, 200, 300))
Ê Ê Ê Ê ];

Ê Ê SelectXFocus.ar(MouseX.kr(0, 1) * a.size, a, MouseY.kr(0, a.size)) * 0.2
}.play;
)


