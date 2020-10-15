class MouseEvent{
	MenuItem m=new MenuItem("test",1,100,20);
	MouseEvent(){
	}

	void mousePressed(int _mouseX,int _mouseY){
		m.draw(_mouseX,_mouseY);
		m.redraw();
	}

	void mouseReleased(){

	}

	void mouseMoved(int _mouseX,int _mouseY){

	}
}
