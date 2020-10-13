Button b;
PFont fonta;
void setup(){
	size(200,200);
b= new Button("test",50,50,100,20);
fonta=loadFont("mplus-1p-regular-32.vlw");
printArray(PFont.list());
}

void draw(){
	background(255);
	b.toggleDraw();
	b.redraw();
	delay(500);
}

void mousePressed(){
b.setButtonTextFont(fonta);
}

void mouseReleased(){
b.resetButtonTextFont();
}

void keyPressed(){

}

void keyReleased(){

}
