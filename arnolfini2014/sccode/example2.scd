
w = Window.new("arnolfini", Rect(0,0, 1200, 800)).front;
v = UserView.new(w, w.view.bounds);
v.background = Color.rand;

v.mouseMoveAction = {arg view, mx, my;
	x = mx;
	y = my;
}

a = {arg freq=440, cutoff=200; LPF.ar(Saw.ar(freq), cutoff)}.play
a.free
a.set(\freq, 220);

v.drawFunc = {
	Pen.color = Color.white;
	Pen.addOval(Rect(x, y, 20, 20));
	Pen.draw;
	a.set(\freq, (y-800).abs);
	a.set(\cutoff, 20+(x*4));
};

v.clearOnRefresh = true;
v.animate = true;
v.frameRate = 25;

v.refresh;

