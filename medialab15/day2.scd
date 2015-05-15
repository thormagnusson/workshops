
// subtractive synthesis
{
	a = WhiteNoise.ar;
	BPF.ar( a*1.7, MouseX.kr(100, 3000), MouseY.kr(0.001, 0.999))
	+
	BPF.ar( a, MouseX.kr(100, 3000)*2, MouseY.kr(0.001, 0.999))
}.scope(1)


FreqScope.new
// additive synthesis

{
	SinOsc.ar(440, 0, 0.3)
	+
		SinOsc.ar(440*2, 0, 0.3)
	+
	SinOsc.ar(440*3, 0, 0.3)
}.play
















// xylophone

{
    (WhiteNoise.ar* EnvGen.ar(Env.perc(0.00000001, 0.08)))
	+
	(SinOsc.ar(11850, pi, 0.08)* EnvGen.ar(Env.perc(0.00000001, 0.35)))
	+
	(SinOsc.ar(11000, pi, 0.08)* EnvGen.ar(Env.perc(0.00000001, 0.25)))
	+
	(SinOsc.ar(7200, pi, 0.25)* EnvGen.ar(Env.perc(0.00000001, 1.5)))
	+
	(SinOsc.ar(4900, pi, 0.2)* EnvGen.ar(Env.perc(0.0000001, 0.6)))
	+
	(SinOsc.ar(3000, pi, 0.1)* EnvGen.ar(Env.perc(0.0000001, 1.3)))
	+
	(SinOsc.ar(2600, pi, 0.2)* EnvGen.ar(Env.perc(0.0000001, 0.8)))
	+
	(SinOsc.ar(1000, pi, 0.3) * EnvGen.ar(Env.perc(0.00000001, 4), doneAction:2))
}.play

// turn this into a SynthDef

SynthDef(\xylo,
	{arg freq, amp=1, tremolo=0;
		var signal;
		signal =
    (WhiteNoise.ar* EnvGen.ar(Env.perc(0.00000001, 0.01)))
		+
	(SinOsc.ar(freq*11.85, pi, 0.08)* EnvGen.ar(Env.perc(0.00000001, 0.35)))
	+
	(SinOsc.ar(freq*11, pi, 0.08)* EnvGen.ar(Env.perc(0.00000001, 0.25)))
	+
	(SinOsc.ar(freq*7.2, pi, 0.25)* EnvGen.ar(Env.perc(0.00000001, 1.5)))
	+
	(SinOsc.ar(freq*4.9, pi, 0.2)* EnvGen.ar(Env.perc(0.0000001, 0.6)))
	+
	(SinOsc.ar(freq*3, pi, 0.1)* EnvGen.ar(Env.perc(0.0000001, 1.3)))
	+
	(SinOsc.ar(freq*2.6, pi, 0.2)* EnvGen.ar(Env.perc(0.0000001, 0.8)))
	+
	(SinOsc.ar(freq, pi, 0.3) * EnvGen.ar(Env.perc(0.00000001, 4), doneAction:2));
		Out.ar(0, Pan2.ar(signal*amp*SinOsc.ar(tremolo, add:1, mul:0.5), 0));
}).store;

fork{
120.do{
		Synth(\xylo, [\freq, (72+Scale.major.degrees.choose).midicps]);
		0.1.wait;
	}
}

Synth(\xylo, [\freq, (72+Scale.major.degrees.choose).midicps]);
Synth(\xylo, [\freq, 72.midicps, \amp, 0.2]);

Synth(\xylo, [\freq, (rrand(60,72)).midicps, \amp, 1, \tremolo, 8]);


(
SynthDef(\xylorand,
	{arg freq, amp=1, tremolo=0;
		var signal;
		signal =
		(Decay.ar(WhiteNoise.ar* EnvGen.ar(Env.perc(0.00000001, 0.0000001)), 0.5))
		+
		(SinOsc.ar(freq*(11.85+rrand(0.1,2.6)), pi, 0.08)* EnvGen.ar(Env.perc(0.00000001, 0.35)))
	+
		(SinOsc.ar(freq*(11+rrand(0.1,2.6)), pi, 0.08)* EnvGen.ar(Env.perc(0.00000001, 0.25)))
	+
		(SinOsc.ar(freq*(7.2+rrand(0.1,2.6)), pi, 0.25)* EnvGen.ar(Env.perc(0.00000001, 1.5)))
	+
		(SinOsc.ar(freq*(4.9+rrand(0.1,2.6)), pi, 0.2)* EnvGen.ar(Env.perc(0.0000001, 0.6)))
	+
		(SinOsc.ar(freq*(3+rrand(0.1,2.6)), pi, 0.1)* EnvGen.ar(Env.perc(0.0000001, 1.3)))
	+
		(SinOsc.ar(freq*(2.6+rrand(0.1,2.6)), pi, 0.2)* EnvGen.ar(Env.perc(0.0000001, 0.8)))
	+
	(SinOsc.ar(freq, pi, 0.3) * EnvGen.ar(Env.perc(0.00000001, 4), doneAction:2));
		Out.ar(0, Pan2.ar(signal*amp*SinOsc.ar(tremolo, add:1, mul:0.5), 0));
}).store;

fork{
120.do{
		Synth(\xylorand, [\freq, (60+Scale.major.degrees.choose).midicps, \tremolo, rrand(8, 20)]);
		3.wait;
	}
}
)




// granular synthesis
(
SynthDef(\xylorandgrain,
	{arg freq, amp=1, tremolo=0;
		var signal;
		signal =
		(Decay.ar(WhiteNoise.ar* EnvGen.ar(Env.perc(0.00000001, 0.0000001)), 0.05))
		+
		(SinOsc.ar(freq*(11.85+rrand(0.1,2.6)), pi, 0.08)* EnvGen.ar(Env.perc(0.00000001, 0.035)))
	+
		(SinOsc.ar(freq*(11+rrand(0.1,2.6)), pi, 0.08)* EnvGen.ar(Env.perc(0.00000001, 0.025)))
	+
		(SinOsc.ar(freq*(7.2+rrand(0.1,2.6)), pi, 0.25)* EnvGen.ar(Env.perc(0.00000001, 0.5)))
	+
		(SinOsc.ar(freq*(4.9+rrand(0.1,2.6)), pi, 0.2)* EnvGen.ar(Env.perc(0.0000001, 0.06)))
	+
		(SinOsc.ar(freq*(3+rrand(0.1,2.6)), pi, 0.1)* EnvGen.ar(Env.perc(0.0000001, 0.03)))
	+
		(SinOsc.ar(freq*(2.6+rrand(0.1,2.6)), pi, 0.2)* EnvGen.ar(Env.perc(0.0000001, 0.08)))
	+
	(SinOsc.ar(freq, pi, 0.3) * EnvGen.ar(Env.perc(0.00000001, 0.1), doneAction:2));
		Out.ar(0, Pan2.ar(signal*amp*SinOsc.ar(tremolo, add:1, mul:0.5), 0));
}).store;

fork{
120.do{
		Synth(\xylorandgrain, [\freq, (60+(3.rand)).midicps, \tremolo, rrand(8, 20), \amp, 0.1]);
		0.04.wait;
	}
}
)



Pbind(
	\instrument, \xylo,
	\freq, Pseq([Pseq([60, 64, 67, 72].midicps, 1), Pshuf([60, 64, 67, 72].midicps*4, 2)],inf),
	\amp, Pseq([0.8, 1, 0.4, 0.7], inf),
	\dur, 0.4
).play















