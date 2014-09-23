
// a sketch where we follow the amplitude and draw it onto the window

s.boot

SynthDef(\ampFollower, {
	var in, amp;
	in = SoundIn.ar(0);
	amp = Amplitude.kr(in, 0.01, 0.01);
	SendReply.kr(Impulse.kr(24), '/amp', amp);
}).add;

// create a synth that will analyse sound input
a = Synth(\ampFollower);

// receive messages from the server into the language
o = OSCFunc({ |msg| msg.postln; a = msg[3].linlin(0,1, 800, 0); }, '/amp');

// create a window that will draw points representing amplitude
(
w = Window.new.front;
w.bounds_(Rect(100, 1100, 1200, 800));

v = UserView.new(w, w.view.bounds);
v.background = Color.red;

p = -1; // p for pen head
a = 0; // amp is zero to begin with

v.drawFunc_({
	p = p + 1;
	Pen.addOval(Rect(p,a,4,4));
	Pen.draw;

	if(p>w.bounds.width, {p = 0; v.clearDrawing });
});
v.animate = true;
v.clearOnRefresh = false;
)

// let's try to draw a line
(
t = a;
v.drawFunc_({
	p = p + 1;
	Pen.addOval(Rect(p,a,4,4));
	Pen.line(Point(p-1, t), Point(p, a));
	Pen.stroke;
	Pen.draw;
	if(p>w.bounds.width, {p = 0; v.clearDrawing }); // reset our pen head
	t = a;
});
)


a = {SinOsc.ar(1440, 0, MouseX.kr(0, 1))}.play




