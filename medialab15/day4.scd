
// brackets () and function brackets {}
(
var amp, calamp;
amp = 22;
"amp is now: ".post; amp.postln;
amp = 33;
"and now amp is: ".post; amp.postln;
// a function is a scope, and if a variable is declared within it, it exists within a closed scope (a clojure)
f = {arg x, y;
	var amp; // try to comment this out
	amp = x+y;
	// "hello";
};
calamp = f.value(2, 3);
"and after the function calamp is: ".post; calamp.postln;
"and after the function amp is: ".post; amp.postln;

amp = 2299999;
"finally, a is : ".post; amp.postln;
)


// square brackets [] - these are ARRAYS
// run every line and observe the post window

a = [11,22,33,[44, 222],55]+5;
a[1]
a[3]
a[3][0]
a.scramble
a
a = a.scramble;
a
Array.help // run this line and explore the methods of Array

a = [1, 1, 1, 2, 2, 2, 3, 3, 3]
a = a.collect({arg item, i; item*(i/2)}) // we can transform (functional transform)



(
// control statements
a = 33;

if(a > 100.rand,  // a condition (which will be either true or false)
	{"yippy".postln;}, // the TRUE response
	{"oh no!".postln;}); // the FALSE response

// a quick way if you have LOTS of if-statements.
switch(a)
{33} {"yippy".postln;}
{34} {"no".postln;}
{35} {"no 2".postln;}
{36} {"no 3".postln;}
{37} {"no 4".postln;}
{38} {"no 5".postln;}
{39} {"no 6".postln;}; // the only semicolon is here

)


// finally ...  loops

(

10.do({ 33.rand.postln;});

a = [];
100.do({arg i; a = a.add(i*100); i.postln;});
a

// in processing or open frameworks or java script or....
for(int i = 0; i<100, i++){
	a = a.add(i*100);
}

a = [60, 63, 66, 68, 69, 70]// a scale!
// create an array with a fifth
b = a.collect({arg item, i; item+7}) // transpose the scale up by a fifth
// or simply
b = a+7;


)

s.boot
{LFSaw.ar(MouseX.kr(100, 10000))}.freqscope
SinOsc