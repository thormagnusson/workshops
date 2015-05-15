
s.boot

p = Platform.resourceDir +/+ "sounds/a11wlk01.wav";
b = Buffer.read(s, p);
b.play;

b.sampleRate

{
	p = PlayBuf.ar(1, b, 1, loop:1);
	AllpassN.ar(p, 2, 0.2, 4);
}.play


{
	p = PlayBuf.ar(1, b, SinOsc.ar(MouseY.kr(0.1, 20)).range(0, MouseX.kr(0.1, 10)), loop:1);
	AllpassN.ar(p, 2, 0.2, 4);
}.play

SynthDef(\sampleplayer, {arg buf, rate = 1;
	p = PlayBuf.ar(2, buf, rate, loop:0);
	Out.ar(0, Pan2.ar(p, 0));
}).add

Tuning.just.ratios
b = Buffer.read(s, "/Users/thm21/Desktop/Piano.ff.C3.aiff");
Synth(\sampleplayer, [\buf, b, \rate, 1.5])


fork{
Tuning.et12.ratios.do({arg ratio;
Synth(\sampleplayer, [\buf, b, \rate, ratio]);
	1.wait;
})
}


Tuning.just.ratios