class Part{
	int sizeX,sizeY,posX,posY,deg,ofsetX,ofsetY,redPointX,redPointY;
	boolean isNoMove=false;
	Part(int _deg,int _posX,int _posY,int _sizeX,int _sizeY,int _ofsetX,int _ofsetY){
		newParts(_deg,_posX,_posY,_sizeX,_sizeY,_ofsetX,_ofsetY);
	}
	void newParts(int _deg,int _posX,int _posY,int _sizeX,int _sizeY,int _ofsetX,int _ofsetY) {
		posX=_posX;
		posY=_posY;
		sizeX=_sizeX;
		sizeY=_sizeY;
		ofsetX=_ofsetX;
		ofsetY=_ofsetY;
		if(_deg!=-1){
			deg=_deg;
		}
	}

	void moveParts(int _posX,int _posY){
		isNoMove=false;
		if(posX==_posX&&posY==_posY){
			isNoMove=true;
		}
		posX=_posX;
		posY=_posY;
	}

	boolean moveCheck(int _posX,int _posY){
		isNoMove=false;
		if(posX==_posX&&posY==_posY){
			isNoMove=true;
		}
		return isNoMove;
	}

	void turn(int adeg){
		if(adeg!=-1){
			deg=adeg;
		}
	}
}
