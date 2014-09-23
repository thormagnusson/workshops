
w = Window.new.front;
w.view.bounds_(Rect(0, 0, 1000, 800));
w.view.background = Color.blue;

b = Rect(100, 100, 90, 90);

w.drawFunc_({
	Pen.color_(Color.white);
	Pen.addOval(b);
	Pen.draw;
	Pen.color_(Color.black);
	Pen.addOval(Rect(rrand(20, 200),rrand(20, 200),40,40));
	Pen.draw;
});

w.refresh

w.view.mouseDownAction = { w.background = Color.red(0.6) };

w.view.mouseMoveAction = {|view,mx,my| [a,b,c,d,e,f].postln; b = Rect(mx, 100, 80, 80) ; a.set(\freq, mx); w.refresh};

w.view.acceptsMouseOver = true;

w.view.mouseOverAction = {|view,mx,my| [a,b,c,d,e,f].postln; b = Rect(mx, 100, 80, 80) ; a.set(\freq, mx); w.refresh};

fork{inf.do({{w.refresh}.defer; 0.01.wait;});}

s.boot
a = {|freq=555| SinOsc.ar(freq)}.play
