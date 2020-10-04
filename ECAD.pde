import java.util.Date;
import java.awt.event.MouseListener;
import java.awt.event.MouseEvent;
import java.awt.event.MouseWheelEvent;
import java.awt.event.MouseWheelListener;
import java.awt.Component;
import javax.swing.*;
import processing.awt.*;
import java.awt.*;
import java.awt.event.*;
import javax.swing.*;
PImage startPhoto;
int partId=-1,count=0,f=0,mouseOfX,mouseOfY,gridS=10,partPosX,partPosY,partDeg,mode=0,lineSX,lineSY,lineEX,lineEY;
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
Button[] partsButton = new Button[40];
Button[] modeButton = new Button[3];
Wiring w = new Wiring(color(255,0,0));

void setup(){
	size(600,400);
	startPhoto=loadImage("start"+int(random(1)+1)+".png");
	image(startPhoto,0,0,600,400);
	boardImg.loadPixels();
	for (int i = 0,len=boardImg.pixels.length; i < len; i++) {
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
}

void draw(){
	if(count==2){
		count++;
		menu = new Menu(this);
			int j=0,k=0,sx,sy;
			sx=pL.listSizeX;
			sy=pL.listSizeY;
		for (int i = 0,len=pL.getSize(); i < len; ++i) {
			if(i*25-25*k==sx||(i*25+3-25*k<=sx&&i*25-3-25*k>=sx)){
				j++;
				k=i;
			}
		partsButton[i] = new Button(this,pL.getName(i),i*25-25*k,400+j*25,25,25);
		}
		pL.resizeList(sx,sy-j*25-25);
			sy=pL.listSizeY;
		int l=0,a=0;
		for (int i = 0,len=pL.getSize(); i < len; ++i) {
			if(i*25-25*a==sx||(i*25+3-25*a<=sx&&i*25-3-25*a>=sx)){
				l++;
				a=i;
			}
		partsButton[i].move(i*25-25*a,sy+l*25);
		}
		buttonSetup();
		surface.setResizable(true);
	}else if(count>=3){
		if (width<600||height<400){
			surface.setSize(600,400);
		}
		background(187,201,158);
		stroke(0);
		pL.scrool(ofsetX,ofsetY);
		pL.update(f);
		kopipe();
		rightClick();
		buttonCheck();
		image(boardImg,250,0);
		moveHighlight();
		parts.redraw();
		file();
		fill(0);
		line(251,0,251,height);
		line(251,353,width,353);
		fill(255);
		w.update();
	}
}


void mousePressed(){
	if(mode==0){
		if(mouseButton == LEFT){
			if(pL.getButton(f)==-1){
				select();
			}else{
				makeParts();
			}
		}else if(mouseButton==RIGHT){
			for(int i=0,len=parts.getSize();i<len;i++){
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
	}else if(mode==1){
		lineSX=mX();
		lineSY=mY();
	}else if(mode==2){

	}
}

void mouseReleased(){
	if(mode==0){
		moveParts();
	}else if(mode==1){
		if (lineSX==mX()&&lineSY==mY()){
			return;
		}
		w.addWire(lineSX,lineSY,mX(),mY());
		w.groupWire();
		println("ECAD",lineSX,lineSY,mX(),mY());
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

void keyPressed(){
	switch(key){
			case 's':
				PImage img = createImage(width, 353, RGB);
				loadPixels();
				img.pixels = pixels;
				img.updatePixels();
				img = img.get(252, 0, width, 353);
				img.save("drawing.png");
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
			break;
	}
}

void buttonCheck(){
	for (int i = 0,len=pL.getSize(); i < len; ++i) {
		if(partsButton[i].clicked){
			f=i;
			ofsetY=0;
			partsButton[i].clicked=false;
		}
	}
	for(int i=0,len=modeButton.length;i<len;++i){
		if(modeButton[i].clicked){
			mode=i;
			modeButton[i].clicked=false;
		}
	}
}

int mX(){
	return mouseX-mouseX%gridS;
}

int mY(){
	return mouseY-mouseY%gridS;
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
void select(){
	for(int i=0,len=parts.getSize();i<len;i++){
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
}

void makeParts(){
	File board=new File(pL.getPath(f));
	String boardPath= board.getParent();
	String boardName=board.getName();
	if(boardPath.equals(path+"Board")){
		boardImg = loadImage(pL.getPath(f));
		uraboardImg =  loadImage(boardPath+"\\"+ex.removeFileExtension(boardName)+"_.bmp");
	}else{
		parts.newPart(0,"dd",pL.getPath(f),mX(),mY());
		partId=parts.getSize()-1;
	}
}

void moveParts(){
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

void buttonSetup(){
	modeButton[0] = new Button(this,"parts",252,375,50,25);
	modeButton[1] = new Button(this,"Wiring",302,375,50,25);
	modeButton[2] = new Button(this,"Editing",352,375,50,25);
}

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
	for(int i=0,len=parts.getSize();i<len;i++){
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

class Button{
	JButton button1;
	boolean clicked=false;
	String text;
	int posEX,posEY,posSX,posSY;
	Button(PApplet app,String _text,int _posSX,int _posSY,int _posEX,int _posEY){
		text=_text;
		posEX=_posEX;
		posEY=_posEY;
		posSX=_posSX;
		posSY=_posSY;
	Canvas canvas = (Canvas)surface.getNative();
	JLayeredPane layeredPane = (JLayeredPane)canvas.getParent().getParent();
	button1 = new JButton(text);
	button1.setBounds(posSX,posSY,posEX,posEY);
	button1.setActionCommand(text);
	button1.setMargin(new Insets(0,0,0,0));
	layeredPane.add(button1);
	button1.addActionListener(new ActionListener() {
	public void actionPerformed(ActionEvent e) {
		clicked=true;
	}});
	}
	void move(int x,int y){
		button1.setBounds(x,y,posEX,posEY);
	}

}
