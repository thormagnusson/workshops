s.boot


// which becomes this (a SynthDef):
SynthDef(\aalto, {arg freq=440, cutoff=4, detune=2, gate=1, rq=0.19;
	a = Saw.ar(freq, 0.5) + Saw.ar(freq+detune, 0.5); // sound source
	b = RLPF.ar(a, cutoff*freq, rq); // filter
	c = EnvGen.ar(Env.adsr, gate, doneAction:2); // envelope
	d = b * c;       // envelope applied to the signal
	p = Pan2.ar(d);  // signal panned into stereo
	Out.ar(0, p)     // sending to the sound card
}).store



// monophonic synth
MIDIClient.init;
MIDIIn.connectAll;
MIDIdef.noteOn(\test, {arg vel, pitch, ch, id;
	[vel, pitch, ch, id].postln;
	a.release;
	a = Synth(\xylo, [\freq, pitch.midicps]);
});
MIDIdef.noteOff(\testoff, {arg vel, pitch, ch, id;
	[vel, pitch, ch, id].postln;
	a.release;
});



n = Array.fill(127, {nil});
// polyphonic synth
MIDIClient.init;
MIDIIn.connectAll;
MIDIdef.noteOn(\test, {arg vel, note, ch, id;
	n[note] = Synth(\aalto, [\freq, note.midicps]);
});
MIDIdef.noteOff(\testoff, {arg vel, note, ch, id;
	n[note].release;
});



MIDIClient.init;
MIDIIn.connectAll;
MIDIdef.noteOn(\test, {arg vel, pitch, ch, id;
pitch.postln;
	Synth(\xylo, [\freq, pitch.midicps]);
});


(
n = Array.fill(127, {nil});
c = 4; d = 4; q = 0.19;
// polyphonic synth
MIDIClient.init;
MIDIIn.connectAll;
MIDIdef.noteOn(\test, {arg vel, note, ch, id;
	n[note] = Synth(\aalto, [\freq, note.midicps, \cutoff, c, \detune, d, \rq, q]);
});
MIDIdef.noteOff(\testoff, {arg vel, note, ch, id;
	n[note].release;
});
MIDIdef.cc(\testcc, {arg key, func, ccNum, chan, srcID;
	[key, func, ccNum, chan].postln;
	if(func == 103, { // first knob
	c = key/6;
	n.do({arg synth; synth.set(\cutoff, c)});
	});
	if(func == 117, { // second knob
	d = key/6;
	n.do({arg synth; synth.set(\detune, d)});
	});
	if(func == 7, { // third knob
	q = key/127;
	n.do({arg synth; synth.set(\rq, q)});
	});

});
)




a = [23, 44, 55]
a = Array.fill(20, {"elosjak".scramble})
a.reverse

MIDIFunc


Array.fill(12, {Synth(\xylo, [\freq, 400.rand, \amp, 0.1])})




a = {arg freq=440, amp=0.1;
	Array.fill( 10, {arg i;
		SinOsc.ar(freq+(i*2), pi.rand, (amp*((i+1).reciprocal)).min(0.1))
	}).sum
}.play

a.set(\amp, 0.88)

7.reciprocal