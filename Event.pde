class Event{
	WindowEvent windowEvent;
	MouseEvent mouseEvent;
	KeyEvent keyEvent;
	int windowWidth,windowHeight;
	Event(){
		mouseEvent=new MouseEvent();
		windowWidth=width;
		windowHeight=height;
	}

	void mousePressed(int _mouseX,int _mouseY){
		mouseEvent.mousePressed(_mouseX,_mouseY);
	}

	void mouseReleased(){
		mouseEvent.mouseReleased();
	}

	void keyPressed(){
		keyEvent.keyPressed();
	}

	void keyReleased(){
		keyEvent.keyReleased();
	}

	boolean isResize(){
		return windowWidth!=width||windowHeight!=height;
	}

	void windowResized(){
		windowEvent.windowResized();
	}

	void mouseMoved(int _mouseX,int _mouseY){
		mouseEvent.mouseMoved(_mouseX,_mouseY);
	}
}
