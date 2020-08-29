class Wiring{
	int sX,sY,eX,eY,length,deg,lineEX,lineEY,lineSX,lineSY;
	color co;
	Wiring(){

	}

	void addWires(int _sX,int _sY,int _eX,int _eY,color _co){
	sX=_sX;sY=_sY;eX=_eX;eY=_eY;co=_co;
	translate(sX,sY);
	float kaku = degrees(atan2(eY-sY,eX-sX))+180;
	translate(-sX,-sY);
	if ((kaku<=355)&&(kaku>=275)){
		lineSX=sX;
		lineSY=sY;
		lineEX=eX;
		lineEY=sY-eX+sX;
		deg=4;
	}if ((kaku<=85)&&(kaku>=5)){
		lineSX=sX;
		lineSY=sY;
		lineEX=eX;
		lineEY=sY+eX-sX;
		deg=2;
	}if ((kaku<=175)&&(kaku>=95)){
		lineSX=sX;
		lineSY=sY;
		lineEX=sY-eY+sX;
		lineEY=eY;
		deg=4;
	}if ((kaku<=265)&&(kaku>=185)){
		lineSX=sX;
		lineSY=sY;
		lineEX=sX+eY-sY;
		lineEY=eY;
		deg=2;
	}if (((kaku<=4)||(kaku>=356))||((kaku<=184)&&(kaku>=176))) {
		lineSX=sX;
		lineSY=sY;
		lineEX=eX;
		lineEY=sY;
		deg=3;
	}if((kaku<=94)&&(kaku>=86)||((kaku<=274)&&(kaku>=266))){
		lineSX=sX;
		lineSY=sY;
		lineEX=sX;
		lineEY=eY;
		deg=1;
	}
	}

	class Wiries{
		ArrayList<Wire> wire = new ArrayList<Wire>();
		color c;
		int mX,mY,x=0,y=0;
		Wiries(color _c){
			c=_c;
		}

		void addWire(int _sX,int _sY,int _eX,int _eY){
			mX=_eX-sX;mY=_eY-_sY;
			if(mY>mX){
			for (int i = 0,len=mY/10; i < len; ++i) {
				wire.add(new Wire(_sX,_sY+y,_sX,_sY+y+10,c));
				wire.get(i).redraw();
				println("aaaaa");
				y+=10;
			}
			y=0;
			}else if(mX>mY){
			for (int i = 0,len=mX/10; i < len; ++i) {
				wire.add(new Wire(_sX+x,_sY,_sX+x+10,_sY,c));
				wire.get(i).redraw();
				println("aa");
				x+=10;
			}
			}
		}

		int whatClick(){
			for (int i = 0,len=wire.size(); i < len; ++i) {
			if(wire.get(i).isCloss()){
				return i;
			}

			}
			return -1;
		}

		class Wire{
			int sX,sY,eX,eY;
			color co;
			Closs c;
			Wire(int _sX,int _sY,int _eX,int _eY,color _co){
				sX=_sX;
				sY=_sY;
				eX=_eX;
				eY=_eY;
				co=_co;
				c=new Closs(sX,sY,eX,eY);
			}

			void redraw(){
				fill(co);
				stroke(0);
				line(sX,sY,eX,eY);
			}

			boolean isCloss(){
				return c.isCloss();
			}

			class Closs{
				int csX,csY,ceX,ceY,a;
				float l1,l2,b;
				Closs(int _sX,int _sY,int _eX,int _eY){
					csX=_sX;
					csY=_sY;
					ceX=_eX;
					ceY=_eY;
					l1=sqrt(sq(ceX-csX)+(sq(ceY-csY)));
				}

				boolean isCloss(){
					l2=sqrt(sq(mouseX-csX)+(sq(mouseY-csY)));
					a=int((ceX-csX)*(mouseX-csX)+(ceY-csY)*(mouseY-csY));
					b=l1*l2;
					if((a==b)&&l1>=l2){
						return true;
					}else{
						return false;
					}
				}
			}
		}
	}
}

// void setup(){

// }

// void draw(){}
