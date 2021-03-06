class PartList {
	int partSizeX,partSizeY,boxSizeX,boxSizeY,listPosX,listPosY,listSizeX,listSizeY,scroolX,scroolY;
	String directory,board,printText;
	String[] fileNames;
	ArrayList<ImageList> iL = new ArrayList<ImageList>();
	PartList(int _partSizeX,int _partSizeY,int _boxSizeX,int _boxSizeY,int _listPosX,int _listPosY,int _listSizeX,int _listSizeY,String _directory){
		partSizeX=_partSizeX;
		partSizeY=_partSizeY;
		boxSizeX=_boxSizeX;
		boxSizeY=_boxSizeY;
		listPosX=_listPosX;
		listPosY=_listPosY;
		listSizeX=_listSizeX;
		listSizeY=_listSizeY;
		directory=_directory;
		fileNames=listFileNames(directory);
		if(fileNames==null){
			fileNames= new String[0];
		}
	}

	void sortDir(){
		java.util.Arrays.sort(fileNames);
	}

	void sortAll(){
		if(fileNames!=null){
			java.util.Arrays.sort(fileNames);
		}
	}
	int getSize(){
		return iL.size();
	}
	void makeList(){
		for(int i=0,len=fileNames.length;i<len;i++){
			String name=fileNames[i];
				println("fileNames[i]: "+name);
				String fileName=path+name;
				iL.add(new ImageList(partSizeX,partSizeY,boxSizeX,boxSizeY,listPosX,listPosY,listSizeX,listSizeY,fileName));
		}
	}

	void update(){
		for (int i = 0,len=iL.size(); i < len; ++i) {
			iL.get(i).redraw();
		}
	}

	void update(int a){
		if(a<0||a>iL.size()-1){
			return;
		}
		iL.get(a).redraw();
	}

	int getButton(int a){
		if(a<0||a>iL.size()-1){
			return -1;
		}
		return iL.get(a).pushButton();
	}

	String getPath(int a){
		return iL.get(a).pushPath(getButton(a));
	}
	String getName(int a){
		return fileNames[a];
	}
	void scrool(int _scroolX,int _scroolY){
		scroolX=_scroolX;
		scroolY=_scroolY;
		for (int i = 0,len=iL.size(); i <len; ++i) {
			iL.get(i).scrool(scroolX,scroolY);
		}
	}

	String[] listFileNames(String dir){
		File file = new File(dir);
		if(file.isDirectory()){
			String names[] = file.list();
			return names;
		}else{
			return null;
		}
	}
	void resizeList(int sizeX,int sizeY){
		listSizeX=sizeX;
		listSizeY=sizeY;
		for (int i = 0,len=iL.size(); i < len; ++i) {
			iL.get(i).resize(listSizeX,listSizeY);
		}
	}
}
