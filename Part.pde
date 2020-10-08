class Part{
	int sizeX,sizeY,posX,posY,deg,ofsetX,ofsetY;
	int copySizeX,copySizeY,copyPosX,copyPosY,copyDeg,copyOfX,copyOfY;
	String copyPath,copyGloup;
	boolean isNoMove=false;
	PImage photo;
	Part(int _deg,String gloup,String path,int _posX,int _posY){
		newParts(_deg,gloup,path,_posX,_posY);
	}
	Part(){}
	void newParts(int _deg,String gloup,String path,int _posX,int _posY) {
		photo = loadImage(path);
		posX=_posX;
		posY=_posY;
		copyPath=path;
		copyGloup=gloup;
		sizeX=photo.width;
		sizeY=photo.height;
		ofsetX=serchPointX(photo.width,photo.height);
		ofsetY=serchPointY(photo.width,photo.height);
		if(_deg!=-1){
			deg=_deg;
		}
	}

	void moveParts(int _posX,int _posY){
		if(posX==_posX&&posY==_posY){
			isNoMove=true;
		}else{
			isNoMove=false;
		}
		posX=_posX;
		posY=_posY;
	}

	boolean moveCheck(int psX,int psY){
		if(posX==psX&&posY==psY){
			isNoMove=true;
		}else{
			isNoMove=false;
		}
		return isNoMove;
	}

	void redrawParts() {
		pushMatrix();
		translate(posX,posY);
		rotate(radians(deg*90));
		image(photo,0-ofsetX,0-ofsetY);
		popMatrix();
	}

	void printVariable() {
		println(deg);
		println(posX);
		println(posY);
		println(ofsetX);
		println(ofsetY);
	}

	boolean posCheck(){
		if (deg==0){
			if((mouseX>=posX-ofsetX)&&(mouseY>=posY-ofsetY)&&(mouseX<=posX+sizeX-ofsetX)&&(mouseY<=posY+sizeY-ofsetY)){
					return true;
			}
		}else if(deg==1){
			if((mouseX>=posX-sizeY+ofsetY)&&(mouseY>=posY-ofsetX)&&(mouseX<=posX+ofsetY)&&(mouseY<=posY+sizeX-ofsetX)) {
				return true;
			}
		}else if(deg==2){
			if((mouseX>=posX-sizeX-ofsetX)&&(mouseY>=posY-sizeY+ofsetY)&&(mouseX<=posX+ofsetX)&&(mouseY<=posY+ofsetY)){
				return true;
			}
		}else if(deg==3){
			if((mouseX>=posX-ofsetY)&&(mouseY>=posY-sizeX+ofsetX)&&(mouseX<=posX-ofsetX+sizeY)&&(mouseY<=posY-ofsetY+sizeX)){
				return true;
			}
		}
			return false;
	}

	int serchPointX(int w,int h) {
		int f=0;
		int d2=0;
		for (int d=0 ; d<w ; d++) {
			for (int i=0 ; i<h ; i++){;
				color c = photo.get(d,i);
				if ((red(c)>240)&&(green(c)<=20)&&(blue(c)<=20)) {
					f++;
					if (f==1) {
						d2=d;
						return d;
		}}}}
		return d2;
	}

	int serchPointY(int w, int h) {
		int f=0;
		int i2=0;
		for (int d=0 ; d<w ; d++) {
			for (int i=0 ; i<h ; i++){
				color c = photo.get(d,i);
				if ((red(c)>240)&&(green(c)<=20)&&(blue(c)<=20)) {
					f++;
					if (f==1) {
						i2=i;
						return i;
		}}}}
		return i2;
	}

	void turn(int adeg){
		if(adeg==-1){
		}else{
			deg=adeg;
		}
	}

	void copyVariable(){
		copyPosX=posX;
		copyPosY=posY;
		copySizeX=sizeX;
		copySizeY=sizeY;
		copyOfX=ofsetX;
		copyOfY=ofsetY;
		copyDeg=deg;
	}
}
