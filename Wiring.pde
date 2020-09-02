class Wiring{
	int sX,sY,eX,eY,length,deg,lineEX,lineEY,lineSX,lineSY;
	color co;
	Wires w;
	Wiring(color _co){
		co=_co;
		w = new Wires(co);
	}

	void addWires(int _sX,int _sY,int _eX,int _eY){
		print(_sX,_sY,_eX,_eY);
	sX=_sX;sY=_sY;eX=_eX;eY=_eY;
	translate(sX,sY);
	int kaku;
	float kakur = degrees(atan2(eY-sY,eX-sX))+180;
	translate(-sX,-sY);
	kaku=int(kakur);
	if ((kaku<=355)&&(kaku>=275)){
		lineSX=sX;
		lineSY=sY;
		lineEX=eX;
		lineEY=sY-eX+sX;
		println("a");
		deg=4;
	}else if ((kaku<=85)&&(kaku>=5)){
		lineEX=sX;
		lineEY=sY;
		lineSX=eX;
		lineSY=sY+eX-sX;
		println("b");
		deg=2;
	}else if ((kaku<=175)&&(kaku>=95)){
		lineSX=sX;
		lineSY=sY;
		lineEX=sY-eY+sX;
		lineEY=eY;
		deg=4;
		println("c");
	}else if ((kaku<=265)&&(kaku>=185)){
		lineSX=sX;
		lineSY=sY;
		lineEX=sX+eY-sY;
		lineEY=eY;println("d");
		deg=2;
	}else if ((kaku<=4)||(kaku>=356)){
		lineSX=eX;
		lineEY=sY;
		lineEX=sX;
		lineSY=eY;
		println("variables");
		deg=3;
	}else if((kaku<=184)&&(kaku>=176)) {
		lineSX=sX;
		lineSY=sY;
		lineEX=eX;
		lineEY=sY;
		println("e");
		deg=3;
	}else if((kaku<=94)&&(kaku>=86)){
		lineSX=sX;
		lineSY=eY;
		lineEX=sX;
		lineEY=sY;println("g");
		deg=1;
	}else if((kaku<=274)&&(kaku>=266)) {
		lineSX=sX;
		lineSY=sY;
		lineEX=sX;
		lineEY=eY;println("f");
		deg=1;
	}
	println("h");
	w.addWire(lineSX,lineSY,lineEX,lineEY);
	println("wiring",lineSX,lineSY,lineEX,lineEY);
	}

	void redraw(){
		w.redraw();
	}

	class Wires{
		ArrayList<Wire> wire = new ArrayList<Wire>();
		// IntList hX= new IntList();
		// IntList hY= new IntList();
		color c;
		int mX,mY,x=0,y=0;
		Wires(color _c){
			c=_c;
		}

		void addWire(int _sX,int _sY,int _eX,int _eY){
			mX=_eX-_sX;mY=_eY-_sY;
			println("mX ",mX,"mY",mY);
			println(abs(mX/10));
			for(int i=0,len=max(abs(mX),abs(mY))/10;i<len;++i){
				wire.add(new Wire(_sX+x,_sY+y,int(_sX+x+Math.signum(mX)*10),int(_sY+y+Math.signum(mY)*10),c));
				wire.get(i).redraw();
				println("aa");
				x+=int(Math.signum(mX)*10);y+=int(Math.signum(mY)*10);
			}
			x=0;y=0;
		}

		int whatClick(){
			for (int i = 0,len=wire.size(); i < len; ++i) {
				if(wire.get(i).isCloss()){
					return i;
				}
			}
			return -1;
		}
		void redraw(){
			for (int i=0,len=wire.size();i<len;++i){
				wire.get(i).redraw();
			}
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
				println(sX,sY,eX,eY);
			}

			void redraw(){
				stroke(co);
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

		class WireGroup{
			IntList wire = new IntList();
			IntList sXs= new IntList();
			IntList sYs= new IntList();
			IntList eXs= new IntList();
			IntList eYs= new IntList();
			// int sX,sY,eX,eY;
			WireGroup(){}

			void addWire(int _sX,int _sY,int _eX,int _eY,int id){
				sX=_sX;
				sY=_sY;
				eX=_eX;
				eY=_eY;
				id
			}
		}
	}
}

// void setup(){

// }

// void draw(){}
