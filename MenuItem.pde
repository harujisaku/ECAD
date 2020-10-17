class MenuItem extends Button{
	MenuItem(String a,int g,int s,int k){
		super("test",0,0,100,20);
	}

	void draw(int _mouseX,int _mouseY){
		super.setButtonPos(_mouseX,_mouseY);
	}

	@Override
	void redraw(){
		if(!super.drawFlg){
			return;
		}
		pushMatrix();
		fill(super.buttonBaseColor);
		noStroke();
		rect(super.posX,super.posY,super.sizeX,super.sizeY);
		stroke(super.buttonGrayColor);
		strokeWeight(1);
		textAlign(CENTER,CENTER);
		rect(super.posX+2,super.posY+2,super.sizeX-4,super.sizeY-4);
		fill(super.activityFlg?super.buttonTextColor:super.buttonGrayColor);
		if(super.font !=null){
			textFont(super.font);
		}
		if(super.image!=null){
			image(super.image,super.posX,super.posY);
		}
		textSize(super.textSize);
		text(super.text,super.posX+super.sizeX/2,super.posY+super.sizeY/2);
		popMatrix();
	}

	@Override
	void setButtonImage(PImage _image){
		_image.resize(min(min(_image.width,_image.height),super.sizeY),min(min(_image.width,_image.height),super.sizeY));
			super.image=_image;
	}
}
