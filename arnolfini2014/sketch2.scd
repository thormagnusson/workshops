
w = Window.new.front;
w.bounds_(Rect(100, 1100, 1200, 800));

v = UserView.new(w, w.view.bounds);
v.background = Color.red;

b = Rect(100, 100, 90, 90);

v.drawFunc_({
	a.draw;
	Pen.color_(Color.white);
	Pen.addOval(b);
	Pen.color_(Color.black);
	Pen.addOval(Rect(rrand(20, 200),rrand(20, 200),40,40));
	Pen.draw;
});

v.refresh

v.mouseDownAction = { v.background = Color.red(rrand(0.5,1.0)) };

v.mouseMoveAction = {|view,mx,my| b = Rect(mx, 100, 80, 80) ; a.set(\freq, mx); v.refresh};


w.acceptsMouseOver = true;

v.mouseOverAction = {|view,mx,my| b = Rect(mx, 100, 80, 80) ; a.set(\freq, mx); v.refresh};

v.animate = true;
v.frameRate = 24;

v.clearOnRefresh = false;
v.clearOnRefresh = true;

s.boot
a = {|freq=555| SinOsc.ar(freq)}.play

