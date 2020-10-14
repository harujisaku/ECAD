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
PImage a;
public void setup(){
	
	
	a=loadImage("start.png");
	Font.defaultFont=loadFont("mplus-1p-regular-14.vlw");
	b= new Button("test",0,0,200,200);
	w= new Window("a",0,0);
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
		strokeWeight(1);
		textAlign(CENTER,CENTER);
		rect(posX+1,posY+1,sizeX-3,sizeY-3);
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

	public int setButtonImage(PImage _image){
		image=_image.get(0,0,sizeX,sizeY);
		return 0;
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

	public void setColorDefault(){
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
	int defaultPosX,defaultPosY,defaultSizeX,defaultSizeY;
	ArrayList<Button> button = new ArrayList<Button>();
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
}


class Drawing{
	Drawing(){
		
	}
}

static class Font{
	static PFont defaultFont= new PFont();
}







class Object{
	Object(){
		
	}
}
// class Part{
// 	int sizeX,sizeY,posX,posY,deg,ofsetX,ofsetY,redPointX,redPointY;
// 	boolean isNoMove=false;
// 	PImage image;
// 	Part(int _deg,int _posX,int _posY,int _sizeX,int _sizeY,int _ofsetX,int _ofsetY,PImage _image){
// 		newParts(_deg,_posX,_posY,_sizeX,_sizeY,_ofsetX,_ofsetY,_image);
// 	}
// 	void newParts(int _deg,int _posX,int _posY,int _sizeX,int _sizeY,int _ofsetX,int _ofsetY,PImage _image) {
// 		posX=_posX;
// 		posY=_posY;
// 		sizeX=_sizeX;
// 		sizeY=_sizeY;
// 		ofsetX=_ofsetX;
// 		ofsetY=_ofsetY;
//
// 		image= _ image;
//
// 		if(_deg!=-1){
// 			deg=_deg;
// 		}
// 	}
//
// 	void moveParts(int _posX,int _posY){
// 		isNoMove=false;
// 		if(posX==_posX&&posY==_posY){
// 			isNoMove=true;
// 		}
// 		posX=_posX;
// 		posY=_posY;
// 	}
//
// 	boolean moveCheck(int _posX,int _posY){
// 		isNoMove=false;
// 		if(posX==_posX&&posY==_posY){
// 			isNoMove=true;
// 		}
// 		return isNoMove;
// 	}
//
// 	boolean posCheck(){
// 		if (deg==0){
// 			if((mouseX>=posX-ofsetX)&&(mouseY>=posY-ofsetY)&&(mouseX<=posX+sizeX-ofsetX)&&(mouseY<=posY+sizeY-ofsetY)){
// 					return true;
// 			}
// 		}else if(deg==1){
// 			if((mouseX>=posX-sizeY+ofsetY)&&(mouseY>=posY-ofsetX)&&(mouseX<=posX+ofsetY)&&(mouseY<=posY+sizeX-ofsetX)) {
// 				return true;
// 			}
// 		}else if(deg==2){
// 			if((mouseX>=posX-sizeX-ofsetX)&&(mouseY>=posY-sizeY+ofsetY)&&(mouseX<=posX+ofsetX)&&(mouseY<=posY+ofsetY)){
// 				return true;
// 			}
// 		}else if(deg==3){
// 			if((mouseX>=posX-ofsetY)&&(mouseY>=posY-sizeX+ofsetX)&&(mouseX<=posX-ofsetX+sizeY)&&(mouseY<=posY-ofsetY+sizeX)){
// 				return true;
// 			}
// 		}
// 		return false;
// 	}
//
// 	void turn(int adeg){
// 		if(adeg!=-1){
// 			deg=adeg;
// 		}
// 	}
// }
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

class WindowObject{
	WindowObject(){
		
	}
}
class Wire{
	Wire(){
		
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
