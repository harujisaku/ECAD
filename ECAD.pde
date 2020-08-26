import java.util.Date;
import java.awt.event.MouseListener;
import java.awt.event.MouseEvent;
import java.awt.event.MouseWheelEvent;
import java.awt.event.MouseWheelListener;
import java.awt.Component;

PImage startPhoto;
int partId=-1,count=0,f=0,mouseOfX,mouseOfY,gridS=10,partPosX,partPosY,partDeg;
String path="",partPath,partGloup;
String[] fileNames;
static int selectId=-1,ofsetX,ofsetY,setDeg;
static boolean removeFlg,copyFlg,pasteFlg;
ArrayList<Part> part = new ArrayList<Part>();
// ArrayList<ImageList> iL = new ArrayList<ImageList>();
IntList selectIds = new IntList();
IntList partPosXs = new IntList();
IntList partPosYs = new IntList();
IntList partDegs = new IntList();
ArrayList<String> partPaths = new ArrayList<String>();
ArrayList<String> partgroup = new ArrayList<String>();
PartList parts;
Menu menu;

//
//
//
void setup(){
	size(600,400);
	startPhoto=loadImage("start.png");
	image(startPhoto,0,0);
	path = "C:/Users/haruj/Documents/ECAD/parts/";
	parts=new PartList(63,63,80,80,0,0,250,400,path);
	// fileNames = listFileNames(path);
	parts.sortAll();
	// java.util.Arrays.sort(fileNames);
	setupComponent();
	thread("loadParts");
	// thread("loadPartsSub");
}

void draw(){
	if(count==2){
		count++;
		menu = new Menu(this);
		//println(millis());
	}else if(count>=3){
		background(187,201,158);
		parts.scrool(ofsetX,ofsetY);
		parts.update(f);
		kopipe();
		rightClick();
		moveHighlight();
		for(int k=part.size()-1;k>=0;k--){
			//println(k);
			part.get(k).redraw_parts();
		}
		//println(part.size());
	}
}


void mousePressed(){
	if(mouseButton == LEFT){
		if(parts.getButton(f)==-1){
			for(int i=0;i<part.size();i++){
				if(part.get(i).poscheck()==true){
					partId=i;
					setDeg=-1;
					mouseOfX=part.get(i).pos_x-mX();
					mouseOfY=part.get(i).pos_y-mY();
					break;
				}else{
					partId=-1;
					setDeg=-1;
					selectId=-1;
					//println("variables123456789");
					// selectIds.clear();
				}
			}
			if(partId==-1){
				selectIds.clear();
			}
		}else{
			part.add(new Part());
			part.get(part.size()-1).new_parts(0,"dd",parts.getPath(f),mX(),mY());
			partId=part.size()-1;
		}
	}else if(mouseButton==RIGHT){
		for(int i=0;i<part.size();i++){
			if(part.get(i).poscheck()==true){
				setDeg=-1;
				selectId=i;
				break;
			}else{
				// partId=-1;
				setDeg=-1;
				selectId=-1;
				selectIds.clear();
			}
		}
	}
}

void mouseReleased(){
	if(partId!=-1){
		//println("variables2");
		//println(part.get(partId).isNoMove);
		part.get(partId).moveCheck(mX()+mouseOfX,mY()+mouseOfY);
		if(part.get(partId).isNoMove==true){
			selectId=partId;
			//println(selectIds,keyCode,keyPressed);
			if(selectIds.hasValue(partId)==false&&keyCode==CONTROL&&keyPressed){
				selectIds.append(partId);
				//println(selectIds);
			}else{
				selectIds.clear();
				selectIds.append(partId);
				//println("variablesaaaaaaaaaaaa");
			}
			//println(selectId);
		}else{
		part.get(partId).move_parts(mX()+mouseOfX,mY()+mouseOfY);
		selectId=-1;
		selectIds.clear();
		// //println("variables4");
	}
	}
	partId=-1;
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

void keyPressed(){
	switch(key){
		case '1':
			f=0;
			break;
		case '2':
			f=1;
			break;
		case '3':
			f=2;
			break;
		case '4':
			f=3;
			break;
		case '5':
			f=4;
			break;
		case '6':
			f=5;
			break;
		case '7':
			f=6;
			break;
		case '8':
			f=7;
			break;
		case '9':
			f=8;
			break;
		case '0':
			f=10;
			break;
		case '￿':
			break;
		case '?':
			break;
		case '':
		copyFlg=true;
			break;
		case '':
		pasteFlg=true;
			break;
		case '':
			if(selectId!=-1){
				part.remove(selectId);
			}
			selectId=-1;
			selectIds.clear();
			removeFlg=false;
			break;
		default:
			f=18;
			break;
	}
}

int mX(){
	int p;
	p = mouseX-mouseX%gridS;
	return p;
}

int mY(){
	int p;
	p = mouseY-mouseY%gridS;
	return p;
}

void setupComponent(){
	Component component = (Component) this.surface.getNative();
	component.addMouseListener(new Menu(this));
	component.addMouseWheelListener(new mouseWheel());
}

void loadParts(){
	parts.makeList();
	count+=2;
}
//
// void loadPartsSub(){
//	 for(int j=10;j<fileNames.length-9;j++){
//		 String fileName=path+fileNames[j];
//		 iL2.add(new imageList());
//		 iL2.get(j-10).remake(63,63,80,80,0,0,250,400,fileName);
//	 }
//	 count+=1;
// }

void kopipe(){
	if(removeFlg){
		if(selectId!=-1){
			part.remove(selectId);
			selectId=-1;
			selectIds.clear();
		}
		removeFlg=false;
	}else if(copyFlg){
		if(selectId!=-1){
			part.get(selectId).copyVariable();
			partPosX=part.get(selectId).copyPosX;
			partPosY=part.get(selectId).copyPosY;
			partDeg=part.get(selectId).copyDeg;
			partPath=part.get(selectId).copyPath;
			partGloup=part.get(selectId).copyGloup;
		}
		copyFlg=false;
	}else if(pasteFlg){
			part.add(new Part());
			part.get(part.size()-1).new_parts(partDeg,partGloup,partPath,mX(),mY());
			// partId=part.size()-1;
		pasteFlg=false;
	}
}

void rightClick(){
	for(int i=0;i<part.size();i++){
		if(selectId==i){
			if(setDeg!=-1){
				part.get(i).turn(setDeg);
				setDeg=-1;
				selectId=-1;
				selectIds.clear();
			}
		}
		part.get(i).redraw_parts();
	}
}

void moveHighlight(){
	if(partId!=-1){
		fill(255,255,255,0);
		if(part.get(partId).deg==0){
			rect(mX()-part.get(partId).ofset_x+mouseOfX,mY()+mouseOfY-part.get(partId).ofset_y,part.get(partId).size_x,part.get(partId).size_y);
		}else if(part.get(partId).deg==1){
			rect(mX()+part.get(partId).ofset_y+mouseOfX-part.get(partId).size_y,mY()-part.get(partId).ofset_x+mouseOfY,part.get(partId).size_y,part.get(partId).size_x);
		}else if(part.get(partId).deg==2){
			rect(mX()-part.get(partId).size_x+part.get(partId).ofset_x+mouseOfX,mY()-part.get(partId).size_y+part.get(partId).ofset_y+mouseOfY,part.get(partId).size_x,part.get(partId).size_y);
		}else if(part.get(partId).deg==3){
			rect(mX()-part.get(partId).ofset_y+mouseOfX,mY()-part.get(partId).size_x+part.get(partId).ofset_x+mouseOfY,part.get(partId).size_y,part.get(partId).size_x);
		}
		fill(255,255,255);
	}
}

static public class mouseWheel implements MouseWheelListener{
	mouseWheel(){}
	@Override
	public void mouseWheelMoved(MouseWheelEvent e){
		if(e.getWheelRotation()==-1){
			ofsetY+=15;
		}else if(e.getWheelRotation()==1){
			ofsetY-=15;
		}
	}
}
