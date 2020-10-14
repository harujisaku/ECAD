class Button{
	private String text;
	private int posX,posY,sizeX,sizeY,textSize=13;
	private boolean drawFlg=true,activityFlg=true;
	private PImage image;
	private color buttonAccentColor=color(51,153,255);
	private color buttonBaseColor=color(255,255,255);
	private color buttonTextColor=color(0,0,0);
	private color buttonGrayColor=color(125);
	private PFont font=Font.defaultFont;
	Button(String _text,int _posX,int _posY,int _sizeX,int _sizeY){
		posX=_posX;
		posY=_posY;
		sizeX=_sizeX;
		sizeY=_sizeY;
		text=_text;
	}
	Button(String _text,int _posX,int _posY,int _sizeX,int _sizeY,boolean _drawFlg,boolean _activityFlg){
		posX=_posX;
		posY=_posY;
		sizeX=_sizeX;
		sizeY=_sizeY;
		text=_text;
		drawFlg=_drawFlg;
		activityFlg=_activityFlg;
	}

	void setText(String _text){
		text=_text;
	}

	void setPos(int _posX,int _posY){
		posX=_posX;
		posY=_posY;
	}

	void setSize(int _sizeX,int _sizeY){
		sizeX=_sizeX;
		sizeY=_sizeY;
	}

	void setDraw(boolean _drawFlg){
		drawFlg=_drawFlg;
	}

	void setActivity(boolean _activityFlg){
		activityFlg=_activityFlg;
	}

	void toggleDraw(){
		drawFlg=!drawFlg;
	}

	void toggleActivity(){
		activityFlg=!activityFlg;
	}

	void redraw(){
		if(!drawFlg){
			return;
		}
		pushMatrix();
		fill(buttonBaseColor);
		stroke(activityFlg?buttonAccentColor:buttonGrayColor);
		strokeWeight(2);
		textAlign(CENTER,CENTER);
		rect(posX,posY,sizeX,sizeY);
		fill(activityFlg?buttonTextColor:buttonGrayColor);
		if(font !=null){
			textFont(font);
		}
		textSize(textSize);
		text(text,posX+sizeX/2,posY+sizeY/2);
		popMatrix();
	}

	int setImage(PImage _image){
		image=_image;
		return 0;
	}

	void setButtonAccentColor(color _buttonAccentColor){
		buttonAccentColor=_buttonAccentColor;
	}

	void setButtonBaseColor(color _buttonBaseColor){
		buttonBaseColor=_buttonBaseColor;
	}

	void setButtonTextColor(color _buttonTextColor){
		buttonTextColor=_buttonTextColor;
	}

	void setButtonTextFont(PFont _font){
		font=_font;
	}

	void setButtonTextSize(int _textSize){
		textSize=_textSize;
	}

	void setColorDefault(){
		buttonAccentColor=color(51,153,255);
		buttonBaseColor=color(255,255,255);
		buttonTextColor=color(0,0,0);
		buttonGrayColor=color(125);
	}

	void resetButtonTextFont(){
		font=Font.defaultFont;
	}
}
