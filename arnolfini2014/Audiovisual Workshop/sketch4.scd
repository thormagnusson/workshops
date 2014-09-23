w = Window.new.front;
w.bounds_(Rect(100, 1100, 1200, 800));

v = UserView.new(w, w.view.bounds);
v.background = Color.red;

x = 100; y = 300;

i = Image.open(SCDoc.helpSourceDir +/+ "images/Swamp.png");

v.drawFunc_({
	i.drawAtPoint(Point(x, y));
	Pen.color_(Color.white);
	Pen.addOval(Rect(rrand(20, 200),rrand(20, 200),40,40));
	Pen.draw;
	Pen.color_(Color.black);
	Pen.addOval(Rect(rrand(20, 200),rrand(20, 200),40,40));
	Pen.draw;
});

v.refresh;
v.animate = true;
v.mouseMoveAction = { |view, mx, my| x=mx; y=my };
v.clearOnRefresh = false;
