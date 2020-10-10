class Wires{
	protected ArrayList<Wire> wire = new ArrayList<Wire>();
	ArrayList<ArrayList<Integer>> id = new ArrayList<ArrayList<Integer>>();
	Wires(){
	}

	void remove(int _id){
		if(_id>=wire.size()||_id<0){
			return;
		}
		wire.remove(_id);
		reGroupWire();
	}

	private void addWire(int _lineStartPosX,int _lineStartPosY,int _lineEndPosX,int _lineEndPosY){
		wire.add(new Wire(_lineStartPosX,_lineStartPosY,_lineEndPosX,_lineEndPosY));
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
