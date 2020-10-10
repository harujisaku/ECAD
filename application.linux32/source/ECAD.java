import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.awt.event.MouseListener; 
import java.awt.event.MouseEvent; 
import java.awt.event.MouseWheelEvent; 
import java.awt.event.MouseWheelListener; 
import java.awt.Component; 
import javax.swing.*; 
import processing.awt.*; 
import java.awt.*; 
import java.awt.event.*; 
import java.lang.System; 
import java.awt.event.ActionEvent; 
import java.awt.event.ActionListener; 
import java.awt.event.KeyEvent; 
import java.awt.event.InputEvent; 
import java.awt.event.ItemListener; 
import java.awt.event.ItemEvent; 
import java.awt.event.MouseListener; 
import java.awt.event.MouseEvent; 
import java.awt.Component; 
import javax.swing.JFrame; 
import javax.swing.JMenu; 
import javax.swing.JMenuBar; 
import javax.swing.JMenuItem; 
import javax.swing.KeyStroke; 
import javax.swing.JPopupMenu; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class ECAD extends PApplet {












PImage startPhoto;
int partId=-1,count=0,f=0,mouseOfX,mouseOfY,gridS=10,partPosX,partPosY,partDeg,mode=0,lineSX=-1,lineSY=-1,lineEX,lineEY,wireId=-1,wireGroupId=-1,wireEditId=-1,wireEditMode,windowX,windowY;
String path="",partPath,partGloup,pathSlash="/";
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

public void setup(){
	
	startPhoto=loadImage("start.png");
	image(startPhoto,0,0,600,400);
	boardImg.loadPixels();
	for (int i = 0,len=boardImg.pixels.length; i < len; i++) {
		boardImg.pixels[i] = color(187,201,158);
	}
	boardImg.updatePixels();
	path = sketchPath()+"/parts/";
	if(System.getProperty("os.name").contains("dos")) {
		path = sketchPath()+"\\parts\\";
		pathSlash="\\";
	}
	pL=new PartList(63,63,80,80,0,0,250,400,path);
	try {
		UIManager.setLookAndFeel("com.sun.java.swing.plaf.motif.MotifLookAndFeel");
	} catch (Exception e) {
		e.printStackTrace();
	}
	pL.sortAll();
	setupComponent();
	thread("loadParts");
}

public void draw(){
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
		if (lineSX!=-1){
			wireHighlight();
		}
		if (windowSizeCheck()){
			for(int i = 0,len=modeButton.length;i<len;i++){
				modeButton[i].move(-1,height-20);
			}
		}
		file();
		fill(0);
		line(251,0,251,height);
		line(251,height-47,width,height-47);
		fill(255);
		w.update();
		stroke(0);
		fill(color(0,0,0,0));
		rect(mX(),mY(),2,2);
		fill(255);
	}
}

public void mousePressed(){
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
		if (w.getTouchingStartPoint(mX(),mY())!=-1&&mouseButton==LEFT){
			lineSX=w.getLineEndPosX(w.getTouchingStartPoint(mX(),mY()));
			lineSY=w.getLineEndPosY(w.getTouchingStartPoint(mX(),mY()));
			wireId=-1;
			wireGroupId=-1;
			wireEditId=w.getTouchingStartPoint(mX(),mY());
			wireEditMode=0;
		}else if(w.getTouchingEndPoint(mX(),mY())!=-1&&mouseButton==LEFT){
			lineSX=w.getLineStartPosX(w.getTouchingEndPoint(mX(),mY()));
			lineSY=w.getLineStartPosY(w.getTouchingEndPoint(mX(),mY()));
			wireId=-1;
			wireGroupId=-1;
			wireEditId=w.getTouchingEndPoint(mX(),mY());
			wireEditMode=1;
		}else if (keyCode==SHIFT&&keyPressed&&mouseButton==LEFT){
			wireGroupId=w.getTouchingWire(gridMouseX(5),gridMouseY(5));
			wireId=-1;
			wireEditId=-1;
			println("groupMode");
			println("wireGroupId ="+wireGroupId);
		}else if(!keyPressed&&mouseButton==LEFT){
			wireId=w.getTouchingWire(gridMouseX(5),gridMouseY(5));
			wireGroupId=-1;
			wireEditId=-1;
			println("wireMode");
			println("wireId ="+wireId);
		}else if(mouseButton==RIGHT){
			wireId=-1;
			wireGroupId=-1;
			wireEditId=-1;
		}
	}
}

public void mouseReleased(){
	if(mode==0){
		moveParts();
	}else if(mode==1){
		if (lineSX==mX()&&lineSY==mY()){
			lineSX=-1;
			lineSY=-1;
			return;
		}
		w.addWire(lineSX,lineSY,mX(),mY());
		w.groupWire();
		println("ECAD",lineSX,lineSY,mX(),mY());
		lineSX=-1;
		lineSY=-1;
	}else if(mode==2){
		w.reGroupWire();
		if(wireId!=-1){
			w.moveWire(wireId,mX(),mY());
			wireId=-1;
		}else if(wireGroupId!=-1){
			w.groupMoveFromId(wireGroupId,mX(),mY());
			wireGroupId=-1;
		}else if(wireEditId!=-1){
			lineSX=-1;
			lineSY=-1;
			if (wireEditMode==0){
				w.setStartPos(wireEditId,mX(),mY());
			}else if(wireEditMode==1){
				w.setEndPos(wireEditId,mX(),mY());
			}
		}
	}
}

public String[] listFileNames(String dir){
	File file = new File(dir);
	if(file.isDirectory()){
		String names[] = file.list();
		return names;
	}else{
		return null;
	}
}

public void keyPressed(){
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
		case 'a':
		w.groupMoveWire(0,20,20);
		break;
		case '':
		pasteFlg=true;
			break;
		case '':
			if(selectId!=-1){
				parts.remove(selectId);
			}else if(mode==2){
				w.remove(w.getTouchingWire(mX(),mY()));
			}
			selectId=-1;
			selectIds.clear();
			removeFlg=false;
			break;
		default:
			break;
	}
}

public void wireHighlight(){
	lineEX=mX();
	lineEY=mY();
	translate(lineSX,lineSY);
	float degFloat = degrees(atan2(lineEY-lineSY,lineEX-lineSX))+180;
	translate(-lineSX,-lineSY);
	int deg=PApplet.parseInt(degFloat);
	int hLineEX,hLineEY,hLineSX,hLineSY,decisionRange=20;
	if (deg<=360-decisionRange&&deg>=270+decisionRange){
		hLineSX=lineSX;
		hLineSY=lineSY;
		hLineEX=lineEX;
		hLineEY=lineSY-lineEX+lineSX;
	}else if(deg<=90-decisionRange&&deg>=decisionRange){
		hLineSX=lineEX;
		hLineSY=lineSY+lineEX-lineSX;
		hLineEX=lineSX;
		hLineEY=lineSY;
	}else if(deg<=180-decisionRange&&deg>=90+decisionRange){
		hLineSX=lineSX;
		hLineSY=lineSY;
		hLineEX=lineSY-lineEY+lineSX;
		hLineEY=lineEY;
	}else if(deg<=270-decisionRange&&deg>=180+decisionRange){
		hLineSX=lineSX;
		hLineSY=lineSY;
		hLineEX=lineSX+lineEY-lineSY;
		hLineEY=lineEY;
	}else if(deg<=decisionRange||deg>=360-decisionRange){
		hLineSX=lineEX;
		hLineEY=lineSY;
		hLineEX=lineSX;
		hLineSY=lineSY;
	}else if(deg<=180+decisionRange&&deg>=180-decisionRange){
		hLineSX=lineSX;
		hLineSY=lineSY;
		hLineEX=lineEX;
		hLineEY=lineSY;
	}else if(deg<=90+decisionRange&&deg>=90-decisionRange){
		hLineSX=lineSX;
		hLineSY=lineEY;
		hLineEX=lineSX;
		hLineEY=lineSY;
	}else if(deg<=270+decisionRange&&deg>=270-decisionRange){
		hLineSX=lineSX;
		hLineSY=lineSY;
		hLineEX=lineSX;
		hLineEY=lineEY;
	}else{
		println("deg error!");
		return;
	}
	line(hLineSX,hLineSY,hLineEX,hLineEY);
}

public void buttonCheck(){
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

public int mX(){
	return mouseX-mouseX%gridS;
}

public int mY(){
	return mouseY-mouseY%gridS;
}

public int gridMouseX(int size){
	return mouseX-mouseX%size;
}
public int gridMouseY(int size){
	return mouseY-mouseY%size;
}

public void setupComponent(){
	Component component = (Component) this.surface.getNative();
	component.addMouseListener(new Menu(this));
	component.addMouseWheelListener(new mouseWheel());
}

public void loadParts(){
	pL.makeList();
	count+=2;
}
public void select(){
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

public void makeParts(){
	File board=new File(pL.getPath(f));
	String boardPath= board.getParent();
	String boardName=board.getName();
	if(boardPath.equals(path+"Board")){
		boardImg = loadImage(pL.getPath(f));
		uraboardImg =  loadImage(boardPath+pathSlash+ex.removeFileExtension(boardName)+"_.bmp");
	}else{
		parts.newPart(0,"dd",pL.getPath(f),mX(),mY());
		partId=parts.getSize()-1;
	}
}

public void moveParts(){
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

public void buttonSetup(){
	modeButton[0] = new Button(this,"parts",252,375,50,25);
	modeButton[1] = new Button(this,"Wiring",302,375,50,25);
	modeButton[2] = new Button(this,"Editing",352,375,50,25);
}

public void kopipe(){
	if(removeFlg){
		if(selectId!=-1){
			parts.remove(selectId);
			selectId=-1;
			selectIds.clear();
		}else if(mode==2){
			w.remove(w.getTouchingWire(mX(),mY()));
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

public void rightClick(){
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

public boolean windowSizeCheck(){
	if (windowX!=width||windowY!=height){
		windowX=width;
		windowY=height;
		return true;
	}
	return false;
}

public void moveHighlight(){
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
	}else if(wireId!=-1){
		stroke(0);
		line(mX(),mY(),mX()+w.getLineEndPosX(wireId)-w.getLineStartPosX(wireId),mY()+w.getLineEndPosY(wireId)-w.getLineStartPosY(wireId));
	}
}

public void file(){
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
	public void move(int x,int y){
		if (x==-1){
			x=posSX;
		}else if(y==-1){
			y=posSY;
		}
		button1.setBounds(x,y,posEX,posEY);
	}

}
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

public void redraw(){
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
	public void move(int _listPosX,int _listPosY){
		listPosX=_listPosX;
		listPosY=_listPosY;
	}
	public void resize(int _listSizeX,int _listSizeY){
		listSizeX=_listSizeX;
		listSizeY=_listSizeY;
	}
	public void scrool(int _ofsetX,int _ofsetY){
		ofsetX=_ofsetX;
		ofsetY=_ofsetY;
	}

public void remake(int _imageWidth,int _imageHeight,int _boxWidth,int _boxHeight,int _listPosX,int _listPosY,int _listSizeX,int _listSizeY,String directory){
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

	public int pushButton(){
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

	public String pushPath(int a){
		return filesbmp[a];
	}
}














	//多分いらんやつあるけど許して。

public class Menu implements MouseListener{
	JFrame frame;
	JPopupMenu popup;
	public Menu(PApplet app){
		System.setProperty("apple.laf.useScreenMenuBar", "true");	//アップル系のOSで使うやつだと思う。
		frame = (JFrame) ((processing.awt.PSurfaceAWT.SmoothCanvas)app.getSurface().getNative()).getFrame();
		JMenuBar menu_bar = new JMenuBar();
		frame.setJMenuBar(menu_bar);

		JMenu file_menu = new JMenu("ファイル(F)");
		JMenu edit_menu = new JMenu("編集(E)");

		menu_bar.add(file_menu);
		menu_bar.add(edit_menu);

		file_menu.setMnemonic(KeyEvent.VK_F); //ショートカットキーを設定この場合だとalt+Iになる。
		edit_menu.setMnemonic(KeyEvent.VK_E);

		JMenuItem new_file = new JMenuItem("開く");
		JMenuItem save = new JMenuItem("保存");
		JMenuItem exit = new JMenuItem("終了");

		file_menu.add(new_file);
		file_menu.add(save);
		file_menu.addSeparator();	//線を書く
		file_menu.add(exit);

		// JMenuItem copy = new JMenuItem("コピー");

		// edit_menu.add(copy);

		exit.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_Q, InputEvent.CTRL_DOWN_MASK));	//ショートカットキーを設定この場合だとctrl+q

		frame.setVisible(true);	//多分おまじない
		popup = new JPopupMenu();
		JMenuItem import_item = new JMenuItem("import");
		JMenuItem import_item2 = new JMenuItem("import folder");
		JMenuItem trunr90 = new JMenuItem("右に90度回転");
		JMenuItem trun180 = new JMenuItem("180度回転");
		JMenuItem trunl90 = new JMenuItem("左に90度回転");
		JMenuItem trun20 = new JMenuItem("0度に回転");
		JMenuItem delete = new JMenuItem("削除");
		JMenuItem copy = new JMenuItem("コピー");
		JMenuItem paste = new JMenuItem("ペースト");

		// delete.setMnemonic(KeyEvent.VK_E);
		delete.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_DELETE,0));
		copy.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_C, InputEvent.CTRL_DOWN_MASK));
		paste.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_V, InputEvent.CTRL_DOWN_MASK));
		popup.add(copy);
		popup.add(paste);
		popup.add(delete);
		popup.addSeparator();
		popup.add(trunr90);
		popup.add(trun180);
		popup.add(trunl90);
		popup.add(trun20);
		import_item.addActionListener(new ActionListener() { //import_itemがクリックされたときにこいつを呼び出す。以下同
			public void actionPerformed(ActionEvent arg0) {
			}});

		trunr90.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				println(selectId);
				setDeg=1;
				if (setDeg>=4){
					setDeg=0;
				}
			}});
		trun180.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				setDeg=2;
				if(setDeg>=4){
					if(setDeg==4){
					setDeg=0;
					}else if(setDeg>=5){
						setDeg=1;
					}
				}
			}});
		trunl90.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				setDeg=3;
				if(setDeg<0){
					setDeg=3;
				}
			}});
		trun20.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				setDeg=0;
			}});

			exit.addActionListener(new ActionListener() {
				public void actionPerformed(ActionEvent arg0) {
					exit();
			}});
			delete.addActionListener(new ActionListener() {
				public void actionPerformed(ActionEvent arg0) {
						removeFlg=true;
			}});
			copy.addActionListener(new ActionListener() {
				public void actionPerformed(ActionEvent arg0) {
					copyFlg=true;
			}});
			paste.addActionListener(new ActionListener() {
				public void actionPerformed(ActionEvent arg0) {
					pasteFlg=true;
			}});
			save.addActionListener(new ActionListener() {
				public void actionPerformed(ActionEvent arg0) {
					pasteFlg=true;
			}});
			save.addActionListener(new ActionListener() {
				public void actionPerformed(ActionEvent arg0) {
					pasteFlg=true;
			}});
	}

	private void showPopup(MouseEvent e){
		if (e.isPopupTrigger()) {
			popup.show(e.getComponent(), e.getX(), e.getY()); //マウスの座標にメニューを表示
		}
	}

	@Override
	public void mouseClicked(MouseEvent e) {} //これがないとエラーが出たはず
	@Override
	public void mouseEntered(MouseEvent e) {		}
	@Override
	public void mouseExited(MouseEvent e) {}

	@Override
	public void mousePressed(MouseEvent e) {	//クリックされたらshowPopupを呼び出す。下も同じ
		showPopup(e);
	}

	@Override
	public void mouseReleased(MouseEvent e) {
		showPopup(e);
	}
	public void mouseWheelMoved(MouseWheelEvent e){
	}
}
class Part{
	int sizeX,sizeY,posX,posY,deg,ofsetX,ofsetY;
	int copySizeX,copySizeY,copyPosX,copyPosY,copyDeg,copyOfX,copyOfY;
	String copyPath,copyGloup;
	boolean isNoMove=false;
	PImage photo;
	Part(int _deg,String gloup,String path,int _posX,int _posY){
		newParts(_deg,gloup,path,_posX,_posY);
	}
	Part(){}
	public void newParts(int _deg,String gloup,String path,int _posX,int _posY) {
		photo = loadImage(path);
		posX=_posX;
		posY=_posY;
		copyPath=path;
		copyGloup=gloup;
		sizeX=photo.width;
		sizeY=photo.height;
		ofsetX=serchPointX(photo.width,photo.height);
		ofsetY=serchPointY(photo.width,photo.height);
		if(_deg!=-1){
			deg=_deg;
		}
	}

	public void moveParts(int _posX,int _posY){
		if(posX==_posX&&posY==_posY){
			isNoMove=true;
		}else{
			isNoMove=false;
		}
		posX=_posX;
		posY=_posY;
	}

	public boolean moveCheck(int psX,int psY){
		if(posX==psX&&posY==psY){
			isNoMove=true;
		}else{
			isNoMove=false;
		}
		return isNoMove;
	}

	public void redrawParts() {
		pushMatrix();
		translate(posX,posY);
		rotate(radians(deg*90));
		image(photo,0-ofsetX,0-ofsetY);
		popMatrix();
	}

	public void printVariable() {
		println(deg);
		println(posX);
		println(posY);
		println(ofsetX);
		println(ofsetY);
	}

	public boolean posCheck(){
		if (deg==0){
			if((mouseX>=posX-ofsetX)&&(mouseY>=posY-ofsetY)&&(mouseX<=posX+sizeX-ofsetX)&&(mouseY<=posY+sizeY-ofsetY)){
					return true;
			}
		}else if(deg==1){
			if((mouseX>=posX-sizeY+ofsetY)&&(mouseY>=posY-ofsetX)&&(mouseX<=posX+ofsetY)&&(mouseY<=posY+sizeX-ofsetX)) {
				return true;
			}
		}else if(deg==2){
			if((mouseX>=posX-sizeX-ofsetX)&&(mouseY>=posY-sizeY+ofsetY)&&(mouseX<=posX+ofsetX)&&(mouseY<=posY+ofsetY)){
				return true;
			}
		}else if(deg==3){
			if((mouseX>=posX-ofsetY)&&(mouseY>=posY-sizeX+ofsetX)&&(mouseX<=posX-ofsetX+sizeY)&&(mouseY<=posY-ofsetY+sizeX)){
				return true;
			}
		}
			return false;
	}

	public int serchPointX(int w,int h) {
		int f=0;
		int d2=0;
		for (int d=0 ; d<w ; d++) {
			for (int i=0 ; i<h ; i++){;
				int c = photo.get(d,i);
				if ((red(c)>240)&&(green(c)<=20)&&(blue(c)<=20)) {
					f++;
					if (f==1) {
						d2=d;
						return d;
		}}}}
		return d2;
	}

	public int serchPointY(int w, int h) {
		int f=0;
		int i2=0;
		for (int d=0 ; d<w ; d++) {
			for (int i=0 ; i<h ; i++){
				int c = photo.get(d,i);
				if ((red(c)>240)&&(green(c)<=20)&&(blue(c)<=20)) {
					f++;
					if (f==1) {
						i2=i;
						return i;
		}}}}
		return i2;
	}

	public void turn(int adeg){
		if(adeg==-1){
		}else{
			deg=adeg;
		}
	}

	public void copyVariable(){
		copyPosX=posX;
		copyPosY=posY;
		copySizeX=sizeX;
		copySizeY=sizeY;
		copyOfX=ofsetX;
		copyOfY=ofsetY;
		copyDeg=deg;
	}
}
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

	public void sortDir(){
		java.util.Arrays.sort(fileNames);
	}

	public void sortAll(){
		if(fileNames!=null){
			java.util.Arrays.sort(fileNames);
		}
	}
	public int getSize(){
		return iL.size();
	}
	public void makeList(){
		for(int i=0,len=fileNames.length;i<len;i++){
			String name=fileNames[i];
				println("fileNames[i]: "+name);
				String fileName=path+name;
				iL.add(new ImageList(partSizeX,partSizeY,boxSizeX,boxSizeY,listPosX,listPosY,listSizeX,listSizeY,fileName));
		}
	}

	public void update(){
		for (int i = 0,len=iL.size(); i < len; ++i) {
			iL.get(i).redraw();
		}
	}

	public void update(int a){
		if(a<0||a>iL.size()-1){
			return;
		}
		iL.get(a).redraw();
	}

	public int getButton(int a){
		if(a<0||a>iL.size()-1){
			return -1;
		}
		return iL.get(a).pushButton();
	}

	public String getPath(int a){
		return iL.get(a).pushPath(getButton(a));
	}
	public String getName(int a){
		return fileNames[a];
	}
	public void scrool(int _scroolX,int _scroolY){
		scroolX=_scroolX;
		scroolY=_scroolY;
		for (int i = 0,len=iL.size(); i <len; ++i) {
			iL.get(i).scrool(scroolX,scroolY);
		}
	}

	public String[] listFileNames(String dir){
		File file = new File(dir);
		if(file.isDirectory()){
			String names[] = file.list();
			return names;
		}else{
			return null;
		}
	}
	public void resizeList(int sizeX,int sizeY){
		listSizeX=sizeX;
		listSizeY=sizeY;
		for (int i = 0,len=iL.size(); i < len; ++i) {
			iL.get(i).resize(listSizeX,listSizeY);
		}
	}
}
class Parts{
	ArrayList<Part> part = new ArrayList<Part>();
	int partPosX,partPosY,partDeg;
	String partPath,partGloup;
	Parts(){
	}

	public int newPart(int deg,String gloup,String path,int posX,int posY){
		if (path!=null) {
			println(path);
			part.add(new Part(deg,gloup,path,posX,posY));
		return 0;
		}else{
			return -1;
		}
	}

	public int getPosX(int index){
		return part.get(index).posX;
	}
	public int getPosY(int index){
		return part.get(index).posY;
	}

	public int getSize(){
		return part.size();
	}

	public void turn(int index,int deg){
		part.get(index).turn(deg);
	}

	public boolean isClick(int index){
		return part.get(index).posCheck();
	}

	public boolean isMove(int index,int posX,int posY){
		return part.get(index).moveCheck(posX,posY);
	}

	public void move(int index,int posX,int posY){
		part.get(index).moveParts(posX,posY);
	}

	public int getDeg(int index){
		return part.get(index).deg;
	}

	public int getSizeX(int index){
		return part.get(index).sizeX;
	}

	public int getSizeY(int index){
		return part.get(index).sizeY;
	}

	public int getOfsetX(int index){
		return part.get(index).ofsetX;
	}

	public int getOfsetY(int index){
		return part.get(index).ofsetY;
	}

	public void redraw(){
		for(int k=part.size()-1;k>=0;k--){
			part.get(k).redrawParts();
		}
	}
	public void redraw(int index){
		part.get(index).redrawParts();
	}

	public void copyVariable(int index){
		part.get(index).copyVariable();
		partPosX=part.get(index).copyPosX;
		partPosY=part.get(index).copyPosY;
		partDeg=part.get(index).copyDeg;
		partPath=part.get(index).copyPath;
		partGloup=part.get(index).copyGloup;
	}

	public void remove(int index){
		part.remove(index);
	}
}
class Wiring{
	protected int lineColor;
	protected int lineStartPosX=0,lineStartPosY=0,lineEndPosX=0,lineEndPosY=0,deg,_ElineStartPosX,_ElineStartPosY,_ElineEndPosX,_ElineEndPosY;
	Wires wires=new Wires(color(255,0,0));
	Wiring(int _lineColor){
		lineColor=_lineColor;
	}
	public void addWire(int _lineStartPosX,int _lineStartPosY,int _lineEndPosX,int _lineEndPosY){
		translate(_lineStartPosX,_lineStartPosY);
		float degFloat = degrees(atan2(_lineEndPosY-_lineStartPosY,_lineEndPosX-_lineStartPosX))+180;
		translate(-_lineStartPosX,-_lineStartPosY);
		deg=PApplet.parseInt(degFloat);
		_ElineStartPosX=_lineStartPosX;
		_ElineStartPosY=_lineStartPosY;
		_ElineEndPosX=_lineEndPosX;
		_ElineEndPosY=_lineEndPosY;
		lineAngleFormating(20);
		wires.addWire(lineStartPosX,lineStartPosY,lineEndPosX,lineEndPosY);
	}

	public void moveWire(int _id,int _moveToX,int _moveToY){
		wires.moveWire(_id,_moveToX,_moveToY);
	}
	public void relativeMoveWire(int _id,int _moveX,int _moveY){
		wires.relativeMoveWire(_id,_moveX,_moveY);
	}
	public void groupMoveWire(int _groupId,int _moveX,int _moveY){
		wires.groupMoveWire(_groupId,_moveX,_moveY);
	}
	public void groupMoveFromId(int _id,int _moveToX,int _moveToY){
		wires.groupMoveFromId(_id,_moveToX,_moveToY);
	}

	public void groupRelativeMoveFromId(int _id,int _moveX,int _moveY){
		wires.groupRelativeMoveFromId(_id,_moveX,_moveY);
	}

	public void update(){
		wires.update();
		// line(lineStartPosX,lineStartPosY,lineEndPosX,lineEndPosY);
	}

	public void remove(int _id){
		wires.remove(_id);
	}

	public void setStartPos(int _id,int _setPosX,int _setPosY){
		translate(_setPosX,_setPosY);
		float degFloat = degrees(atan2(getLineEndPosY(_id)-_setPosY,getLineEndPosX(_id)-_setPosX))+180;
		translate(-_setPosX,-_setPosY);
		deg=PApplet.parseInt(degFloat);
		_ElineEndPosX=_setPosX;
		_ElineEndPosY=_setPosY;
		_ElineStartPosX=getLineEndPosX(_id);
		_ElineStartPosY=getLineEndPosY(_id);
		lineAngleFormating(20);
		// line(lineStartPosX,lineStartPosY,lineEndPosX,lineEndPosY);
		wires.setEndPos(_id,lineStartPosX,lineStartPosY);
		wires.setStartPos(_id,lineEndPosX,lineEndPosY);
	}

	public void setEndPos(int _id,int _setPosX,int _setPosY){
		translate(getLineStartPosX(_id),getLineStartPosY(_id));
		float degFloat = degrees(atan2(_setPosY-getLineStartPosY(_id),_setPosX-getLineStartPosX(_id)))+180;
		translate(-getLineStartPosX(_id),-getLineStartPosY(_id));
		deg=PApplet.parseInt(degFloat);
		_ElineEndPosX=_setPosX;
		_ElineEndPosY=_setPosY;
		_ElineStartPosX=getLineStartPosX(_id);
		_ElineStartPosY=getLineStartPosY(_id);
		lineAngleFormating(20);
		println(lineStartPosX,lineStartPosY,lineEndPosX,lineEndPosY);
		wires.setEndPos(_id,lineStartPosX,lineStartPosY);
		wires.setStartPos(_id,lineEndPosX,lineEndPosY);
	}

	public int getTouchingWire(int _checkPointX,int _checkPointY){
		return wires.getTouchingWire(_checkPointX,_checkPointY);
	}

	public int getTouchingStartPoint(int _checkPointX,int _checkPointY){
		return wires.getTouchingStartPoint(_checkPointX,_checkPointY);
	}
	public int getTouchingEndPoint(int _checkPointX,int _checkPointY){
		return wires.getTouchingEndPoint(_checkPointX,_checkPointY);
	}

	public void groupWire(){
		wires.groupWire();
	}

	public void reGroupWire(){
		wires.decompositionGroup();
		wires.groupWire();
	}

	private void lineAngleFormating(int decisionRange){
		println("deg ="+deg);
		if (deg<=360-decisionRange&&deg>=270+decisionRange){
			//左下
			lineStartPosX=_ElineStartPosX;
			lineStartPosY=_ElineStartPosY;
			lineEndPosX=_ElineEndPosX;
			lineEndPosY=_ElineStartPosY-_ElineEndPosX+_ElineStartPosX;
		}else if(deg<=90-decisionRange&&deg>=decisionRange){
			//左上
			lineStartPosX=_ElineEndPosX;
			lineStartPosY=_ElineStartPosY+_ElineEndPosX-_ElineStartPosX;
			lineEndPosX=_ElineStartPosX;
			lineEndPosY=_ElineStartPosY;
		}else if(deg<=180-decisionRange&&deg>=90+decisionRange){
			//右上
			lineStartPosX=_ElineStartPosX;
			lineStartPosY=_ElineStartPosY;
			lineEndPosX=_ElineStartPosY-_ElineEndPosY+_ElineStartPosX;
			lineEndPosY=_ElineEndPosY;
		}else if(deg<=270-decisionRange&&deg>=180+decisionRange){
			//右下
			lineStartPosX=_ElineStartPosX;
			lineStartPosY=_ElineStartPosY;
			lineEndPosX=_ElineStartPosX+_ElineEndPosY-_ElineStartPosY;
			lineEndPosY=_ElineEndPosY;
		}else if(deg<=decisionRange||deg>=360-decisionRange){
			//左
			lineStartPosX=_ElineEndPosX;
			lineEndPosY=_ElineStartPosY;
			lineEndPosX=_ElineStartPosX;
			lineStartPosY=_ElineStartPosY;
		}else if(deg<=180+decisionRange&&deg>=180-decisionRange){
			//右
			lineStartPosX=_ElineStartPosX;
			lineStartPosY=_ElineStartPosY;
			lineEndPosX=_ElineEndPosX;
			lineEndPosY=_ElineStartPosY;
		}else if(deg<=90+decisionRange&&deg>=90-decisionRange){
			//上
			lineStartPosX=_ElineStartPosX;
			lineStartPosY=_ElineEndPosY;
			lineEndPosX=_ElineStartPosX;
			lineEndPosY=_ElineStartPosY;
		}else if(deg<=270+decisionRange&&deg>=270-decisionRange){
			//下
			lineStartPosX=_ElineStartPosX;
			lineStartPosY=_ElineStartPosY;
			lineEndPosX=_ElineStartPosX;
			lineEndPosY=_ElineEndPosY;
		}else{
			return;
		}

	}

	public int getLineStartPosX(int _id){
		return wires.getLineStartPosX(_id);
	}
	public int getLineStartPosY(int _id){
		return wires.getLineStartPosY(_id);
	}
	public int getLineEndPosX(int _id){
		return wires.getLineEndPosX(_id);
	}
	public int getLineEndPosY(int _id){
		return wires.getLineEndPosY(_id);
	}
	protected class Wires{
		int lineColor;
		protected ArrayList<Wire> wire = new ArrayList<Wire>();
		ArrayList<ArrayList<Integer>> id = new ArrayList<ArrayList<Integer>>();
		Wires(int _lineColor){
			lineColor=_lineColor;
		}

		public void update(){
			for(int i = 0,len=wire.size();i<len;i++){
				wire.get(i).redraw();
			}
		}

		public void remove(int _id){
			if(_id>=wire.size()||_id<0){
				return;
			}
			wire.remove(_id);
			reGroupWire();
		}

		private void addWire(int _lineStartPosX,int _lineStartPosY,int _lineEndPosX,int _lineEndPosY){
			wire.add(new Wire(_lineStartPosX,_lineStartPosY,_lineEndPosX,_lineEndPosY,lineColor));
			ArrayList<Integer> a = new ArrayList<Integer>();
			a.add(wire.size()-1);
			id.add(a);
			printArray(id);
		}

		public void moveWire(int _id,int _moveToX,int _moveToY){
			wire.get(_id).move(_moveToX,_moveToY);
		}
		public void relativeMoveWire(int _id,int _moveX,int _moveY){
			wire.get(_id).relativeMove(_moveX,_moveY);
		}

		public void groupMoveWire(int _groupId,int _moveX,int _moveY){
			for(int i = 0,len=id.get(_groupId).size();i<len;i++){
				wire.get(id.get(_groupId).get(i)).relativeMove(_moveX,_moveY);
			}
		}

		public void groupMoveFromId(int _id,int _moveToX,int _moveToY){
			for(int i = 0,len=id.size();i<len;i++){
				if(id.get(i).indexOf(_id)>=0){
					int moveX,moveY;
					moveX=_moveToX-wire.get(_id).lineStartPosX;
					moveY=_moveToY-wire.get(_id).lineStartPosY;
					groupMoveWire(i,moveX,moveY);
					return;
				}
			}
		}

		public void groupRelativeMoveFromId(int _id,int _moveX,int _moveY){
			for(int i = 0,len=id.size();i<len;i++){
				if (id.get(i).indexOf(_id)>=0){
					groupMoveWire(i,_moveX,_moveY);
				}
			}
		}

		public void groupWire(){
			while(groupWireLoop()){}
		}

		public void decompositionGroup(){
			id.clear();
			for(int i = 0,len=wire.size();i<len;i++){
				ArrayList<Integer> a = new ArrayList<Integer>();
				a.add(i);
				id.add(a);
			}
			groupWire();
		}

		private boolean groupWireLoop(){
			for(int i = 0,len=id.size();i<len;i++){
				ArrayList<Integer> b = new ArrayList<Integer>();
				for(int j = 0,lenj=id.get(i).size();j<lenj;j++){
					for(int k = 0,lenk=id.size();k<lenk;k++){
						if (k==i){
							continue;
						}
						for(int l = 0,lenl=id.get(k).size();l<lenl;l++){
							if(wire.get(id.get(i).get(j)).isCloss(wire.get(id.get(k).get(l)).lineStartPosX,wire.get(id.get(k).get(l)).lineStartPosY,wire.get(id.get(k).get(l)).lineEndPosX,wire.get(id.get(k).get(l)).lineEndPosY)){
								b=new ArrayList<Integer>(id.get(k));
								id.get(i).addAll(b);
								id.remove(k);
								return true;
							}
						}
					}
				}
			}
			return false;
		}

		public int getTouchingWire(int _checkPointX,int _checkPointY){
			for(int i = 0,len=wire.size();i<len;i++){
				if(wire.get(i).isTouching(_checkPointX,_checkPointY)){
					return i;
				}
			}
			return -1;
		}
		public int getLineStartPosX(int _id){
			return wire.get(_id).lineStartPosX;
		}
		public int getLineStartPosY(int _id){
			return wire.get(_id).lineStartPosY;
		}
		public int getLineEndPosX(int _id){
			return wire.get(_id).lineEndPosX;
		}
		public int getLineEndPosY(int _id){
			return wire.get(_id).lineEndPosY;
		}

		public int getTouchingStartPoint(int _checkPointX,int _checkPointY){
			for(int i = 0,len=wire.size();i<len;i++){
				if (getLineStartPosX(i)==_checkPointX&&getLineStartPosY(i)==_checkPointY){
					return i;
				}
			}
			return -1;
		}
		public int getTouchingEndPoint(int _checkPointX,int _checkPointY){
			for(int i = 0,len=wire.size();i<len;i++){
				if (getLineEndPosX(i)==_checkPointX&&getLineEndPosY(i)==_checkPointY){
					return i;
				}
			}
			return -1;
		}

		public void setStartPos(int _id,int _setPosX,int _setPosY){
			wire.get(_id).lineStartPosX=_setPosX;
			wire.get(_id).lineStartPosY=_setPosY;
		}
		public void setEndPos(int _id,int _setPosX,int _setPosY){
			wire.get(_id).lineEndPosX=_setPosX;
			wire.get(_id).lineEndPosY=_setPosY;
		}

	}

	class Wire{
		int lineStartPosX,lineStartPosY,lineEndPosX,lineEndPosY;
		int lineColor;
		Wire(int _lineStartPosX,int _lineStartPosY,int _lineEndPosX,int _lineEndPosY,int _lineColor){
			lineStartPosX=_lineStartPosX;
			lineStartPosY=_lineStartPosY;
			lineEndPosX=_lineEndPosX;
			lineEndPosY=_lineEndPosY;
			lineColor=_lineColor;
		}

		public void move(int _moveToX,int _moveToY){
			int moveX,moveY;
			moveX=_moveToX-lineStartPosX;
			moveY=_moveToY-lineStartPosY;
			lineStartPosX+=moveX;
			lineStartPosY+=moveY;
			lineEndPosX+=moveX;
			lineEndPosY+=moveY;
		}

		public void relativeMove(int _moveX,int _moveY){
			lineStartPosX+=_moveX;
			lineStartPosY+=_moveY;
			lineEndPosX+=_moveX;
			lineEndPosY+=_moveY;
		}

		public void redraw(){
			stroke(lineColor);
			line(lineStartPosX,lineStartPosY,lineEndPosX,lineEndPosY);
			rect(lineStartPosX,lineStartPosY,5,5);
		}

		public boolean isCloss(int cx,int cy,int dx,int dy) {
			int ax=lineStartPosX, ay=lineStartPosY, bx=lineEndPosX, by=lineEndPosY;
			float ta = (((cx - dx) * (ay - cy)) + ((cy - dy) * (cx - ax)));
			float tb = (((cx - dx) * (by - cy)) + ((cy - dy) * (cx - bx)));
			float tc = (((ax - bx) * (cy - ay)) + ((ay - by) * (ax - cx)));
			float td = (((ax - bx) * (dy - ay)) + ((ay - by) * (ax - dx)));
			if (PApplet.parseInt(tc * td) <= 0 && PApplet.parseInt(ta * tb) <= 0){
					return true;
				}
				return false;
			}

		public boolean isTouching(int checkPointX,int checkPointY){
			float l1=sqrt(sq(lineEndPosX-lineStartPosX)+(sq(lineEndPosY-lineStartPosY)));
			float l2=sqrt(sq(checkPointX-lineStartPosX)+(sq(checkPointY-lineStartPosY)));
			int a=PApplet.parseInt((lineEndPosX-lineStartPosX)*(checkPointX-lineStartPosX)+(lineEndPosY-lineStartPosY)*(checkPointY-lineStartPosY));
			int b=PApplet.parseInt(l1*l2);
			if(a==b&&l1>=l2){
				return true;
			}
			return false;
		}
	}
}
  public void settings() { 	size(600,400); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "ECAD" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
