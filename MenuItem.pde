class MenuItem extends Button{
	MenuItem(String a,int g,int s,int k){
		super("test",0,0,100,20);
	}

	void draw(int _mouseX,int _mouseY){
		super.setButtonPos(_mouseX,_mouseY);
	}
}
