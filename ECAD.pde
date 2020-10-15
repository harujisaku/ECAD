Button b;
Window w;
Event e;
PImage a;
void setup(){
	size(200,200);
	noSmooth();
	a=loadImage("start.png");
	Font.defaultFont=loadFont("mplus-1p-regular-14.vlw");
	b= new Button("test",0,0,200,200);
	w= new Window("a",0,0);
	e= new Event();
}

void draw(){
	if (frameCount%30==0){
		background(125);
		b.toggleButtonActivity();
		b.redraw();
	}
}

void mousePressed(){
	background(125);
	b.setButtonImage(a);
	b.redraw();
	e.mousePressed(mouseX,mouseY);
}

void mouseReleased(){
	b.resetButtonImage();
	background(125);
	b.redraw();
}

void keyPressed(){

}

void keyReleased(){

}

void mouseMoved(){
	e.mouseMoved(mouseX,mouseY);
}
