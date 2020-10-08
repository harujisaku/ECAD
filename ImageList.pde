class ImageList{
int kazu,tasu,k,listWidth,imageWidth,imageHeight,boxWidth,boxHeight,ofsetX,ofsetY,fileLength,listPosX,listPosY,listSizeX,listSizeY;
String folder;
String extensions = ".bmp";
File[] files;
String[] filesbmp;
String[] filesname;
ArrayList<PImage>images=new ArrayList<PImage>();
	ImageList(int _imageWidth,int _imageHeight,int _boxWidth,int _boxHeight,int _listPosX,int _listPosY,int _listSizeX,int _listSizeY,String directory){
		remake(_imageWidth,_imageHeight,_boxWidth,_boxHeight,_listPosX,_listPosY,_listSizeX,_listSizeY,directory);
	}

void redraw(){
		rect(listPosX,listPosY,listSizeX,listSizeY);
			k=0;
			kazu=fileLength;
			if (kazu%listWidth!=0){
				tasu=1;
			}
			for(int i=0,len=kazu/listWidth;i<len;i++){
				for(int j=0;j<listWidth;j++){
					if ((listPosY<=i*boxHeight+ofsetY+listPosY+imageHeight)&&(listPosX<=j*boxWidth+ofsetX+listPosX+imageWidth)&&(listPosY+listSizeY>=i*boxHeight+ofsetY+listPosY)&&(listPosX+listSizeX>=j*boxWidth+ofsetX+listPosX)){
						rect(j*boxWidth+ofsetX+listPosX,i*boxHeight+ofsetY+listPosY,imageWidth,imageHeight);
						image(images.get(k),j*boxWidth+ofsetX+listPosX,i*boxHeight+ofsetY+listPosY);
						fill(0);
						text(filesname[k],j*boxWidth+ofsetX+listPosX+imageWidth-imageWidth/2,i*boxHeight+ofsetY+listPosY+imageHeight+10);
						fill(255);
					}
					k++;
				}
			}
			for(int n=0,len=kazu%listWidth;n<len;n++){
				if ((listPosY<=kazu/listWidth*boxHeight+ofsetY+listPosY+imageHeight)&&(listPosX<=n*boxWidth+ofsetX+listPosX+imageWidth)&&(listPosY+listSizeY>=kazu/listWidth*boxHeight+ofsetY+listPosY)&&(listPosX+listSizeX>=n*boxWidth+ofsetX+listPosX)){
				rect(n*boxWidth+ofsetX+listPosX,kazu/listWidth*boxHeight+ofsetY+listPosY,imageWidth,imageHeight);
				image(images.get(k),n*boxWidth+ofsetX+listPosX,kazu/listWidth*boxHeight+ofsetY+listPosY);
			}
				k++;
			}
	}
	void move(int _listPosX,int _listPosY){
		listPosX=_listPosX;
		listPosY=_listPosY;
	}
	void resize(int _listSizeX,int _listSizeY){
		listSizeX=_listSizeX;
		listSizeY=_listSizeY;
	}
	void scrool(int _ofsetX,int _ofsetY){
		ofsetX=_ofsetX;
		ofsetY=_ofsetY;
	}

void remake(int _imageWidth,int _imageHeight,int _boxWidth,int _boxHeight,int _listPosX,int _listPosY,int _listSizeX,int _listSizeY,String directory){
	images.clear();
	imageWidth=_imageWidth;
	imageHeight=_imageHeight;
	boxWidth=_boxWidth;
	boxHeight=_boxHeight;
	listPosX=_listPosX;
	listPosY=_listPosY;
	listSizeX=_listSizeX;
	listSizeY=_listSizeY;
	listWidth=listSizeX/_boxWidth;
	int a=0;
	textAlign(CENTER);
	println(directory);
	files = listFiles(directory);
	println(files.length);
	filesbmp = new String[files.length];
	filesname = new String[files.length];
	for(int i= 0,len=files.length; i<len; i++){
		if(files[i].getPath().endsWith("_"+extensions)){
		}else if(files[i].getPath().endsWith(extensions)){
			filesbmp[a] = files[i].getAbsolutePath();
			filesname[a] = files[i].getName();
			PImage img = loadImage(filesbmp[a]);
			if ((img.width >= imageWidth) || (img.height >= imageHeight)) {
				if (img.width >= img.height){
					img.resize(imageWidth,0);
				}else{
					img.resize(0,imageHeight);
				}
			}
			images.add(img);
			a++;
			}
		}
		fileLength=a;
	}

	int pushButton(){
		int l=-1;
		int g=0;
		for(int i=0,len=kazu/listWidth;i<len;i++){
			for(int j=0;j<listWidth;j++){
				if	((mouseX>=j*boxWidth+ofsetX+listPosX)&&(mouseY>=i*boxHeight+ofsetY+listPosY)&&(mouseX<=j*boxWidth+ofsetX+listPosX+imageWidth)&&(mouseY<=i*boxHeight+ofsetY+listPosY+imageHeight)&&(mouseX>=listPosX)&&(mouseY>=listPosY)&&(mouseX<=listPosX+listSizeX)&&(mouseY<=listPosY+listSizeY)){
					l=g;
				}
				g++;
			}
		}
		for(int n=0,len=kazu%listWidth;n<len;n++){
			if ((mouseX>=n*boxWidth+ofsetX+listPosX)&&(mouseY>=kazu/listWidth*boxHeight+ofsetY+listPosY)&&(mouseX<=n*boxWidth+ofsetX+listPosX+imageWidth)&&(mouseY<=kazu/listWidth*boxHeight+ofsetY+listPosY+imageHeight)&&(mouseX>=listPosX)&&(mouseY>=listPosY)&&(mouseX<=listPosX+listSizeX)&&(mouseY<=listPosY+listSizeY)){
				l=g;
			}
			g++;
		}
		return l;
	}

	String pushPath(int a){
		return filesbmp[a];
	}
}
