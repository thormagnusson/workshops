s.boot


[phasor~ 440]
 |
[lop~ 1200]
 |
[pan2]
 |
[dac~]

MIDIde
noteOn

plot
// this:
{Out.ar(1, RLPF.ar(Saw.ar(330), 1200, 0.3))}.play
// becomes this:
{
	a = Saw.ar(600.rand); // sound source
	b = RLPF.ar(a, 6200, 0.19); // filter
	c = EnvGen.ar(Env.perc(0.001, 1), doneAction:2); // envelope
	d = b * c;       // envelope applied to the signal
	p = Pan2.ar(d);  // signal panned into stereo
	Out.ar(0, p)     // sending to the sound card
}.play

// which becomes this (a SynthDef):
SynthDef(\aalto, {arg tajus=440, cutoff=4;
	var signal, filter;
	signal = Saw.ar(tajus); // sound source
	filter = RLPF.ar(signal, cutoff*tajus, 0.19); // filter
	c = EnvGen.ar(Env.perc(0.001, 1), doneAction:2); // envelope
	d = filter * c;       // envelope applied to the signal
	p = Pan2.ar(d);  // signal panned into stereo
	Out.ar(0, p)     // sending to the sound card
}).store


Synth(\aalto, [\freq, rrand(300, 1000)])


a = [60, 63, 67, 72];
{

inf.do{
		if(10.rand > 8, {a = [60, 63, 67, 72]+10.rand; "CHANGE of KEY".postln;} );

		Synth(\aalto, [\tajus, a.choose.midicps, \cutoff, 6]);
		[0.25, 0.125].choose.wait;

	}
}.fork




t = TuningTheory.new
t.createGUI

{
10.do{
		Synth(\aalto, [\freq, rrand(140, 1180), \cutoff, rrand(2, 20)]);
		[0.25, 0.125].choose.wait;

	}
}.fork