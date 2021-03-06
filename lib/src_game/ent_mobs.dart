part of game;

class EntMan extends EntMob {
	EntMan(int x, int y) : super(x,y);
	
	bool king=false;
	
	void drawMob(Graphics g) {
		var img;
		if (task=="dead")
			img = content.getImage("humanDead.png");
		else if (task=="fight") {
			img = content.getImage(rand.nextBool()?"humanR.png":"humanL.png");
		}
		else if (moveDir==1) {
			img = content.getImage("humanR.png");
		} else if (moveDir==2) {
			img = content.getImage("humanL.png");
		} else if (moveDir==4) {
			img = content.getImage("humanB.png");
		} else {
			img = content.getImage("humanF.png");
		}
		
		if (task=="fight")
        	g.drawImg(img, pos+new Vector(rand.nextDouble()*20-10,rand.nextDouble()*20-10), .5);
		else
			g.drawImg(img, pos, .5);
		
		if (king) {
			Vector offset;
			if (moveDir==1)
				offset= new Vector(-8,-12);
			else if (moveDir==2)
				offset= new Vector(10,-8);
			else
				offset = new Vector(0,-14);
			
			g.drawImg(content.getImage("crown.png"), pos+offset, .3);
		}
	}
	
	@override
	void signalCollide(GameEntity other) {
		GameScene s = scene;
        bool cw = s.commonwealth;
		if (other is EntTree) {
			if (rand.nextInt(cw?100:1000)==0) {
				other.delete();
				if (cw) {
					if (king) {
						s.addEnt(new EntHouse(pos*1,true));
					} else {
						if (rand.nextInt(4)==0)
							s.addEnt(new EntHouse(pos*1,false));
					}
				} else {
					doFire();
				}
			}
		} else if (other is EntCritter) {
			if (rand.nextInt(100)==0) {
				other.delete();
				if (!cw)
					doFire();
			}
		} else if (other is EntMan) {
			GameScene s = scene;
			if (other.task=="dead" || (task!="fight" && other.task=="fight") || s.commonwealth) {
				if (task=="fight")
					task="wander";
				return;
			}
			if (rand.nextInt(100)==0) {
				if (task=="fight") {
					if (rand.nextInt(3)==0) {
						die();
					} else {
						task="wander";
					}
					other.die();
				} else {
					setFight();
					other.setFight();
				}
				
				
				//other.delete();
				//doFire();
			}
		}
	}
	
	void doFire() {
		scene.addEnt(new EntCampfire(pos+new Vector(40,0)));
		setWait(2);
	}
	
	bool getLeisure() {
		GameScene s = scene;
		if (s.commonwealth)
			return rand.nextInt(5)==0;
		return false;
	}
	
	int getWanderLen() {
		GameScene s = scene;
		if (s.commonwealth)
			return 30;
		return 10;
	}
}

class EntCritter extends EntMob {
	EntCritter(int x, int y) : super(x,y);
	
	void drawMob(Graphics g) {
		var img;
		
		if (moveDir==3)
        	img = content.getImage("rabbit2.png");
        else
			img = content.getImage("rabbit.png");
        g.drawImg(img, pos, .5);
	}
}