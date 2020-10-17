import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class ECAD extends PApplet {

Button b;
Window w;
Event e;
PImage a;
public void setup(){
	
	
	a=loadImage("start.png");
	Font.defaultFont=loadFont("mplus-1p-regular-14.vlw");
	b= new Button("test",0,0,200,200);
	w= new Window("a",0,0);
	e= new Event();
}

public void draw(){
	if (frameCount%30==0){
		background(125);
		b.toggleButtonActivity();
		b.redraw();
	}
}

public void mousePressed(){
	background(125);
	b.setButtonImage(a);
	b.redraw();
	e.mousePressed(mouseX,mouseY);
}

public void mouseReleased(){
	b.resetButtonImage();
	background(125);
	b.redraw();
}

public void keyPressed(){

}

public void keyReleased(){

}

public void mouseMoved(){
	e.mouseMoved(mouseX,mouseY);
}
class Button{
	private String text;
	private int posX,posY,sizeX,sizeY,textSize=13;
	private boolean drawFlg=true,activityFlg=true;
	private PImage image;
	private int buttonAccentColor=color(51,153,255);
	private int buttonBaseColor=color(255,255,255);
	private int buttonTextColor=color(0,0,0);
	private int buttonGrayColor=color(125);
	private PFont font=Font.defaultFont;
	Button(String _text,int _posX,int _posY,int _sizeX,int _sizeY){
		posX=_posX;
		posY=_posY;
		sizeX=_sizeX;
		sizeY=_sizeY;
		text=_text;
	}
	Button(String _text,int _posX,int _posY,int _sizeX,int _sizeY,boolean _drawFlg,boolean _activityFlg){
		posX=_posX;
		posY=_posY;
		sizeX=_sizeX;
		sizeY=_sizeY;
		text=_text;
		drawFlg=_drawFlg;
		activityFlg=_activityFlg;
	}

	public void setButtonText(String _text){
		text=_text;
	}

	public void setButtonPos(int _posX,int _posY){
		posX=_posX;
		posY=_posY;
	}

	public void setButtonSize(int _sizeX,int _sizeY){
		sizeX=_sizeX;
		sizeY=_sizeY;
	}

	public void setButtonDraw(boolean _drawFlg){
		drawFlg=_drawFlg;
	}

	public void setButtonActivity(boolean _activityFlg){
		activityFlg=_activityFlg;
	}

	public void toggleButtonDraw(){
		drawFlg=!drawFlg;
	}

	public void toggleButtonActivity(){
		activityFlg=!activityFlg;
	}

	public void redraw(){
		if(!drawFlg){
			return;
		}
		pushMatrix();
		fill(buttonBaseColor);
		noStroke();
		rect(posX,posY,sizeX,sizeY);
		stroke(activityFlg?buttonAccentColor:buttonGrayColor);
		strokeWeight(2);
		textAlign(CENTER,CENTER);
		rect(posX+2,posY+2,sizeX-4,sizeY-4);
		fill(activityFlg?buttonTextColor:buttonGrayColor);
		if(font !=null){
			textFont(font);
		}
		if(image!=null){
			image(image,posX,posY);
		}
		textSize(textSize);
		text(text,posX+sizeX/2,posY+sizeY/2);
		popMatrix();
	}

	public void setButtonImage(PImage _image){
		image=_image.get(0,0,sizeX,sizeY);
	}

	public void setButtonAccentColor(int _buttonAccentColor){
		buttonAccentColor=_buttonAccentColor;
	}

	public void setButtonBaseColor(int _buttonBaseColor){
		buttonBaseColor=_buttonBaseColor;
	}

	public void setButtonTextColor(int _buttonTextColor){
		buttonTextColor=_buttonTextColor;
	}

	public void setButtonTextFont(PFont _font){
		font=_font;
	}

	public void setButtonTextSize(int _textSize){
		textSize=_textSize;
	}

	public void resetColor(){
		buttonAccentColor=color(51,153,255);
		buttonBaseColor=color(255,255,255);
		buttonTextColor=color(0,0,0);
		buttonGrayColor=color(125);
	}

	public void resetButtonTextFont(){
		font=Font.defaultFont;
	}

	public void resetButtonImage(){
		image=null;
	}
}

class ButtonGroup{
	private int defaultPosX=0,defaultPosY=0,defaultSizeX=64,defaultSizeY=24;
	private ArrayList<Button> button = new ArrayList<Button>();
	ButtonGroup(int _defaultPosX,int _defaultPosY,int _defaultSizeX,int _defaultSizeY){
		defaultPosX=_defaultPosX;
		defaultPosY=_defaultPosY;
		defaultSizeX=_defaultSizeX;
		defaultSizeY=_defaultSizeY;
	}

	public int  addButton(String _text,int _posX,int _posY,int _sizeX,int _sizeY){
		button.add(new Button(_text,_posX,_posY,_sizeX,_sizeY));
		return button.size()-1;
	}

	public int addButton(String _text){
		button.add(new Button(_text,defaultPosX,defaultPosY,defaultSizeX,defaultSizeY));
		defaultPosY+=defaultSizeY;
		return button.size()-1;
	}

	public int  addButton(String _text,int _posX,int _posY){
		button.add(new Button(_text,_posX,_posY,defaultSizeX,defaultSizeY));
	return button.size()-1;
	}

	public void addButton(String[] _text,int[] _posX,int[] _posY,int[] _sizeX,int[] _sizeY){
		if(_text.length!=_posX.length||_text.length!=_posY.length||_text.length!=_sizeX.length||_text.length!=_sizeY.length){
			return;
		}
		for(int i = 0,len=_text.length;i<len;i++){
			button.add(new Button(_text[i],_posX[i],_posY[i],_sizeX[i],_sizeY[i]));
		}
	}

	public void removeButton(int _removeId){
		button.remove(_removeId);
	}

	public void redraw(int _id){
		button.get(_id).redraw();
	}

	public void redraw(){
		for(int i = 0,len=button.size();i<len;i++){
			button.get(i).redraw();
		}
	}

	public void setButtonText(int _id,String _text){
		button.get(_id).setButtonText(_text);
	}

	public void setButtonText(String _text){
		for(int i = 0,len=button.size();i<len;i++){
			button.get(i).setButtonText(_text);
		}
	}

	public void setButtonText(String[] _text){
		for(int i = 0,len=button.size();i<len;i++){
			button.get(i).setButtonText(_text[i]);
		}
	}

	public void setButtonImage(PImage[] _image){
		for(int i = 0,len=button.size();i<len;i++){
			button.get(i).setButtonImage(_image[i]);
		}
	}

	public void setButtonImage(int _id,PImage _image){
			button.get(_id).setButtonImage(_image);
	}

	public void setButtonImage(PImage _image){
		for(int i = 0,len=button.size();i<len;i++){
			button.get(i).setButtonImage(_image);
		}
	}

	public void setButtonAccentColor(int _buttonAccentColor){
		for(int i = 0,len=button.size();i<len;i++){
			button.get(i).setButtonAccentColor(_buttonAccentColor);
		}
	}

	public void setButtonAccentColor(int _id,int _buttonAccentColor){
		button.get(_id).setButtonAccentColor(_buttonAccentColor);
	}

	public void setButtonBaseColor(int _id,int _buttonBaseColor){
		button.get(_id).setButtonBaseColor(_buttonBaseColor);
	}

	public void setButtonBaseColor(int _buttonBaseColor){
		for(int i = 0,len=button.size();i<len;i++){
			button.get(i).setButtonBaseColor(_buttonBaseColor);
		}
	}

	public void setButtonBaseColor(int[] _buttonBaseColor){
		for(int i = 0,len=button.size();i<len;i++){
			button.get(i).setButtonBaseColor(_buttonBaseColor[i]);
		}
	}

	public void setButtonTextColor(int _id,int _buttonTextColor){
		button.get(_id).setButtonTextColor(_buttonTextColor);
	}

	public void setButtonTextColor(int _buttonTextColor){
		for(int i = 0,len=button.size();i<len;i++){
			button.get(i).setButtonTextColor(_buttonTextColor);
		}
	}

	public void setButtonTextColor(int[] _buttonTextColor){
		for(int i = 0,len=button.size();i<len;i++){
			button.get(i).setButtonTextColor(_buttonTextColor[i]);
		}
	}

	public void setDefaultPos(int _setPosX,int _setPosY){
		defaultPosX=_setPosX<0?defaultPosX:_setPosX;
		defaultPosY=_setPosY<0?defaultPosY:_setPosY;
	}

	public void setDefaultSize(int _setSizeX,int _setSizeY){
		defaultSizeX=_setSizeX<0?defaultSizeX:_setSizeX;
		defaultSizeY=_setSizeY<0?defaultSizeY:_setSizeY;
	}

	public void setButtonPos(int _id,int _setPosX,int _setPosY){
		button.get(_id).setButtonPos(_setPosX,_setPosY);
	}

	public void setButtonPos(int _setPosX,int _setPosY){
		for(int i = 0,len=button.size();i<len;i++){
			button.get(i).setButtonPos(_setPosX,_setPosY);
		}
	}

	public void setButtonPos(int[] _setPosX,int[] _setPosY){
		if (_setPosX.length!=_setPosY.length||_setPosX.length+_setPosY.length!=button.size()*2){
			return;
		}
		for(int i = 0,len=button.size();i<len;i++){
			button.get(i).setButtonPos(_setPosX[i],_setPosY[i]);
		}
	}

	public void setButtonSize(int _setSizeX,int _setSizeY){
		for(int i = 0,len=button.size();i<len;i++){
			button.get(i).setButtonSize(_setSizeX,_setSizeY);
		}
	}
	public void setButtonSize(int[] _setSizeX,int[] _setSizeY){
		if (_setSizeX.length!=_setSizeY.length||_setSizeX.length+_setSizeY.length!=button.size()*2){
			return;
		}
		for(int i = 0,len=button.size();i<len;i++){
			button.get(i).setButtonSize(_setSizeX[i],_setSizeY[i]);
		}
	}

	public void setButtonTextFont(int _id,PFont _font){
		button.get(_id).setButtonTextFont(_font);
	}

	public void setButtonTextFont(PFont _font){
		for(int i = 0,len=button.size();i<len;i++){
			button.get(i).setButtonTextFont(_font);
		}
	}

	public void setButtonDraw(int _id,boolean _drawFlg){
		button.get(_id).setButtonDraw(_drawFlg);
	}

	public void setButtonActivity(int _id,boolean _activityFlg){
		button.get(_id).setButtonActivity(_activityFlg);
	}

	public void toggleButtonDraw(int _id){
		button.get(_id).toggleButtonDraw();
	}

	public void toggleButtonActivity(int _id){
		button.get(_id).toggleButtonActivity();
	}

	public void setButtonDraw(boolean _drawFlg){
		for(int i = 0,len=button.size();i<len;i++){
			button.get(i).setButtonDraw(_drawFlg);
		}
	}

	public void setButtonActivity(boolean _activityFlg){
		for(int i = 0,len=button.size();i<len;i++){
			button.get(i).setButtonActivity(_activityFlg);
		}
	}

	public void toggleButtonDraw(){
		for(int i = 0,len=button.size();i<len;i++){
			button.get(i).toggleButtonDraw();
		}
	}

	public void toggleButtonActivity(){
		for(int i = 0,len=button.size();i<len;i++){
			button.get(i).toggleButtonActivity();
		}
	}

	public void resetButtonImage(){
		for(int i = 0,len=button.size();i<len;i++){
			button.get(i).resetButtonImage();
		}
	}

	public void resetButtonImage(int _id){
		button.get(_id).resetButtonImage();
	}

	public void resetButtonTextFont(){
		for(int i = 0,len=button.size();i<len;i++){
			button.get(i).resetButtonTextFont();
		}
	}

	public void resetButtonTextFont(int _id){
		button.get(_id).resetButtonTextFont();
	}

	public void resetColor(int _id){
		button.get(_id).resetColor();
	}

	public void resetColor(){
		for(int i = 0,len=button.size();i<len;i++){
			button.get(i).resetColor();
		}
	}
}

class Collision{
	Collision(){
		
	}
}
class Drawing{
	Drawing(){
		
	}
}
class Event{
	WindowEvent windowEvent;
	MouseEvent mouseEvent;
	KeyEvent keyEvent;
	int windowWidth,windowHeight;
	Event(){
		mouseEvent=new MouseEvent();
		windowWidth=width;
		windowHeight=height;
	}

	public void mousePressed(int _mouseX,int _mouseY){
		mouseEvent.mousePressed(_mouseX,_mouseY);
	}

	public void mouseReleased(){
		mouseEvent.mouseReleased();
	}

	public void keyPressed(){
		keyEvent.keyPressed();
	}

	public void keyReleased(){
		keyEvent.keyReleased();
	}

	public boolean isResize(){
		return windowWidth!=width||windowHeight!=height;
	}

	public void windowResized(){
		windowEvent.windowResized();
	}

	public void mouseMoved(int _mouseX,int _mouseY){
		mouseEvent.mouseMoved(_mouseX,_mouseY);
	}
}
static class Font{
	static PFont defaultFont= new PFont();
}

class KeyEvent{
	KeyEvent(){

	}

	public void keyPressed(){

	}

	public void keyReleased(){
		
	}
}



class MenuItem extends Button{
	MenuItem(String a,int g,int s,int k){
		super("test",0,0,100,20);
	}

	public void draw(int _mouseX,int _mouseY){
		super.setButtonPos(_mouseX,_mouseY);
	}

	public @Override
	void redraw(){
		if(!super.drawFlg){
			return;
		}
		pushMatrix();
		fill(super.buttonBaseColor);
		noStroke();
		rect(super.posX,super.posY,super.sizeX,super.sizeY);
		stroke(super.buttonGrayColor);
		strokeWeight(1);
		textAlign(CENTER,CENTER);
		rect(super.posX+2,super.posY+2,super.sizeX-4,super.sizeY-4);
		fill(super.activityFlg?super.buttonTextColor:super.buttonGrayColor);
		if(super.font !=null){
			textFont(super.font);
		}
		if(super.image!=null){
			image(super.image,super.posX,super.posY);
		}
		textSize(super.textSize);
		text(super.text,super.posX+super.sizeX/2,super.posY+super.sizeY/2);
		popMatrix();
	}

	public @Override
	void setButtonImage(PImage _image){
		_image.resize(min(min(_image.width,_image.height),super.sizeY),min(min(_image.width,_image.height),super.sizeY));
			super.image=_image;
	}
}
class MouseEvent{
	MenuItem m=new MenuItem("test",1,100,20);
	MouseEvent(){
	}

	public void mousePressed(int _mouseX,int _mouseY){
		m.draw(_mouseX,_mouseY);
		m.redraw();
	}

	public void mouseReleased(){

	}

	public void mouseMoved(int _mouseX,int _mouseY){

	}
}
class Object{
	Object(){
		
	}
}
class Part{
	int sizeX,sizeY,posX,posY,deg,ofsetX,ofsetY,redPointX,redPointY;
	boolean isNoMove=false;
	Part(int _deg,int _posX,int _posY,int _sizeX,int _sizeY,int _ofsetX,int _ofsetY){
		newParts(_deg,_posX,_posY,_sizeX,_sizeY,_ofsetX,_ofsetY);
	}
	public void newParts(int _deg,int _posX,int _posY,int _sizeX,int _sizeY,int _ofsetX,int _ofsetY) {
		posX=_posX;
		posY=_posY;
		sizeX=_sizeX;
		sizeY=_sizeY;
		ofsetX=_ofsetX;
		ofsetY=_ofsetY;
		if(_deg!=-1){
			deg=_deg;
		}
	}

	public void moveParts(int _posX,int _posY){
		isNoMove=false;
		if(posX==_posX&&posY==_posY){
			isNoMove=true;
		}
		posX=_posX;
		posY=_posY;
	}

	public boolean moveCheck(int _posX,int _posY){
		isNoMove=false;
		if(posX==_posX&&posY==_posY){
			isNoMove=true;
		}
		return isNoMove;
	}

	public void turn(int adeg){
		if(adeg!=-1){
			deg=adeg;
		}
	}
}
class PartList{
	PartList(){

	}
}
class PartListList{
	PartListList(){
		
	}
}



class PartImageList{
	PartImageList(){

	}
}
class PartImageLoad{
	PartImageLoad(){

	}
}



class Window{
	String title;
	int sizeX,sizeY;
	Window(String _title,int _sizeX,int _sizeY){
	}

}
class WindowEvent{
	WindowEvent(){

	}

	public void windowResized(){
		
	}
}
class WindowObject{
	WindowObject(){
		
	}
}
class Wire{
	int sX,sY,eX,eY;
	Wire(int _sX,int _sY,int _eX,int _eY){
		sX=_sX;
		sY=_sY;
		eX=_eX;
		eY=_eY;
	}
}
class Wiring{
	Wiring(){
		
	}
}

  public void settings() { 	size(200,200); 	noSmooth(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "ECAD" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
