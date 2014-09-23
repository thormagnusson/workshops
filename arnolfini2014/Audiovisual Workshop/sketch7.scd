
// an example from redFrik's tutorial here:
// http://www.fredrikolofsson.com/software/AudiovisualProgramming02.html


(
var width= 640;
var height= 480;
var win= Window("hsvlines", Rect(10, 10, width, height), false);
var usr= UserView(win, Rect(0, 0, width, height));
usr.background= Color.black;
win.front;
~speed= 0.1;
~width= 1;
CmdPeriod.doOnce({win.close});
usr.drawFunc= {
	Pen.width= ~width;
	70.do{|i|
		Pen.strokeColor= Color.hsv(i/70, 0.5, 0.8);
		Pen.strokeOval(Rect.aboutPoint(Point(width*0.5, height*0.5).rotate(i/69*2pi+(usr.frame*~speed))+Point(width*0.5, height*0.5), width*0.9, height*0.9));
		Pen.stroke;
	};
};
usr.animate= true;
)


~speed= 0.2
~speed= -0.2
~speed= 0.002
~speed= 2.2
~speed= 2.5
~speed= 3
~speed= 3.1
~speed= 3.14
~speed= 3.1415
~speed= 2pi
~width= 2
~speed= 0.1
~width= 20
