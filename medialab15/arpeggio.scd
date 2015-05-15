// check out the Array help file

// look up the methods, like "sort", "lace", "sputter", etc.

MIDIClient.init;
MIDIIn.connectAll;
(
var arpeggio, sort, mirror, pyramid;
arpeggio = OrderedIdentitySet.new;
sort = true;
mirror = false;
pyramid = false;

MIDIdef.noteOn(\teston, {arg vel, pitch, ch, id;
	arpeggio.add(pitch);
	arpeggio.postln;
});
MIDIdef.noteOff(\testoff, {arg vel, pitch, ch, id;
	arpeggio.remove(pitch);
	arpeggio.postln;
});

fork{
	inf.do({
		b = arpeggio.asArray.copy;
		b.postln;
		0.25.wait;
	if(b.size>0,{
		if(sort == true, {b = b.sort});
		if(mirror == true, { b = b.mirror1});
		if(pyramid == true, { b = b.pyramid});

		b.postln;
		b.do({arg note, i;

				//b.postln;
				if(i > 0, { 0.25.wait; });
				//0.25.wait;
		Synth(\xylo, [\freq, note.midicps]);
});
		});
	})
	}
)


