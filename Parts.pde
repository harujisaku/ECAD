class Parts{
	ArrayList<Part> part = new ArrayList<Part>();
	int partPosX,partPosY,copyDeg;
	String copyPath,copyGloup;
	Parts(){
	}

	void newPart(String gloup,String path,int posX,int posY){
		part.add(new Part(0,gloup,path,posX,posY));
	}

	int getPosX(int index){
		return part.get(index).pos_x;
	}
	int getPosY(int index){
		return part.get(index).pos_y;
	}

	int getSize(){
		return part.size();
	}

	void trun(int index,int deg){
		part.get(index).turn(deg);
	}

	boolean isClick(int index){
		return part.get(index).posCheck();
	}

	boolean isMove(int index,int posX,int posY){
		return part.get(index).moveCheck(posX,posY);
	}

	void move(int index,int posX,int posY){
		part.get(index).move_parts(posX,posY);
	}

	void redraw(){
		for(int k=part.size()-1;k>=0;k--){
			part.get(k).redraw_parts();
		}
	}

	void copyVariable(int index){
		part.get(index).copyVariable();
		partPosX=part.get(index).copyPosX;
		partPosY=part.get(index).copyPosY;
		partDeg=part.get(index).copyDeg;
		partPath=part.get(index).copyPath;
		partGloup=part.get(index).copyGloup;
	}
}