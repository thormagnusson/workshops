
// mapping values using:
- linlin
- linexp
- explin
- expexp


w = Window("RGB fader", Rect(100, 500, 400, 400)).front;
r = Slider(w, Rect(100, 140, 200, 40))
    .value_(0.5)
    .action_({ arg sl;
		var sliderval, mappedval;
		sliderval = sl.value;
		mappedval = sliderval.linexp(0, 1, 20, 12000); // linexp!
		[\sliderval, sliderval, \mappedval, mappedval.round(1)].postln;
		a.set(\freq, mappedval);
});

a = {arg freq=440; SinOsc.ar(freq)}.play
