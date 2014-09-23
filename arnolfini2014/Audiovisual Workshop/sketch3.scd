(
w = Window.new.front;
w.bounds_(Rect(100, 1100, 1200, 800));

v = UserView.new(w, w.view.bounds);
v.background = Color.red;

a = {var x = Ooo.new; x.loc(1000.rand, 800.rand)}!112;

v.drawFunc_({
	a.do({arg a; a.draw;});
});
v.animate = true;
v.mouseMoveAction = { |view, mx, my| a.do({arg a; a.loc((a.x+mx)/2+10.rand, (a.y+my)/2+10.rand)}); };
)

a.do({arg oo; oo.loc(1000.rand, 800.rand)});

v.clearOnRefresh = false;
v.clearOnRefresh = true;

// with trails

v.mouseMoveAction = { |view, mx, my|
	a.last.loc(a.last.x+mx/2, a.last.y+my/2);
	(a.size-1).do({arg i; a[i].loc(a[i+1].x, a[i+1].y);});

};



v.mouseDownAction = { |view, mx, my| a.loc((a.x+mx)/2, (a.y+my)/2) };

v.mouseDownAction = { v.background = Color.red(rrand(0.5,1.0)) };

v.mouseMoveAction = {|view,mx,my| b = Rect(mx, 100, 80, 80) ; a.set(\freq, mx); v.refresh};


w.acceptsMouseOver = true;

v.mouseOverAction = {|view,mx,my| b = Rect(mx, 100, 80, 80) ; a.set(\freq, mx); v.refresh};


