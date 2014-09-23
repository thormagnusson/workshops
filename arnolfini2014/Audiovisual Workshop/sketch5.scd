w = Window.new.front;
w.bounds_(Rect(100, 1100, 1200, 800));

v = UserView.new(w, w.view.bounds);
v.background = Color.red;

x = 100; y = 300;

i = Image.open(SCDoc.helpSourceDir +/+ "images/Swamp.png");

v.drawFunc_({
	i.drawAtPoint(Point(1300.rand-50, 900.rand-50));

});

v.refresh;
v.animate = true;
v.mouseMoveAction = { |view, mx, my| x=mx; y=my };
v.clearOnRefresh = false;
