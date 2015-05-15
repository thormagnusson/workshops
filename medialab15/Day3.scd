
// Server to language communication
// (here we draw a blob controlled by the oscillation of a SinOsc)

// create a window and draw in it
(
w = Window.new.front;
w.view.bounds_(Rect(0, 0, 1000, 800));
w.view.background = Color.blue;

b = Rect(100, 100, 90, 90);

w.drawFunc_({
	Pen.color_(Color.white);
	Pen.addOval(b);
	Pen.draw;
});
)

// create a mouse listener controlling the oval
(
w.view.mouseMoveAction = {arg view, mx, my;
	[view, mx, my].postln;
	b = Rect(mx, 100, 80*(my/80), 80*(my/80)) ;
	w.refresh;
};
)

// create a sender from server to language (GUI is on the language)
SynthDef(\osctolang, {
	SendReply.kr(Impulse.kr(150), '/blobfreq', SinOsc.kr(LFNoise2.kr(0.1).range(0.5, 4)))
}).add;

// create a sender from server to language (GUI is on the language)
SynthDef(\osctolang, {
	var amp = Amplitude.ar(SoundIn.ar);
	SendReply.kr(Impulse.kr(150), '/blobfreq', amp )
}).add;


x.free // free old synth
x = Synth(\osctolang) // send to language


(
// OSC receiver
// a little synth (a bit ridiculous as we're now sending values back to the synth)
a = {|freq=555| SinOsc.ar(Lag.kr(freq, 0.1))}.play;

OSCdef(\listen, { |msg, time, addr, recvPort|
//	if(msg[1].asString == "jani", {"hi jani".postln; Synth(\aalto, [\freq, msg[2]]) });
//	if(msg[1].asString == "Esa", {"hi esa".postln; Synth(\xylo, [\freq, msg[2]])  });
//	msg.postln;
	b = Rect(300-(((msg[3]+1)*200)/2), 300-(((msg[3]+1)*200)/2), (msg[3]+1)*200, (msg[3]+1)*200);
	a.set(\freq, 20+((msg[3]+1)*400));
	{w.refresh}.defer;
}, '/blobfreq', nil).add
)


// if you want to control this from another computer (or software)
// OSC sender
// OSC ->    IP address        +      Port
n = NetAddr("10.100.16.196", 57120);
n.sendMsg("/osc", "name", 1000.rand);





