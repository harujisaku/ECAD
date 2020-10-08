class Wiring{
	protected color lineColor;
	protected int lineStartPosX=0,lineStartPosY=0,lineEndPosX=0,lineEndPosY=0,deg,_ElineStartPosX,_ElineStartPosY,_ElineEndPosX,_ElineEndPosY;
	PGraphics base;
	Wires wires;
	Wiring(color _lineColor,PGraphics _base){
		lineColor=_lineColor;
		base=_base;
		wires =new Wires(color(255,0,0),base);
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

	void moveWire(int _id,int _moveToX,int _moveToY){
		wires.moveWire(_id,_moveToX,_moveToY);
	}
	void relativeMoveWire(int _id,int _moveX,int _moveY){
		wires.relativeMoveWire(_id,_moveX,_moveY);
	}
	void groupMoveWire(int _groupId,int _moveX,int _moveY){
		wires.groupMoveWire(_groupId,_moveX,_moveY);
	}
	void groupMoveFromId(int _id,int _moveToX,int _moveToY){
		wires.groupMoveFromId(_id,_moveToX,_moveToY);
	}

	void groupRelativeMoveFromId(int _id,int _moveX,int _moveY){
		wires.groupRelativeMoveFromId(_id,_moveX,_moveY);
	}

	void update(){
		wires.update();
		// line(lineStartPosX,lineStartPosY,lineEndPosX,lineEndPosY);
	}

	void remove(int _id){
		wires.remove(_id);
	}

	void setStartPos(int _id,int _setPosX,int _setPosY){
		translate(_setPosX,_setPosY);
		float degFloat = degrees(atan2(getLineEndPosY(_id)-_setPosY,getLineEndPosX(_id)-_setPosX))+180;
		translate(-_setPosX,-_setPosY);
		deg=int(degFloat);
		_ElineEndPosX=_setPosX;
		_ElineEndPosY=_setPosY;
		_ElineStartPosX=getLineEndPosX(_id);
		_ElineStartPosY=getLineEndPosY(_id);
		lineAngleFormating(20);
		// line(lineStartPosX,lineStartPosY,lineEndPosX,lineEndPosY);
		wires.setEndPos(_id,lineStartPosX,lineStartPosY);
		wires.setStartPos(_id,lineEndPosX,lineEndPosY);
	}

	void setEndPos(int _id,int _setPosX,int _setPosY){
		translate(getLineStartPosX(_id),getLineStartPosY(_id));
		float degFloat = degrees(atan2(_setPosY-getLineStartPosY(_id),_setPosX-getLineStartPosX(_id)))+180;
		translate(-getLineStartPosX(_id),-getLineStartPosY(_id));
		deg=int(degFloat);
		_ElineEndPosX=_setPosX;
		_ElineEndPosY=_setPosY;
		_ElineStartPosX=getLineStartPosX(_id);
		_ElineStartPosY=getLineStartPosY(_id);
		lineAngleFormating(20);
		println(lineStartPosX,lineStartPosY,lineEndPosX,lineEndPosY);
		wires.setEndPos(_id,lineStartPosX,lineStartPosY);
		wires.setStartPos(_id,lineEndPosX,lineEndPosY);
	}

	int getTouchingWire(int _checkPointX,int _checkPointY){
		return wires.getTouchingWire(_checkPointX,_checkPointY);
	}

	int getTouchingStartPoint(int _checkPointX,int _checkPointY){
		return wires.getTouchingStartPoint(_checkPointX,_checkPointY);
	}
	int getTouchingEndPoint(int _checkPointX,int _checkPointY){
		return wires.getTouchingEndPoint(_checkPointX,_checkPointY);
	}

	public void groupWire(){
		wires.groupWire();
	}

	void reGroupWire(){
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

	int getLineStartPosX(int _id){
		return wires.getLineStartPosX(_id);
	}
	int getLineStartPosY(int _id){
		return wires.getLineStartPosY(_id);
	}
	int getLineEndPosX(int _id){
		return wires.getLineEndPosX(_id);
	}
	int getLineEndPosY(int _id){
		return wires.getLineEndPosY(_id);
	}
	protected class Wires{
		color lineColor;
		PGraphics base;
		protected ArrayList<Wire> wire = new ArrayList<Wire>();
		ArrayList<ArrayList<Integer>> id = new ArrayList<ArrayList<Integer>>();
		Wires(color _lineColor,PGraphics _base){
			lineColor=_lineColor;
			base=_base;
		}

		void update(){
			for(int i = 0,len=wire.size();i<len;i++){
				wire.get(i).redraw();
			}
		}

		void remove(int _id){
			if(_id>=wire.size()||_id<0){
				return;
			}
			wire.remove(_id);
			reGroupWire();
		}

		private void addWire(int _lineStartPosX,int _lineStartPosY,int _lineEndPosX,int _lineEndPosY){
			wire.add(new Wire(_lineStartPosX,_lineStartPosY,_lineEndPosX,_lineEndPosY,lineColor,base));
			ArrayList<Integer> a = new ArrayList<Integer>();
			a.add(wire.size()-1);
			id.add(a);
			printArray(id);
		}

		void moveWire(int _id,int _moveToX,int _moveToY){
			wire.get(_id).move(_moveToX,_moveToY);
		}
		void relativeMoveWire(int _id,int _moveX,int _moveY){
			wire.get(_id).relativeMove(_moveX,_moveY);
		}

		void groupMoveWire(int _groupId,int _moveX,int _moveY){
			for(int i = 0,len=id.get(_groupId).size();i<len;i++){
				wire.get(id.get(_groupId).get(i)).relativeMove(_moveX,_moveY);
			}
		}

		void groupMoveFromId(int _id,int _moveToX,int _moveToY){
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

		void groupRelativeMoveFromId(int _id,int _moveX,int _moveY){
			for(int i = 0,len=id.size();i<len;i++){
				if (id.get(i).indexOf(_id)>=0){
					groupMoveWire(i,_moveX,_moveY);
				}
			}
		}

		public void groupWire(){
			while(groupWireLoop()){}
		}

		void decompositionGroup(){
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

		int getTouchingWire(int _checkPointX,int _checkPointY){
			for(int i = 0,len=wire.size();i<len;i++){
				if(wire.get(i).isTouching(_checkPointX,_checkPointY)){
					return i;
				}
			}
			return -1;
		}
		int getLineStartPosX(int _id){
			return wire.get(_id).lineStartPosX;
		}
		int getLineStartPosY(int _id){
			return wire.get(_id).lineStartPosY;
		}
		int getLineEndPosX(int _id){
			return wire.get(_id).lineEndPosX;
		}
		int getLineEndPosY(int _id){
			return wire.get(_id).lineEndPosY;
		}

		int getTouchingStartPoint(int _checkPointX,int _checkPointY){
			for(int i = 0,len=wire.size();i<len;i++){
				if (getLineStartPosX(i)==_checkPointX&&getLineStartPosY(i)==_checkPointY){
					return i;
				}
			}
			return -1;
		}
		int getTouchingEndPoint(int _checkPointX,int _checkPointY){
			for(int i = 0,len=wire.size();i<len;i++){
				if (getLineEndPosX(i)==_checkPointX&&getLineEndPosY(i)==_checkPointY){
					return i;
				}
			}
			return -1;
		}

		void setStartPos(int _id,int _setPosX,int _setPosY){
			wire.get(_id).lineStartPosX=_setPosX;
			wire.get(_id).lineStartPosY=_setPosY;
		}
		void setEndPos(int _id,int _setPosX,int _setPosY){
			wire.get(_id).lineEndPosX=_setPosX;
			wire.get(_id).lineEndPosY=_setPosY;
		}

	}

	class Wire{
		int lineStartPosX,lineStartPosY,lineEndPosX,lineEndPosY;
		color lineColor;
		PGraphics base;
		Wire(int _lineStartPosX,int _lineStartPosY,int _lineEndPosX,int _lineEndPosY,color _lineColor,PGraphics _base){
			lineStartPosX=_lineStartPosX;
			lineStartPosY=_lineStartPosY;
			lineEndPosX=_lineEndPosX;
			lineEndPosY=_lineEndPosY;
			lineColor=_lineColor;
			base=_base;
		}

		void move(int _moveToX,int _moveToY){
			int moveX,moveY;
			moveX=_moveToX-lineStartPosX;
			moveY=_moveToY-lineStartPosY;
			lineStartPosX+=moveX;
			lineStartPosY+=moveY;
			lineEndPosX+=moveX;
			lineEndPosY+=moveY;
		}

		void relativeMove(int _moveX,int _moveY){
			lineStartPosX+=_moveX;
			lineStartPosY+=_moveY;
			lineEndPosX+=_moveX;
			lineEndPosY+=_moveY;
		}

		void redraw(){
			stroke(lineColor);
			base.beginDraw();
			base.line(lineStartPosX,lineStartPosY,lineEndPosX,lineEndPosY);
			base.rect(lineStartPosX,lineStartPosY,5,5);
			base.endDraw();
		}

		boolean isCloss(int cx,int cy,int dx,int dy) {
			int ax=lineStartPosX, ay=lineStartPosY, bx=lineEndPosX, by=lineEndPosY;
			float ta = (((cx - dx) * (ay - cy)) + ((cy - dy) * (cx - ax)));
			float tb = (((cx - dx) * (by - cy)) + ((cy - dy) * (cx - bx)));
			float tc = (((ax - bx) * (cy - ay)) + ((ay - by) * (ax - cx)));
			float td = (((ax - bx) * (dy - ay)) + ((ay - by) * (ax - dx)));
			if (int(tc * td) <= 0 && int(ta * tb) <= 0){
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
