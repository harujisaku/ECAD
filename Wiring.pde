class Wiring{
	protected int lineStartPosX=0,lineStartPosY=0,lineEndPosX=0,lineEndPosY=0,deg,_ElineStartPosX,_ElineStartPosY,_ElineEndPosX,_ElineEndPosY;
	Wires wires=new Wires();
	Wiring(){
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
}
