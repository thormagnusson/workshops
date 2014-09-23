
// a sketch where we follow the pitch and draw it onto the window

s.boot

SynthDef(\pitchFollower, {
	var in, freq, hasFreq;
	in = SoundIn.ar(0);
	#freq, hasFreq = Tartini.kr(in);
	SendReply.kr(Impulse.kr(24), '/freq', [freq, hasFreq]);
}).add;

// create a synth that will analyse sound input
x = Synth(\pitchFollower);

// receive messages from the server into the language
o = OSCFunc({ |msg| msg.postln; a = msg[3].linlin(0,2000, 800, 0); h=msg[4]; }, '/freq');
o.release

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
	Pen.addOval(Rect(p-2,a-2,4,4));
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

	Pen.addOval(Rect(p-2,a-2,4,4));
	Pen.line(Point(p-1, t), Point(p, a));
	Pen.stroke;
	Pen.draw;
	if(p>w.bounds.width, {p = 0; v.clearDrawing }); // reset our pen head
	if(h==1, {t = a}, {t = t});
});
)

a = {SinOsc.ar(MouseX.kr(100, 2111), 0, 1 )}.play


