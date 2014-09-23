
(
w = Window.new("arnolfini", Rect(0,0, 1200, 800)).front;
v = UserView.new(w, w.view.bounds);
v.background = Color.rand;
x=20; y = 200;
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
)

n = NetAddr("172.16.10.245", 57120); // 57120 is sclang default port
n.sendMsg("/freq", 333.rand);
n.sendMsg("/cutoff", 1333.rand);

o = OSCFunc({arg msg; msg.postln;  y = msg[1]; }, '/freq');
q = OSCFunc({arg msg; msg.postln;  x = msg[1]; }, '/cutoff');

q.free
a = {arg freq=440, cutoff=200; LPF.ar(Saw.ar(freq), cutoff)}.play
s.boot

a.free
a.set(\cutoff, 220);
y = 100;

v.refresh;

