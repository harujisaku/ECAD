class Parts{
	ArrayList<Part> part = new ArrayList<Part>();
	int partPosX,partPosY,partDeg;
	String partPath,partGloup;
	Parts(){
	}

	int newPart(int deg,String gloup,String path,int posX,int posY){
		if (path!=null) {
			println(path);
			part.add(new Part(deg,gloup,path,posX,posY));
		return 0;
		}else{
			return -1;
		}
	}

	int getPosX(int index){
		return part.get(index).posX;
	}
	int getPosY(int index){
		return part.get(index).posY;
	}

	int getSize(){
		return part.size();
	}

	void turn(int index,int deg){
		part.get(index).turn(deg);
	}

	boolean isClick(int index){
		return part.get(index).posCheck();
	}

	boolean isMove(int index,int posX,int posY){
		return part.get(index).moveCheck(posX,posY);
	}

	void move(int index,int posX,int posY){
		part.get(index).moveParts(posX,posY);
	}

	int getDeg(int index){
		return part.get(index).deg;
	}

	int getSizeX(int index){
		return part.get(index).sizeX;
	}

	int getSizeY(int index){
		return part.get(index).sizeY;
	}

	int getOfsetX(int index){
		return part.get(index).ofsetX;
	}

	int getOfsetY(int index){
		return part.get(index).ofsetY;
	}

	void redraw(){
		for(int k=part.size()-1;k>=0;k--){
			part.get(k).redrawParts();
		}
	}
	void redraw(int index){
		part.get(index).redrawParts();
	}

	void copyVariable(int index){
		part.get(index).copyVariable();
		partPosX=part.get(index).copyPosX;
		partPosY=part.get(index).copyPosY;
		partDeg=part.get(index).copyDeg;
		partPath=part.get(index).copyPath;
		partGloup=part.get(index).copyGloup;
	}

	void remove(int index){
		part.remove(index);
	}
}
