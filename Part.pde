// class Part{
// 	int sizeX,sizeY,posX,posY,deg,ofsetX,ofsetY,redPointX,redPointY;
// 	boolean isNoMove=false;
// 	PImage image;
// 	Part(int _deg,int _posX,int _posY,int _sizeX,int _sizeY,int _ofsetX,int _ofsetY,PImage _image){
// 		newParts(_deg,_posX,_posY,_sizeX,_sizeY,_ofsetX,_ofsetY,_image);
// 	}
// 	void newParts(int _deg,int _posX,int _posY,int _sizeX,int _sizeY,int _ofsetX,int _ofsetY,PImage _image) {
// 		posX=_posX;
// 		posY=_posY;
// 		sizeX=_sizeX;
// 		sizeY=_sizeY;
// 		ofsetX=_ofsetX;
// 		ofsetY=_ofsetY;
//
// 		image= _ image;
//
// 		if(_deg!=-1){
// 			deg=_deg;
// 		}
// 	}
//
// 	void moveParts(int _posX,int _posY){
// 		isNoMove=false;
// 		if(posX==_posX&&posY==_posY){
// 			isNoMove=true;
// 		}
// 		posX=_posX;
// 		posY=_posY;
// 	}
//
// 	boolean moveCheck(int _posX,int _posY){
// 		isNoMove=false;
// 		if(posX==_posX&&posY==_posY){
// 			isNoMove=true;
// 		}
// 		return isNoMove;
// 	}
//
// 	boolean posCheck(){
// 		if (deg==0){
// 			if((mouseX>=posX-ofsetX)&&(mouseY>=posY-ofsetY)&&(mouseX<=posX+sizeX-ofsetX)&&(mouseY<=posY+sizeY-ofsetY)){
// 					return true;
// 			}
// 		}else if(deg==1){
// 			if((mouseX>=posX-sizeY+ofsetY)&&(mouseY>=posY-ofsetX)&&(mouseX<=posX+ofsetY)&&(mouseY<=posY+sizeX-ofsetX)) {
// 				return true;
// 			}
// 		}else if(deg==2){
// 			if((mouseX>=posX-sizeX-ofsetX)&&(mouseY>=posY-sizeY+ofsetY)&&(mouseX<=posX+ofsetX)&&(mouseY<=posY+ofsetY)){
// 				return true;
// 			}
// 		}else if(deg==3){
// 			if((mouseX>=posX-ofsetY)&&(mouseY>=posY-sizeX+ofsetX)&&(mouseX<=posX-ofsetX+sizeY)&&(mouseY<=posY-ofsetY+sizeX)){
// 				return true;
// 			}
// 		}
// 		return false;
// 	}
//
// 	void turn(int adeg){
// 		if(adeg!=-1){
// 			deg=adeg;
// 		}
// 	}
// }
