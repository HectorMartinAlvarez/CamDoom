import java.util.List;
import java.util.ArrayList;
import queasycam.*;

CDoomGame game;

void setup() {
	size(800, 800, P3D);

  QueasyCam cam;
  cam = new QueasyCam(this);

  PVector[] column1 = new PVector[4];
  PVector[] column2 = new PVector[4];
  PVector[] column3 = new PVector[4];
  PVector[] column4 = new PVector[4];
  PVector[] column5 = new PVector[8];
  PVector[] column6 = new PVector[8];
  
  column1[0] = new PVector(189.7, 0, 957.7);
  column1[1] = new PVector(255.3, 0, 957.7);
  column1[2] = new PVector(255.3, 0, 1025.5);
  column1[3] = new PVector(189.7, 0, 1025.5);
  
  column2[0] = new PVector(-131.2, 0, 956.7);
  column2[1] = new PVector(-61.2, 0, 956.7);
  column2[2] = new PVector(-61.2, 0, 1025.5);
  column2[3] = new PVector(-131.2, 0, 1025.5);
  
  column3[0] = new PVector(-448.6, 0, 706.9);
  column3[1] = new PVector(-448.6, 0, 637.5);
  column3[2] = new PVector(-383.7, 0, 637.5);
  column3[3] = new PVector(-383.7, 0, 706.9);
  
  column4[0] = new PVector(-895.9, 0, 775.2);
  column4[1] = new PVector(-895.9, 0, 705.2);
  column4[2] = new PVector(-960.3, 0, 705.2);
  column4[3] = new PVector(-960.3, 0, 775.2);
  
  column5[0] = new PVector(-128.7, 0, 2235.6);
  column5[1] = new PVector(3.5, 0, 2235.6);
  column5[2] = new PVector(3.5, 0, 2309.1);
  column5[3] = new PVector(-58.5, 0, 2312.5);
  column5[4] = new PVector(-58.5, 0, 2361);
  column5[5] = new PVector(3.5, 0, 2363.9);
  column5[6] = new PVector(3.5, 0, 2435.8);
  column5[7] = new PVector(-128.7, 0, 2435.8);
  
  column6[0] = new PVector(-387.9, 0, 2235.6);
  column6[1] = new PVector(-387.9, 0, 2309.1);
  column6[2] = new PVector(-326.6, 0, 2309.1);
  column6[3] = new PVector(-326.6, 0, 2362.4);
  column6[4] = new PVector(-387.9, 0, 2362.5);
  column6[5] = new PVector(-387.9, 0, 2436.9);
  column6[6] = new PVector(-250.5, 0, 2436.9);
  column6[7] = new PVector(-250.5, 0, 2235.6);
  CDoomColumns column_1 = new CDoomColumns(column1);
  CDoomColumns column_2 = new CDoomColumns(column2);
  CDoomColumns column_3 = new CDoomColumns(column3);
  CDoomColumns column_4 = new CDoomColumns(column4);
  CDoomColumns column_5 = new CDoomColumns(column5);
  CDoomColumns column_6 = new CDoomColumns(column6);

	CDoomMap map = new CDoomMap("../map/map/doom2_MAP01_mod.obj", "../map/collisions_MAP01.csv");
  CDoomStairs stairs = new CDoomStairs("../map/stairs.csv");
	CDoomSlayer slayer = new CDoomSlayer(113.5, -75, 762.8, cam);
	game = new CDoomGame(map, slayer, stairs, column_1, column_2, column_3, column_4, column_5, column_6);
}

void draw() {
	background(0);
	game.display();
}
