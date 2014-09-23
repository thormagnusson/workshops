
w = Window.new("arnolfini", Rect(0,0, 1200, 800)).front;
v = UserView.new(w, w.view.bounds);
v.background = Color.rand;

v.drawFunc = {
	Pen.color = Color.white;
	Pen.addOval(Rect(100.rand, 100.rand, 20, 20));
	Pen.draw;
	// one quick way of making sound:
	{SinOsc.ar(1000+(2000.rand))
		*EnvGen.ar(Env.perc(0.001, 0.1), doneAction:2)}.play
};

v.animate = false;
v.frameRate = 15;

v.refresh;

