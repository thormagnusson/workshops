


// The Pan2 Ugen 
// Two channel equal powered pan (perceptually smooth)

SynthDef(\pangrain, {arg out=0, freq=440, amp=0.5, dur=1, cutoff=2, gain=2.5, pan=0;
	var signal;
	signal = MoogFF.ar(Saw.ar(freq, amp), freq*cutoff, gain);
	signal = signal * EnvGen.ar(Env.perc(0.01, dur), doneAction:2);
	Out.ar(out, Pan2.ar(signal, pan));
}).add


Synth(\pangrain, [\freq, 118, \amp, 0.1, \out, 4, \cutoff, 12, \gain, 3.5])


Pbind(
	\instrument, \pangrain,
	\freq, Prand( (60+ (Scale.major.degrees ++ 12)).midicps, inf),
	\out, 0,
	\pan, Pseq([-1, 1], inf),
	\dur, 1
).play



// The LinPan2 Ugen 
// Two channel linear pan (audible dip of -3dB in amplitude in the centre)

SynthDef(\pansaw, {arg out=0, freq=110, amp=0.5, dur=1, cutoff=2, gain=2.5, pan=0;
	var signal;
	signal = MoogFF.ar(Saw.ar(freq, amp), freq*MouseY.kr(10, 1), gain);
	Out.ar(out, LinPan2.ar(signal, MouseX.kr(-1, 1)));
}).add

Synth(\pansaw)
s.scope


SynthDef(\linpansaw, {arg out=0, freq=110, amp=0.5, dur=1, cutoff=2, gain=2.5, pan=0;
	var signal;
	signal = MoogFF.ar(Saw.ar(freq, amp), freq*MouseY.kr(10, 1), gain);
	Out.ar(out, LinPan2.ar(signal, SinOsc.ar(1).range(-1, 1)));
}).add

Synth(\linpansaw)



b = Buffer.read(s, "/Users/thor/Library/Application Support/SuperCollider/sounds/banjo.wav");
b = Buffer.read(s, "/Users/thor/Library/Application Support/SuperCollider/sounds/holeMONO.aif");

SynthDef(\playsound, {arg buffer=0, rate=1;
	var signal;
	signal = PlayBuf.ar(1, buffer, rate, loop:1);
	signal = Pan2.ar(signal, MouseX.kr(-1, 1));
	Out.ar(0, signal);
}).add

a = Synth(\playsound, [\buffer, b])
a.set(\rate, 0.5)





// Balance2
// Stereo signal balancer (panner)

{Balance2.ar(LFSaw.ar(144), LFSaw.ar(244), FSinOsc.kr(0.5), 0.1) }.play;

// good for stereo sample control

b = Buffer.read(s, "/Users/thor/Library/Application Support/SuperCollider/sounds/hola02.aif");

SynthDef(\playsound, {arg buffer=0, rate=1;
	var signal;
	signal = PlayBuf.ar(2, buffer, rate, loop:1);
	signal = Balance2.ar(signal[0], signal[1], MouseX.kr(-1, 1));
	Out.ar(0, signal);
}).add

a = Synth(\playsound, [\buffer, b])
a.set(\rate, 0.5)




// Rotation2
// rotation of a sound field


// Rotation of stereo sound:
(
{
Ê Ê // rotation via LFO
Ê Ê var x, y;
Ê Ê x = PinkNoise.ar(0.4);
Ê Ê y = LFTri.ar(800) * LFPulse.kr(3,0,0.3,0.2);
Ê Ê #x, y = Rotate2.ar(x, y, LFSaw.kr(0.1));
Ê Ê [x,y]
}.play;
)

(
{
Ê Ê // rotation via mouse
Ê Ê var x, y;
Ê Ê x = Mix.fill(4, { LFSaw.ar(200 + 2.0.rand2, 0, 0.1) });
Ê Ê y = SinOsc.ar(900) * LFPulse.kr(3,0,0.3,0.2);
Ê Ê #x, y = Rotate2.ar(x, y, MouseX.kr(0,2));
Ê Ê [x,y]
}.play;
)

(
{
Ê Ê // rotation via mouse
Ê Ê var x, y;
Ê Ê x = BrownNoise.ar(0.1);
Ê Ê y = Saw.ar(90, 0.1);
Ê Ê #x, y = Rotate2.ar(x, y, MouseX.kr(0,1));
Ê Ê [x,y]
}.scope(8);
)


// Check AmbIEM quark for Binaural panning

e = [90,40,40,40,40,0,0,0,0,0,0,0,-40,-40,-40,-40];
a = [0,45,135,225,315,25,75,130,180,230,285,335,0,90,180,270];

// adjust your path to the Kemar data
// this is relative to the SC3 folder
Kemar.path = "KemarHRTF/full"
Kemar.initBuffers(a, e);

{
	var sound;
	sound = EnvGen.kr(Env.adsr, Impulse.kr(3)) * PinkNoise.ar(0.8);
	Kemar.ar(
		DecodeAmbi2O.ar(
			PanAmbi2O.ar(sound, 
				MouseX.kr(-pi, pi), 
				MouseY.kr(-pi, pi)),
			'1_4_7_4'	
		)
	);
}.play;




SynthDef(\headinspace, {arg asi=0, ele=0, amp=0.1;
	var sound, pan;
	sound = EnvGen.kr(Env.adsr, Impulse.kr(3)) * PinkNoise.ar(0.8);
	sound = sound * amp;
	pan = Kemar.ar(
		DecodeAmbi2O.ar(
			PanAmbi2O.ar(sound, 
				asi, 
				ele),
			'1_4_7_4'	
		)
	);
	Out.ar(0, pan);
}).add;

Synth(\headinspace)





(
var agentloc, meloc, agentsize, agentMoving;
agentloc = Point(200, 200);
meloc = Point(400, 300);
agentsize = 20;
agentMoving = false;

// The speaker positions [eleveation],[azimuth]
e = [90,40,40,40,40,0,0,0,0,0,0,0,-40,-40,-40,-40];
a = [0,45,135,225,315,25,75,130,180,230,285,335,0,90,180,270];


// adjust your path to the Kemar data
// this is relative to the SC3 folder
Kemar.path = "KemarHRTF/full";
Kemar.initBuffers(a, e);

t = Synth(\headinspace);

w = SCWindow.new("hey", Rect(250, 200, 800, 600)).front;
a = UserView.new(w, Rect(10, 10, 780, 580))
		.drawFunc_({arg view;
	     	Color.blue.set;
	    		Pen.fillOval(Rect(agentloc.x, agentloc.y, agentsize, agentsize));
	     	Color.black.set;
	     	Pen.strokeOval(Rect(agentloc.x, agentloc.y, agentsize, agentsize));
	     	Color.red.set;
	    		Pen.fillOval(Rect(meloc.x, meloc.y, 20, 20));
	     	Color.black.set;
	     	Pen.strokeOval(Rect(meloc.x, meloc.y, 20, 20));
		})
		.mouseDownAction_({arg view, x, y;
			if(Rect(agentloc.x, agentloc.y, agentsize, agentsize).intersects(Rect(x,y, 1, 1)), {
				agentMoving = true;
			});
		})
		.mouseUpAction_({arg view, x, y;
			if(Rect(agentloc.x, agentloc.y, agentsize, agentsize).intersects(Rect(x,y, 1, 1)), {
				agentMoving = false;
			});
		})
		.mouseMoveAction_({arg view, x, y;
			if(agentMoving, {
				agentloc = Point(x-(agentsize/2), y-(agentsize/2));
			});
			d = meloc.dist(agentloc);
			"Distance is : ".post; d.postln;
			o = atan2(agentloc.y - meloc.y , agentloc.x - meloc.x);
			o = o + pi;
			"Degree Angle is : ".post; o.postln;
			t.set(\asi, o+(0.5*pi));
			t.set(\amp, (1-(d/450)).max(0).linexp(0, 1, 0.000000001, 2).min(1.5));
			view.refresh;	
		});	
)


