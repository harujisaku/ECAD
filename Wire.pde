class Wire{
	int lineStartPosX,lineStartPosY,lineEndPosX,lineEndPosY;
	Wire(int _lineStartPosX,int _lineStartPosY,int _lineEndPosX,int _lineEndPosY){
		lineStartPosX=_lineStartPosX;
		lineStartPosY=_lineStartPosY;
		lineEndPosX=_lineEndPosX;
		lineEndPosY=_lineEndPosY;
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
