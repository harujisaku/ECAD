Button b;
Window w;
PFont fonta;
void setup(){
	size(200,200);
	fonta=createFont("KozGoPr6N-Medium",14.0);
	Font.defaultFont=loadFont("mplus-1p-regular-32.vlw");
	b= new Button("test",50,50,100,20);
	w= new Window("a",0,0);
}

void draw(){
	if (frameCount%30==0){
		background(255);
		b.toggleActivity();
		b.redraw();
	}
}

void mousePressed(){
	b.setButtonTextFont(fonta);
	background(255);
	b.redraw();
}

void mouseReleased(){
	b.resetButtonTextFont();
	background(255);
	b.redraw();
}

void keyPressed(){

}

void keyReleased(){

}
