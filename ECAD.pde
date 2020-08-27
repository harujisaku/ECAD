import java.util.Date;
import java.awt.event.MouseListener;
import java.awt.event.MouseEvent;
import java.awt.event.MouseWheelEvent;
import java.awt.event.MouseWheelListener;
import java.awt.Component;
import javax.swing.*;
PImage startPhoto;
int partId=-1,count=0,f=0,mouseOfX,mouseOfY,gridS=10,partPosX,partPosY,partDeg;
String path="",partPath,partGloup;
String[] fileNames,fileData;
static int selectId=-1,ofsetX,ofsetY,setDeg;
static boolean removeFlg,copyFlg,pasteFlg,saveFlg,loadFlg,changeFlg;
IntList selectIds = new IntList();
IntList partPosXs = new IntList();
IntList partPosYs = new IntList();
IntList partDegs = new IntList();
ArrayList<String> partPaths = new ArrayList<String>();
ArrayList<String> partgroup = new ArrayList<String>();
PartList pL;
Parts parts = new Parts();
Menu menu;
PImage boardImg = createImage(350,400,RGB);
PImage uraboardImg;
RemoveFileExtension ex= new RemoveFileExtension();
//
//
//
void setup(){
	size(600,400);
	startPhoto=loadImage("start.png");
	image(startPhoto,0,0);
	boardImg.loadPixels();
	for (int i = 0; i < boardImg.pixels.length; i++) {
		boardImg.pixels[i] = color(187,201,158);
	}
	boardImg.updatePixels();
	path = "C:\\Users\\haruj\\Documents\\ECAD\\parts\\";
	pL=new PartList(63,63,80,80,0,0,250,400,path);
	try {
		UIManager.setLookAndFeel("com.sun.java.swing.plaf.windows.WindowsLookAndFeel");
	} catch (Exception e) {
		e.printStackTrace();
	}
	pL.sortAll();
	setupComponent();
	thread("loadParts");
	// thread("loadPartsSub");
}

void draw(){
	if(count==2){
		count++;
		menu = new Menu(this);
		println(millis());
	}else if(count>=3){
		background(187,201,158);
		pL.scrool(ofsetX,ofsetY);
		pL.update(f);
		kopipe();
		rightClick();
		image(boardImg,250,0);
		moveHighlight();
		parts.redraw();
		file();
	}
}


void mousePressed(){
	if(mouseButton == LEFT){
		if(pL.getButton(f)==-1){
			for(int i=0;i<parts.getSize();i++){
				if(parts.isClick(i)){
					partId=i;
					setDeg=-1;
					mouseOfX=parts.getPosX(i)-mX();
					mouseOfY=parts.getPosY(i)-mY();
					break;
				}else{
					partId=-1;
					setDeg=-1;
					selectId=-1;
				}
			}
			if(partId==-1){
				selectIds.clear();
			}
		}else{
			File board=new File(pL.getPath(f));
			String boardPath= board.getParent();
			String boardName=board.getName();
			println(boardPath,path+"Board");
			if(boardPath.equals(path+"Board")){
				println("board!!");
				boardImg = loadImage(pL.getPath(f));
				uraboardImg =  loadImage(boardPath+"\\"+ex.removeFileExtension(boardName)+"_.bmp");
				// println(boardName);
				// println(boardPath+"\\"+ex.removeFileExtension(boardName)+"_.bmp");
			}else{
				parts.newPart(0,"dd",pL.getPath(f),mX(),mY());
				partId=parts.getSize()-1;
			}
		}
	}else if(mouseButton==RIGHT){
		for(int i=0;i<parts.getSize();i++){
			if(parts.isClick(i)==true){
				setDeg=-1;
				selectId=i;
				break;
			}else{
				setDeg=-1;
				selectId=-1;
				selectIds.clear();
			}
		}
	}
}

void mouseReleased(){
	if(partId!=-1){
		if(parts.isMove(partId,mX()+mouseOfX,mY()+mouseOfY)){
			selectId=partId;
			if(selectIds.hasValue(partId)==false&&keyCode==CONTROL&&keyPressed){
				selectIds.append(partId);
			}else{
				selectIds.clear();
				selectIds.append(partId);
			}
		}else{
			if(mX()<250){
				parts.remove(partId);
				partId=-1;
				selectId=-1;
				selectIds.clear();
			}else{
				parts.move(partId,mX()+mouseOfX,mY()+mouseOfY);
				selectId=-1;
				selectIds.clear();
			}
	}
	}
	partId=-1;
	mouseOfX=0;mouseOfY=0;
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
				parts.remove(selectId);
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
	pL.makeList();
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
			parts.remove(selectId);
			selectId=-1;
			selectIds.clear();
		}
		removeFlg=false;
	}else if(copyFlg){
		if(selectId!=-1){
			parts.copyVariable(selectId);
			partPosX=parts.partPosX;
			partPosY=parts.partPosY;
			partDeg=parts.partDeg;
			partPath=parts.partPath;
			partGloup=parts.partGloup;
		}
		copyFlg=false;
	}else if(pasteFlg){
			parts.newPart(partDeg,partGloup,partPath,mX(),mY());
		pasteFlg=false;
	}
}

void rightClick(){
	for(int i=0;i<parts.getSize();i++){
		if(selectId==i){
			if(setDeg!=-1){
				parts.turn(i,setDeg);
				setDeg=-1;
				selectId=-1;
				selectIds.clear();
			}
		}
		parts.redraw(i);
	}
}

void moveHighlight(){
	if(partId!=-1){
		fill(255,255,255,0);
		if(parts.getDeg(partId)==0){
			rect(mX()-parts.getOfsetX(partId)+mouseOfX,mY()+mouseOfY-parts.getOfsetY(partId),parts.getSizeX(partId),parts.getSizeY(partId));
		}else if(parts.getDeg(partId)==1){
			rect(mX()+parts.getOfsetY(partId)+mouseOfX-parts.getSizeY(partId),mY()-parts.getOfsetX(partId)+mouseOfY,parts.getSizeY(partId),parts.getSizeX(partId));
		}else if(parts.getDeg(partId)==2){
			rect(mX()-parts.getSizeX(partId)+parts.getOfsetX(partId)+mouseOfX,mY()-parts.getSizeY(partId)+parts.getOfsetY(partId)+mouseOfY,parts.getSizeX(partId),parts.getSizeY(partId));
		}else if(parts.getDeg(partId)==3){
			rect(mX()-parts.getOfsetY(partId)+mouseOfX,mY()-parts.getSizeX(partId)+parts.getOfsetX(partId)+mouseOfY,parts.getSizeY(partId),parts.getSizeX(partId));
		}
		fill(255,255,255);
	}
}

void file(){
	if (saveFlg) {
		
	}else if (loadFlg) {
		
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

static public class RemoveFileExtension {
	RemoveFileExtension(){}
	public String removeFileExtension(String filename) {
		int lastDotPos = filename.lastIndexOf('.');

		if (lastDotPos == -1) {
			return filename;
		} else if (lastDotPos == 0) {
			return filename;
		} else {
			return filename.substring(0, lastDotPos);
		}
	}
}