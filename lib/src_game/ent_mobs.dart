part of game;

class EntMan extends EntMob {
	EntMan(int x, int y) : super(x,y);
	
	void drawMob(Graphics g) {
		var img;
		if (moveDir==2) {
			img = content.getImage("humanL.png");
		} else {
			img = content.getImage("humanR.png");
		}
        g.drawImg(img, pos, .5);
	}
}