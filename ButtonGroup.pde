class ButtonGroup{
	private int defaultPosX=0,defaultPosY=0,defaultSizeX=64,defaultSizeY=24;
	private ArrayList<Button> button = new ArrayList<Button>();
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

	void addButton(String[] _text,int[] _posX,int[] _posY,int[] _sizeX,int[] _sizeY){
		if(_text.length!=_posX.length||_text.length!=_posY.length||_text.length!=_sizeX.length||_text.length!=_sizeY.length){
			return;
		}
		for(int i = 0,len=_text.length;i<len;i++){
			button.add(new Button(_text[i],_posX[i],_posY[i],_sizeX[i],_sizeY[i]));
		}
	}

	void removeButton(int _removeId){
		button.remove(_removeId);
	}

	void redraw(int _id){
		button.get(_id).redraw();
	}

	void redraw(){
		for(int i = 0,len=button.size();i<len;i++){
			button.get(i).redraw();
		}
	}

	void setButtonText(int _id,String _text){
		button.get(_id).setButtonText(_text);
	}

	void setButtonText(String _text){
		for(int i = 0,len=button.size();i<len;i++){
			button.get(i).setButtonText(_text);
		}
	}

	void setButtonText(String[] _text){
		for(int i = 0,len=button.size();i<len;i++){
			button.get(i).setButtonText(_text[i]);
		}
	}

	void setButtonImage(PImage[] _image){
		for(int i = 0,len=button.size();i<len;i++){
			button.get(i).setButtonImage(_image[i]);
		}
	}

	void setButtonImage(int _id,PImage _image){
			button.get(_id).setButtonImage(_image);
	}

	void setButtonImage(PImage _image){
		for(int i = 0,len=button.size();i<len;i++){
			button.get(i).setButtonImage(_image);
		}
	}

	void setButtonAccentColor(color _buttonAccentColor){
		for(int i = 0,len=button.size();i<len;i++){
			button.get(i).setButtonAccentColor(_buttonAccentColor);
		}
	}

	void setButtonAccentColor(int _id,color _buttonAccentColor){
		button.get(_id).setButtonAccentColor(_buttonAccentColor);
	}

	void setButtonBaseColor(int _id,color _buttonBaseColor){
		button.get(_id).setButtonBaseColor(_buttonBaseColor);
	}

	void setButtonBaseColor(color _buttonBaseColor){
		for(int i = 0,len=button.size();i<len;i++){
			button.get(i).setButtonBaseColor(_buttonBaseColor);
		}
	}

	void setButtonBaseColor(color[] _buttonBaseColor){
		for(int i = 0,len=button.size();i<len;i++){
			button.get(i).setButtonBaseColor(_buttonBaseColor[i]);
		}
	}

	void setButtonTextColor(int _id,color _buttonTextColor){
		button.get(_id).setButtonTextColor(_buttonTextColor);
	}

	void setButtonTextColor(color _buttonTextColor){
		for(int i = 0,len=button.size();i<len;i++){
			button.get(i).setButtonTextColor(_buttonTextColor);
		}
	}

	void setButtonTextColor(color[] _buttonTextColor){
		for(int i = 0,len=button.size();i<len;i++){
			button.get(i).setButtonTextColor(_buttonTextColor[i]);
		}
	}

	void setDefaultPos(int _setPosX,int _setPosY){
		defaultPosX=_setPosX<0?defaultPosX:_setPosX;
		defaultPosY=_setPosY<0?defaultPosY:_setPosY;
	}

	void setDefaultSize(int _setSizeX,int _setSizeY){
		defaultSizeX=_setSizeX<0?defaultSizeX:_setSizeX;
		defaultSizeY=_setSizeY<0?defaultSizeY:_setSizeY;
	}

	void setButtonPos(int _id,int _setPosX,int _setPosY){
		button.get(_id).setButtonPos(_setPosX,_setPosY);
	}

	void setButtonPos(int _setPosX,int _setPosY){
		for(int i = 0,len=button.size();i<len;i++){
			button.get(i).setButtonPos(_setPosX,_setPosY);
		}
	}

	void setButtonPos(int[] _setPosX,int[] _setPosY){
		if (_setPosX.length!=_setPosY.length||_setPosX.length+_setPosY.length!=button.size()*2){
			return;
		}
		for(int i = 0,len=button.size();i<len;i++){
			button.get(i).setButtonPos(_setPosX[i],_setPosY[i]);
		}
	}

	void setButtonSize(int _setSizeX,int _setSizeY){
		for(int i = 0,len=button.size();i<len;i++){
			button.get(i).setButtonSize(_setSizeX,_setSizeY);
		}
	}
	void setButtonSize(int[] _setSizeX,int[] _setSizeY){
		if (_setSizeX.length!=_setSizeY.length||_setSizeX.length+_setSizeY.length!=button.size()*2){
			return;
		}
		for(int i = 0,len=button.size();i<len;i++){
			button.get(i).setButtonSize(_setSizeX[i],_setSizeY[i]);
		}
	}

	void setButtonTextFont(int _id,PFont _font){
		button.get(_id).setButtonTextFont(_font);
	}

	void setButtonTextFont(PFont _font){
		for(int i = 0,len=button.size();i<len;i++){
			button.get(i).setButtonTextFont(_font);
		}
	}

	void setButtonDraw(int _id,boolean _drawFlg){
		button.get(_id).setButtonDraw(_drawFlg);
	}

	void setButtonActivity(int _id,boolean _activityFlg){
		button.get(_id).setButtonActivity(_activityFlg);
	}

	void toggleButtonDraw(int _id){
		button.get(_id).toggleButtonDraw();
	}

	void toggleButtonActivity(int _id){
		button.get(_id).toggleButtonActivity();
	}

	void setButtonDraw(boolean _drawFlg){
		for(int i = 0,len=button.size();i<len;i++){
			button.get(i).setButtonDraw(_drawFlg);
		}
	}

	void setButtonActivity(boolean _activityFlg){
		for(int i = 0,len=button.size();i<len;i++){
			button.get(i).setButtonActivity(_activityFlg);
		}
	}

	void toggleButtonDraw(){
		for(int i = 0,len=button.size();i<len;i++){
			button.get(i).toggleButtonDraw();
		}
	}

	void toggleButtonActivity(){
		for(int i = 0,len=button.size();i<len;i++){
			button.get(i).toggleButtonActivity();
		}
	}

	void resetButtonImage(){
		for(int i = 0,len=button.size();i<len;i++){
			button.get(i).resetButtonImage();
		}
	}

	void resetButtonImage(int _id){
		button.get(_id).resetButtonImage();
	}

	void resetButtonTextFont(){
		for(int i = 0,len=button.size();i<len;i++){
			button.get(i).resetButtonTextFont();
		}
	}

	void resetButtonTextFont(int _id){
		button.get(_id).resetButtonTextFont();
	}

	void resetColor(int _id){
		button.get(_id).resetColor();
	}

	void resetColor(){
		for(int i = 0,len=button.size();i<len;i++){
			button.get(i).resetColor();
		}
	}
}
