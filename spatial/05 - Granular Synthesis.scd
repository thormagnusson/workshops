


b = Buffer.read(s, "/Users/thor/Library/Application Support/SuperCollider/sounds/banjo.wav");

{GrainBuf.ar(8, Impulse.kr(24), 0.1, b, 1, MouseX.kr(0,1), 2, MouseY.kr(0, 2), -1)}.play


// random channel on every grain (using the impulse to select a channel)
{i = Impulse.kr(24);	GrainBuf.ar(8, i, 0.1, b, 1, MouseX.kr(0,1), 2, TRand.ar(0, 2, i) , -1)}.play

// random channel and location on every grain
{i = Impulse.kr(24);	GrainBuf.ar(8, i, 0.1, b, 1, TRand.ar(0, 1.0, i), 2, TRand.ar(0, 2, i) , -1)}.play

// a custom envelope
w = Env([0, 1, 0], [0.1, 0.1], [8, -8]);
z = Buffer.sendCollection(s, w.discretize, 1);

// a percussion envelope
w = Env.perc(0.0001, 0.2);
z = Buffer.sendCollection(s, w.discretize, 1);

{i = Impulse.kr(24); GrainBuf.ar(8, i, 0.2, b, 1, MouseX.kr(0,1), 2, TRand.ar(0, 2, i) , z)}.play


// we can of course create custom grains

b = Buffer.read(s, "/Users/thor/Library/Application Support/SuperCollider/sounds/banjo.wav");

SynthDef(\playsound, {arg out=0, buffer=0, rate=1, startPos =0;
	var signal;
	signal = PlayBuf.ar(1, buffer, rate, 1, startPos);
	//signal = signal * EnvGen.ar(Env.perc(0.001, 0.05)); // percussion envelope 0.05 = 50ms grain
	signal = signal * EnvGen.ar(Env.sine(0.05), doneAction:2); // sine envelope 0.05 = 50ms grain
	Out.ar(out, signal);
}).add


Synth(\playsound, [\out, 0, \buffer, b])

fork{
	inf.do({arg i;
		Synth(\playsound, [\out, i%8, \buffer, b]);
		0.1.wait;
	})
}


fork{
	inf.do({arg i;
		Synth(\playsound, [\out, 8.rand, \buffer, b, \startPos, b.numFrames.rand]);
		0.05.wait;
	})
}

