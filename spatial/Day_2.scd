
[sine, sine, sine, sine, sine]

{ a = ( {|i| SinOsc.ar((i+1)*110, 0, 0.1)} ! 5 );
	SelectX.ar(MouseX.kr(0, 4), a);
}.play


{10.rand}!20 

Array.fill(20, { 10.rand });


{10.rand}!20 

Array.fill(20, { 10.rand });

Array.fill(20, {arg i; if(i.isPrime, {i*i}, {i}) });

i = 0
a = []
i = i + 1;
a = a.add("hello")

// c/Java/javascript syntax (not SC)
for(int i = 0; i<20; i++){
	10.rand
}

// supercollider equivalent of the above
20.do({arg i; i.postln;})



// KEY CONCEPTS OF PROGRAMMING SUPERCOLLIDER (enough to make amazing stuff)
// variables - a container of a value
// functions - a machine that does stuff and outputs it
// arrays - a collection of values 
// synthdefs and synths
// multichannel UGens

// variables

a = 23
a = a+1 // birthday

(
a = 80; // a variable
("my age is"+a).postln;
("ten Years ago I was" +(a-10)+ "years old").postln;
("next year I'll be" + (a+1)).postln;
)


// the above put into a function

n = {
	a = 30; // here age is hard coded (that's not good)
	("my age is"+a).postln;
	("ten Years ago I was" +(a-10)+ "years old").postln;
	("next year I'll be" + (a+1)).postln;
}

n.value

// so we will open up an arguement into the function
n = { arg age; // open up an argument into the function
	("my age is"+age).postln;
	("ten Years ago I was" +(age-10)+ "years old").postln;
	("next year I'll be" + (age+1)).postln;
}

n.value(11) // give the argument of the function a value
n.value(44) // the value is 44
n.value(24) // the value is 24



Synth(\whatever, [\freq, 333])





{arg freq;

SinOsc.ar(freq, 0, 0.1)
....
}



// our serialist piece


w = [];
100.do({
		if(w.size < 12, {
		r= 12.rand;
		if(w.includes(r) == false, {
			w = w.add(r)
		})
	})
});

fork{
	w.do({arg note; 
		Synth(\sawgrain, [\freq, (note+60).midicps]);
		0.25.wait;
 });
}



// randomness - no true randomness in computers
// but check www.random.org

thisThread.randSeed = 567;
Array.fill(20, { 10.rand });





(
w = Window.new("Sound Player");

b = Buffer.read(s, "/Users/thor/Library/Application Support/SuperCollider/sounds/banjo.wav");

SynthDef(\playsound, {arg buffer=0, rate=1;
	var signal;
	signal = PlayBuf.ar(1, buffer, rate, loop:1);
	signal = Pan2.ar(signal, MouseX.kr(-1, 1));
	Out.ar(0, signal);
}).add;

Button(w, Rect(20, 20, 340, 30))
Ê Ê Ê Ê .states_([
Ê Ê Ê Ê Ê Ê ["play", Color.black, Color.red],
Ê Ê Ê Ê Ê Ê ["stop", Color.black, Color.red]
Ê Ê Ê Ê ])
Ê Ê Ê Ê .action_({ arg butt;
				if(butt.value == 1, {
					a = Synth(\playsound, [\buffer, b])
				}, {
					a.free;
				})Ê Ê Ê Ê 
			});
w.front;
)




{PanAz.ar(8, 
	BrownNoise.ar(0.1), 
	LFSaw.ar(LFNoise2.ar(1).range(0.1, 5)).range(0,2), 
	0.5, 
	LFNoise2.ar(1).range(2.5, 6), 
	0)}.play





{PanAz.ar(8, 
	Saw.ar(255, 0.1), 
	TRand.ar(0,2, Impulse.ar(MouseX.kr(0.1, 100))), 
	0.5, 
	1, 
	0)}.play


{PanAz.ar(8, 
	Saw.ar(255, 0.1), 
	LFNoise2.ar(1).range(0,2), 
	0.5, 
	1, 
	0)
}.play




// Gary Kendall explaining surround sound:
http://www.youtube.com/watch?v=J9Khgf2n_9k



/// Radio MACBA
// Lullcec - http://lullcec.org/en



{
	i = Impulse.ar(1);
	d = DelayN.ar(i, 1, 0.006);
	i+d
}.play



{PanAz.ar(8, 
	Saw.ar(255, 0.1), 
	TRand.ar(0,2, Impulse.ar(MouseX.kr(0.1, 100))), 
	0.5, 
	1, 
	0)}.play


{PanAz.ar(8, 
	Saw.ar(255, 0.1), 
	LFNoise2.ar(1).range(0,2), 
	0.5, 
	1, 
	0)}.play




{LFSaw.ar(333).range(2,0)}.plot(minval:0, maxval:2)




b = Buffer.read(s, "/Users/thor/Library/Application Support/SuperCollider/sounds/holeMONO.aif");
c = Buffer.read(s, "/Users/thor/Library/Application Support/SuperCollider/sounds/hole.aif");

b.play

s.scope(8)


{PanAz.ar(8, PlayBuf.ar(1, b, loop:1), LFNoise2.kr(1).range(0, 2), 0.5, LFNoise2.kr(1).range(0.9, 4), 0)}.play

{PanAz.ar(8, PlayBuf.ar(1, b, loop:1), LFSaw.kr(1).range(2, 0), 0.5, LFNoise2.kr(1).range(0.9, 4), 0)}.play


{PanAz.ar(8, PlayBuf.ar(1, b, loop:1), LFSaw.kr(LFNoise2.kr(1).range(0, 2)).range(1, 0), 0.5, LFNoise2.kr(1).range(0.9, 4), 0)}.play


SynthDef(\cyclone, {arg buffer;
	Out.ar(0, 
		PanAz.ar(8, PlayBuf.ar(1, buffer, loop:1), LFSaw.kr(LFNoise2.kr(1).range(0, 2)).range(1, 0), 0.5, LFNoise2.kr(1).range(0.9, 4), 0)
	)
}).add;

a = Synth(\cyclone, [\buffer, b])
a.free

x = Synth(\cyclone, [\buffer, c])




// in stereo

SynthDef(\cyclone, {arg buffer;
	Out.ar(0, 
		Pan2.ar(PlayBuf.ar(1, buffer, loop:1), SinOsc.kr(0.1).range(-1, 1))
	)
}).add;

a = Synth(\cyclone, [\buffer, b])





