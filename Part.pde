class Part{
	int size_x,size_y,pos_x,pos_y,deg,ofset_x,ofset_y;
	int copySizeX,copySizeY,copyPosX,copyPosY,copyDeg,copyOfX,copyOfY;
	String copyPath,copyGloup;
	boolean isNoMove=false;
	PImage photo;
	Part(){
	}

	void new_parts(int _deg,String gloup,String path,int ps_x,int ps_y) {
	photo = loadImage(path);
	pos_x=ps_x;
	pos_y=ps_y;
	copyPath=path;
	copyGloup=gloup;
	size_x=photo.width;
	size_y=photo.height;
	ofset_x=serch_point_x(photo.width,photo.height);
	ofset_y=serch_point_y(photo.width,photo.height);
		if(_deg!=-1){
			deg=_deg;
		}
		// redraw_parts();
	}

	void move_parts(int ps_x,int ps_y){
	if(pos_x==ps_x&&pos_y==ps_y){
		isNoMove=true;
	}else{
		isNoMove=false;
	}
	pos_x=ps_x;
	pos_y=ps_y;
		// redraw_parts();
	}
	void moveCheck(int psX,int psY){
	if(pos_x==psX&&pos_y==psY){
		isNoMove=true;
	}else{
		isNoMove=false;
	}
	}
	void redraw_parts() {
		pushMatrix();
		translate(pos_x,pos_y);
		rotate(radians(deg*90));
	image(photo,0-ofset_x,0-ofset_y);
		popMatrix();
	}

	void print_variable() {
		println(deg);
	println(pos_x);
	println(pos_y);
	println(ofset_x);
	println(ofset_y);
	}

	boolean _poscheck() {
		if ((deg==0)||(deg==2)){
		if ((mouseX>=pos_x-ofset_x)&&(mouseY>=pos_y-ofset_y)&&(mouseX<=pos_x+size_x-ofset_x)&&(mouseY<=pos_y+size_y-ofset_y)){
			return true;
		}else{
			return false;
		}
		}else{
			if ((mouseX>=pos_x+size_x/2-size_y/2-ofset_x)&&(mouseY>=pos_y+size_y/2-size_x/2-ofset_y)&&(mouseX<=pos_x+size_x/2+size_y/2-ofset_x)&&(mouseY<=pos_y+size_y/2+size_x/2-ofset_y)){
				return true;
			}else{
				return false;
			}
		}
	}

	boolean poscheck(){
		if (deg==0){
			if((mouseX>=pos_x-ofset_x)&&(mouseY>=pos_y-ofset_y)&&(mouseX<=pos_x+size_x-ofset_x)&&(mouseY<=pos_y+size_y-ofset_y)){
					return true;
			}else{
					return false;
			}
		}else if(deg==1){
			if((mouseX>=pos_x-size_y+ofset_y)&&(mouseY>=pos_y-ofset_x)&&(mouseX<=pos_x+ofset_y)&&(mouseY<=pos_y+size_x-ofset_x)) {
				return true;
			}else{
				return false;
			}
		}else if(deg==2){
			if((mouseX>=pos_x-size_x-ofset_x)&&(mouseY>=pos_y-size_y+ofset_y)&&(mouseX<=pos_x+ofset_x)&&(mouseY<=pos_y+ofset_y)){
				return true;
			}else{
				return false;
			}
		}else if(deg==3){
			if((mouseX>=pos_x-ofset_y)&&(mouseY>=pos_y-size_x+ofset_x)&&(mouseX<=pos_x-ofset_x+size_y)&&(mouseY<=pos_y-ofset_y+size_x)){
				return true;
			}else{
				return false;
			}
		}else{
			return false;
		}
	}


	int serch_point_x(int w,int h) {
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

	int serch_point_y(int w, int h) {
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
		copyPosX=pos_x;
		copyPosY=pos_y;
		copySizeX=size_x;
		copySizeY=size_y;
		copyOfX=ofset_x;
		copyOfY=ofset_y;
		copyDeg=deg;
	}

}
