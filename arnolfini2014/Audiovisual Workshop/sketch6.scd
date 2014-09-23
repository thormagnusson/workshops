w = Window.new.front;
w.bounds_(Rect(100, 1100, 1200, 800));

v = UserView.new(w, w.view.bounds);
v.background = Color.red;

x = 100; y = 300;

i = Image.open(SCDoc.helpSourceDir +/+ "images/Swamp.png");

v.drawFunc_({
	f = 1300.rand-50;
	p = 900.rand-50;
	Pen.color = Color.red.alpha_(0.02);
	Pen.fillRect(Rect(0, 0, 1200, 800));
	i.drawAtPoint(Point(f, p));
	Synth(\grain, [\freq, (f-1200).abs*2, \pan, p.linlin(-50, 850, -1, 1)]);
});

v.refresh;
v.animate = true;
v.mouseMoveAction = { |view, mx, my| x=mx; y=my };
v.clearOnRefresh = false;

SynthDef(\grain, {arg freq=440, pan=0;
	var signal;
	signal = SinOsc.ar(freq, 0, 0.2)*EnvGen.ar(Env.perc(0.001, 0.1), doneAction:2);
	Out.ar(0, Pan2.ar(signal, pan));
}).add;

s.boot
