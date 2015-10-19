
// client 
// server (sc-synth)

{
	m = SinOsc.kr(1);
	SinOsc.ar(440*m);
}.play

// variable = a container of a value
a = 33
a+a

// function = a machine that outputs stuff
f = {}
f = {44+55}
f = {45+56}
f = {48+57}

f = {arg num1, num2, msg; 
	var sum;
	sum = num1 + num2;
	(msg.scramble + sum).postln;
}

f.value(33, 5555, "done calculating")


555.rand


{ WhiteNoise.ar(0.1) }.play

{SinOsc.ar(111, 0, 1)}.play


{LFNoise0.ar(1000)}.plot


{ LPF.ar(WhiteNoise.ar(0.1), LFNoise0.ar(1).range(100,1000)) }.scope


(
{ LPF.ar(WhiteNoise.ar(0.1), LFNoise0.ar(1).range(100,1000)) }.freqscope;

{ WhiteNoise.ar(0.1) }.play;

{SinOsc.ar(111, 0, 1)}.play;

)





{ Out.ar(7, Saw.ar(111, 0.1)) }.play;










{ Out.ar(0, Pan2.ar(Saw.ar(111, 0.1), 0) ) }.play;

///////////

{ 
	var signal, pan;
	signal = Saw.ar(111, 0.1);
	pan = Pan2.ar(signal, 0);
	Out.ar(0, pan);
}.play;



{ Out.ar(20, Saw.ar(110, 0.3)) }.play

{ Out.ar(0, In.ar(4)) }.play

physical busses                   virtual busses
[||||||||  |||||||||||||||||||||||||||||||||||||||||||||||||||]
[||||||||  |||||||||||||||||||||||||||||||||||||||||||||||||||]
[||||||||  |||||||||||||||||||||||||||||||||||||||||||||||||||]
[||||||||  |||||||||||||||||||||||||||||||||||||||||||||||||||]
[||||||||  |||||||||||||||||||||||||||||||||||||||||||||||||||]

{[Saw.ar(110, 0.3), 0,0,0,Saw.ar(210, 0.3), Saw.ar(410, 0.3)]}.play

a = [60,65,69,70,65]
a[1] 



a = 100.rand!800
// same UGen multiplied/expanded 8 times
{WhiteNoise.ar(0.1)!8}.play

a = {100.rand}!800 
// different UGen multiplied/expanded 8 times
{{WhiteNoise.ar(0.1)}!8}.play

s.scope(8)

(
var myfunction, myArray;
myArray = [111, 222, 333, 444];
myfunction = {arg freq;
 {SinOsc.ar(freq)+Saw.ar(freq*2)}.play
};
loop{
	myfunction.value(myArray[0]);
	myfunction.value(myArray[1]);
	myfunction.value(myArray[2]);
	myfunction.value(myArray[3]);
}
)

myArray[0] = -2; // bbc.weather.londonTemp()


var CnRworkshopleader;
CnRworkshopleader = "thor"

CnRworkshopleader = "john"



var anna;
anna = 55;

(a*a).postln;

a = 100;

(a*a).postln;



Env.triangle.plot

(

SynthDef(\cr1, { arg freq=440, cutoff=4, amp=0.1, out=0, dur=1;
	var signal, moog, env;
	signal = Saw.ar(freq, amp);
	moog = MoogFF.ar(signal, freq*cutoff, 3);
	env = EnvGen.ar(Env.perc(0.01, dur), doneAction:2);
	Out.ar(out, moog*env);
}).add; 

)



fork{
	inf.do({
		Synth(\cr1, [\freq, [330, 440, 550].choose, \out, 8.rand, \cutoff, rrand(2,8), \amp, 0.15]);
		0.1.wait;
	})
}


fork{
	inf.do({
		Synth(\cr1, [\freq, 200.rand, \out, 8.rand, \cutoff, rrand(2,8), \amp, 0.15]);
		0.1.wait;
	})
}

88.neg


m = [60, 60, 60, 62, 64, 64, 62, 64, 65, 67].midicps;
d = [1, 1, 0.5, 0.5, 1, 0.5, 0.5, 0.5, 1, 1, 1];

fork{
	inf.do({arg i;
		Synth(\cr1, [\freq, m[i], \out, 0, \cutoff, rrand(2,8), \amp, 0.5]);
		Synth(\kick, [\amp, 0.01]);
		d[i].wait;
	})
}



Synth(\cr1)




Pbind(
	\instrument, \cr1,
	\freq, Pfunc({2000.rand},inf),
	\dur, Pfunc({0.1.rand},inf),
	\out, Pseq([0, 3, 5, 7], inf)
).play





SynthDef(\cr3, { arg freq=440, gate=1, cutoff=4, amp=0.1, out=0;
	var signal, moog, env;
	signal = Saw.ar(freq, amp);
	moog = MoogFF.ar(signal, freq*cutoff, 3);
	env = EnvGen.ar(Env.asr(0.01, 1, 0.1), gate:gate, doneAction:2);
	Out.ar(out, moog*env);
}).add; 


Pbind(
	\instrument, \cr3,
	\freq, Pfunc({2000.rand},inf),
	\dur, Pfunc({0.01+ (0.01.rand)},inf),
	\legato, Pfunc({6.0.rand},inf),
	\out, Pfunc({8.rand},inf)
).play


2.rand
2.0.rand


