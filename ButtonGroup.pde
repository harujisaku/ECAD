class ButtonGroup{
	int defaultPosX,defaultPosY,defaultSizeX,defaultSizeY;
	ArrayList<Button> button = new ArrayList<Button>();
	ButtonGroup(int _defaultPosX,int _defaultPosY,int _defaultSizeX,int _defaultSizeY){
		defaultPosX=_defaultPosX;
		defaultPosY=_defaultPosY;
		defaultSizeX=_defaultSizeX;
		defaultSizeY=_defaultSizeY;
	}

	int  addButton(String _text,int _posX,int _posY,int _sizeX,int _sizeY){
		button.add(new Button(_text,_posX,_posY,_sizeX,_sizeY));
		return button.size()-1;
	}

	int addButton(String _text){
		button.add(new Button(_text,defaultPosX,defaultPosY,defaultSizeX,defaultSizeY));
		defaultPosY+=defaultSizeY;
		return button.size()-1;
	}

	int  addButton(String _text,int _posX,int _posY){
		button.add(new Button(_text,_posX,_posY,defaultSizeX,defaultSizeY));
	return button.size()-1;
	}
}
