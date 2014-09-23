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



// another version, here using Pen.drawImage, which is the same as i.drawAtPoint.


w = Window.new.front;
w.bounds_(Rect(100, 1100, 1200, 800));

v = UserView.new(w, w.view.bounds);
v.background = Color.red;

x = 100; y = 300;

i = Image.open(SCDoc.helpSourceDir +/+ "images/Swamp.png");

v.drawFunc_({
	i.drawAtPoint(Point(1300.rand-50, 900.rand-50), fraction:0.3);
	Pen.drawImage( Point(x, y), i, operation: 'sourceOver', opacity:1);
});

v.refresh;
v.animate = true;
v.mouseMoveAction = { |view, mx, my| x=mx; y=my };
v.clearOnRefresh = false;
