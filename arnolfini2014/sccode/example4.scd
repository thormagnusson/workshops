
// an example of using OSC from one computer to another


(
s.boot; // we start with booting the server
w = Window.new("arnolfini", Rect(0,0, 1200, 800)).front;
v = UserView.new(w, w.view.bounds);
v.background = Color.rand;
x=20; y = 200; // just set some initial values
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

// at Arnolfini, thor's computer had the IP address of 172....
// if you are sending locally on your machine, you can use "127.0.0.1"
n = NetAddr("172.16.10.245", 57120); // 57120 is sclang default port
n.sendMsg("/freq", 333.rand);
n.sendMsg("/cutoff", 1333.rand);

// the two OSC listeners, listening to messages titled
// 'freq' and 'cutoff' from another computer
o = OSCFunc({arg msg; msg.postln;  y = msg[1]; }, '/freq');
q = OSCFunc({arg msg; msg.postln;  x = msg[1]; }, '/cutoff');

// our synth
a = {arg freq=440, cutoff=200; LPF.ar(Saw.ar(freq), cutoff)}.play

v.refresh;

