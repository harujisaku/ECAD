class Wiring{
	protected color lineColor;
	protected int lineStartPosX,lineStartPosY,lineEndPosX,lineEndPosY,deg,_ElineStartPosX,_ElineStartPosY,_ElineEndPosX,_ElineEndPosY;
	Wires wires=new Wires(color(255,0,0));
	Wiring(color _lineColor){
		lineColor=_lineColor;
	}
	void addWire(int _lineStartPosX,int _lineStartPosY,int _lineEndPosX,int _lineEndPosY){
		translate(_lineStartPosX,_lineStartPosY);
		float degFloat = degrees(atan2(_lineEndPosY-_lineStartPosY,_lineEndPosX-_lineStartPosX))+180;
		translate(-_lineStartPosX,-_lineStartPosY);
		deg=int(degFloat);
		_ElineStartPosX=_lineStartPosX;
		_ElineStartPosY=_lineStartPosY;
		_ElineEndPosX=_lineEndPosX;
		_ElineEndPosY=_lineEndPosY;
		lineAngleFormating(20);
		wires.addWire(lineStartPosX,lineStartPosY,lineEndPosX,lineEndPosY);
	}

	void update(){
		wires.update();
	}

	public void groupWire(){
		wires.groupWire();
	}

	private void lineAngleFormating(int decisionRange){
		if (deg<=360-decisionRange&&deg>=270+decisionRange){
			lineStartPosX=_ElineStartPosX;
			lineStartPosY=_ElineStartPosY;
			lineEndPosX=_ElineEndPosX;
			lineEndPosY=_ElineStartPosY-_ElineEndPosX+_ElineStartPosX;
		}else if(deg<=90-decisionRange&&deg>=decisionRange){
			lineStartPosX=_ElineEndPosX;
			lineStartPosY=_ElineStartPosY+_ElineEndPosX-lineStartPosX;
			lineEndPosX=_ElineStartPosX;
			lineEndPosY=_ElineStartPosY;
		}else if(deg<=180-decisionRange&&deg>=90+decisionRange){
			lineStartPosX=_ElineStartPosX;
			lineStartPosY=_ElineStartPosY;
			lineEndPosX=_ElineStartPosY-_ElineEndPosY+_ElineStartPosX;
			lineEndPosY=_ElineEndPosY;
		}else if(deg<=270-decisionRange&&deg>=180+decisionRange){
			lineStartPosX=_ElineStartPosX;
			lineStartPosY=_ElineStartPosY;
			lineEndPosX=_ElineStartPosX+_ElineEndPosY-_ElineStartPosY;
			lineEndPosY=_ElineEndPosY;
		}else if(deg<=decisionRange||deg>=360-decisionRange){
			lineStartPosX=_ElineEndPosX;
			lineEndPosY=_ElineStartPosY;
			lineEndPosX=_ElineStartPosX;
			lineStartPosY=_ElineStartPosY;
		}else if(deg<=180+decisionRange&&deg>=180-decisionRange){
			lineStartPosX=_ElineStartPosX;
			lineStartPosY=_ElineStartPosY;
			lineEndPosX=_ElineEndPosX;
			lineEndPosY=_ElineStartPosY;
		}else if(deg<=90+decisionRange&&deg>=90-decisionRange){
			lineStartPosX=_ElineStartPosX;
			lineStartPosY=_ElineEndPosY;
			lineEndPosX=_ElineStartPosX;
			lineEndPosY=_ElineStartPosY;
		}else if(deg<=270+decisionRange&&deg>=270-decisionRange){
			lineStartPosX=_ElineStartPosX;
			lineStartPosY=_ElineStartPosY;
			lineEndPosX=_ElineStartPosX;
			lineEndPosY=_ElineEndPosY;
		}else{
			return;
		}
	}

	protected class Wires{
		color lineColor;
		protected ArrayList<Wire> wire = new ArrayList<Wire>();
		ArrayList<ArrayList<Integer>> id = new ArrayList<ArrayList<Integer>>();
		Wires(color _lineColor){
			lineColor=_lineColor;
		}

		void update(){
			for(int i = 0,len=wire.size();i<len;i++){
				wire.get(i).redraw();
			}
		}

		private void addWire(int _lineStartPosX,int _lineStartPosY,int _lineEndPosX,int _lineEndPosY){
			wire.add(new Wire(_lineStartPosX,_lineStartPosY,_lineEndPosX,_lineEndPosY,lineColor));
			ArrayList<Integer> a = new ArrayList<Integer>();
			a.add(wire.size()-1);
			id.add(a);
			printArray(id);
		}

		public void groupWire(){
			while(groupWireLoop()){}
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


	}

	class Wire{
		int lineStartPosX,lineStartPosY,lineEndPosX,lineEndPosY;
		color lineColor;
		Wire(int _lineStartPosX,int _lineStartPosY,int _lineEndPosX,int _lineEndPosY,color _lineColor){
			lineStartPosX=_lineStartPosX;
			lineStartPosY=_lineStartPosY;
			lineEndPosX=_lineEndPosX;
			lineEndPosY=_lineEndPosY;
			lineColor=_lineColor;
		}


		void redraw(){
			stroke(lineColor);
			line(lineStartPosX,lineStartPosY,lineEndPosX,lineEndPosY);
		}

		boolean isCloss(int cx,int cy,int dx,int dy) {
			int ax=lineStartPosX, ay=lineStartPosY, bx=lineEndPosX, by=lineEndPosY;
			float ta = (((cx - dx) * (ay - cy)) + ((cy - dy) * (cx - ax)));
			float tb = (((cx - dx) * (by - cy)) + ((cy - dy) * (cx - bx)));
			float tc = (((ax - bx) * (cy - ay)) + ((ay - by) * (ax - cx)));
			float td = (((ax - bx) * (dy - ay)) + ((ay - by) * (ax - dx)));
			if (int(tc * td) < 0 && int(ta * tb) < 0){
					return true;
				}
				return false;
			}

		boolean isTouching(int checkPointX,int checkPointY){
			float l1=sqrt(sq(lineEndPosX-lineStartPosX)+(sq(lineEndPosY-lineStartPosY)));
			float l2=sqrt(sq(checkPointX-lineStartPosX)+(sq(checkPointY-lineStartPosY)));
			int a=int((lineEndPosX-lineStartPosX)*(checkPointX-lineStartPosX)+(lineEndPosY-lineStartPosY)*(checkPointY-lineStartPosY));
			int b=int(l1*l2);
			if(a==b&&l1>=l2){
				return true;
			}
			return false;
		}
	}
}
