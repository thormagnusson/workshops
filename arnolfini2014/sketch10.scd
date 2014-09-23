
s.boot;

f = Buffer.alloc(s, 1024); // allocate an FFT buffer

// create a synthdef that writes into the buffer
SynthDef(\spectroscope, {|inbus=0, buffer=0|
	FFT(buffer, InFeedback.ar(inbus));
}).add;

// analyse the sound in
{Out.ar(0, SoundIn.ar(0))}.play; // put the sound in out on the left channel
Synth(\spectroscope, [\inbus,0, \buffer, f.bufnum]); // listen to that channel

// the drawing window
(
w = Window.new.front;
w.bounds_(Rect(100, 1100, 1200, 800));

v = UserView.new(w, w.view.bounds);
v.background = Color.red;

m = {200.rand+200}!1024; // an array to draw

v.drawFunc_({
	1024.do({arg p;
		//Pen.addOval(Rect(p,a[p],4,4));
		Pen.line(Point((p-1)*2, t), Point(p*2, m[p]));
		Pen.stroke;
		t = m[p];
	});
});

v.animate = false;
v.clearOnRefresh = true;
)

// what's in the buffer 'f'?
f.getn(0, 1024, { arg buf; buf.postln;})

// we need to do come calculations on that buffer data

fork{
	inf.do({
		f.getn(0, 1024, { arg buf;
			var magarray, complexarray;
			magarray = buf.clump(2).flop;

			complexarray = ((((Complex(
				Signal.newFrom( magarray[0] ),
				Signal.newFrom( magarray[1] )
			).magnitude.reverse)).log10)*80);

			complexarray.reverse.do({|val, i|
				m[i] = (val-200).abs;
			});
			{v.refresh}.defer;
		});

		0.05.wait;
	})
}


z = {Saw.ar(MouseX.kr(100, 2111), 1 )}.play
z.free

s.freeAll








(
w = Window.new.front;
w.bounds_(Rect(100, 1100, 1200, 800));

v = UserView.new(w, w.view.bounds);
v.background = Color.red;

m = {200.rand+200}!1024; // an array to draw

v.drawFunc_({
		Pen.color = Color.red.alpha_(0.09);
		Pen.fillRect(Rect(0, 0, 1200, 800));
	1024.do({arg p;
		Pen.color = Color.black;
		Pen.line(Point((p-1)*2, t), Point(p*2, m[p]));
		Pen.stroke;
		t = m[p];
	});
});

v.animate = false;
v.clearOnRefresh = false;
)
