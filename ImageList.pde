class ImageList{
int kazu,tasu,k,l_w,w,h,s_w,s_h,ofset_x,ofset_y,file_num,pos_x,pos_y,size_x,size_y;
String folder;
String extensions = ".bmp";
File[] files;
String[] filesbmp;
String[] filesname;
ArrayList<PImage>images=new ArrayList<PImage>();
	ImageList(int img_w,int img_h,int box_w,int box_h,int p_x,int p_y,int s_x,int s_y,String directory){
		remake(img_w,img_h,box_w,box_h,p_x,p_y,s_x,s_y,directory);
	}

void redraw(){
		rect(pos_x,pos_y,size_x,size_y);
			k=0;
			kazu=file_num;
			if (kazu%l_w!=0){
				tasu=1;
			}
			for(int i=0;i<kazu/l_w;i++){
				for(int j=0;j<l_w;j++){
					if ((pos_y<=i*s_h+ofset_y+pos_y+h)&&(pos_x<=j*s_w+ofset_x+pos_x+w)&&(pos_y+size_y>=i*s_h+ofset_y+pos_y)&&(pos_x+size_x>=j*s_w+ofset_x+pos_x)){
						rect(j*s_w+ofset_x+pos_x,i*s_h+ofset_y+pos_y,w,h);
						image(images.get(k),j*s_w+ofset_x+pos_x,i*s_h+ofset_y+pos_y);
						fill(0);
						text(filesname[k],j*s_w+ofset_x+pos_x+w-w/2,i*s_h+ofset_y+pos_y+h+10);
						fill(255);
					}
					k++;
				}
			}
			for(int n=0;n<kazu%l_w;n++){
				if ((pos_y<=kazu/l_w*s_h+ofset_y+pos_y+h)&&(pos_x<=n*s_w+ofset_x+pos_x+w)&&(pos_y+size_y>=kazu/l_w*s_h+ofset_y+pos_y)&&(pos_x+size_x>=n*s_w+ofset_x+pos_x)){
				rect(n*s_w+ofset_x+pos_x,kazu/l_w*s_h+ofset_y+pos_y,w,h);
				image(images.get(k),n*s_w+ofset_x+pos_x,kazu/l_w*s_h+ofset_y+pos_y);
			}
				k++;
			}
	}
	void move(int p_x,int p_y){
		pos_x=p_x;
		pos_y=p_y;
	}

	void scrool(int of_x,int of_y){
		ofset_x=of_x;
		ofset_y=of_y;
	}

void remake(int img_w,int img_h,int box_w,int box_h,int p_x,int p_y,int s_x,int s_y,String directory){
	images.clear();
	w=img_w;
	h=img_h;
	s_w=box_w;
	s_h=box_h;
	pos_x=p_x;
	pos_y=p_y;
	size_x=s_x;
	size_y=s_y;
	l_w=size_x/box_w;
	int a=0;
	textAlign(CENTER);
	println(directory);
	files = listFiles(directory);
	println(files.length);
	filesbmp = new String[files.length];
	filesname = new String[files.length];
	for(int i= 0; i< files.length; i++){
		if(files[i].getPath().endsWith("_"+extensions)){
		}else if(files[i].getPath().endsWith(extensions)){
			filesbmp[a] = files[i].getAbsolutePath();
			filesname[a] = files[i].getName();
			PImage img = loadImage(filesbmp[a]);
			if ((img.width >= w) || (img.height >= h)) {
				if (img.width >= img.height){
					img.resize(w,0);
				}else{
					img.resize(0,h);
				}
			}
			images.add(img);
			a++;
			}
		}
		file_num=a;
	}

	int pushButton(){
		int l=-1;
		int g=0;
		for(int i=0;i<kazu/l_w;i++){
			for(int j=0;j<l_w;j++){
				if	((mouseX>=j*s_w+ofset_x+pos_x)&&(mouseY>=i*s_h+ofset_y+pos_y)&&(mouseX<=j*s_w+ofset_x+pos_x+w)&&(mouseY<=i*s_h+ofset_y+pos_y+h)&&(mouseX>=pos_x)&&(mouseY>=pos_y)&&(mouseX<=pos_x+size_x)&&(mouseY<=pos_y+size_y)){
					l=g;
				}
				g++;
			}
		}
		for(int n=0;n<kazu%l_w;n++){
			if ((mouseX>=n*s_w+ofset_x+pos_x)&&(mouseY>=kazu/l_w*s_h+ofset_y+pos_y)&&(mouseX<=n*s_w+ofset_x+pos_x+w)&&(mouseY<=kazu/l_w*s_h+ofset_y+pos_y+h)&&(mouseX>=pos_x)&&(mouseY>=pos_y)&&(mouseX<=pos_x+size_x)&&(mouseY<=pos_y+size_y)){
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
