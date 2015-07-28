package notmop;

public class SoccerMotorMotion {
	
	private float leftMotorPos;
	private float rightMotorPos;
	private float syncThresh;
	
	public SoccerMotorMotion() {
		leftMotorPos = 0;
		rightMotorPos = 0;
		syncThresh = 5;
	}
	
	public static void main(String[] args) {
		 SoccerMotorMotion motors = new SoccerMotorMotion();
		 System.out.println("goForward(20)");
		 System.out.println("->left Start: "+motors.getLeftMotorPos());
		 System.out.println("->right Start: "+motors.getRightMotorPos());
		 motors.goForward(20);
		 System.out.println("-->left end: "+motors.getLeftMotorPos());
		 System.out.println("-->right end: "+motors.getRightMotorPos());

		 System.out.println("goBackward(10)");
		 System.out.println("->left Start: "+motors.getLeftMotorPos());
		 System.out.println("->right Start: "+motors.getRightMotorPos());
		 motors.goBackward(10);
		 System.out.println("-->left end: "+motors.getLeftMotorPos());
		 System.out.println("-->right end: "+motors.getRightMotorPos());

		 System.out.println("goForwardNoSync(30)");
		 System.out.println("->left Start: "+motors.getLeftMotorPos());
		 System.out.println("->right Start: "+motors.getRightMotorPos());
		 motors.goForwardNoSync(30);
		 System.out.println("-->left end: "+motors.getLeftMotorPos());
		 System.out.println("-->right end: "+motors.getRightMotorPos());

		 System.out.println("goBackwardNoSync(10)");
		 System.out.println("->left Start: "+motors.getLeftMotorPos());
		 System.out.println("->right Start: "+motors.getRightMotorPos());
		 motors.goBackwardNoSync(10);
		 System.out.println("-->left end: "+motors.getLeftMotorPos());
		 System.out.println("-->right end: "+motors.getRightMotorPos());

	}
	
	public float[] goForward(int speed) {
		leftMotorPos += speed;
		rightMotorPos += speed;
		float[] vals = {leftMotorPos, rightMotorPos};
		return vals;
	}
	public float[] goBackward(int speed) {
		leftMotorPos -= speed;
		rightMotorPos -= speed;
		float[] vals = {leftMotorPos, rightMotorPos};
		return vals;
	}
	
	public float[] goForwardNoSync(int speed) {
		leftMotorPos += speed;
		rightMotorPos += speed+10.0;
		float[] vals = {leftMotorPos, rightMotorPos};
		return vals;
	}
	
	public float[] goBackwardNoSync(int speed) {
		leftMotorPos -= speed;
		rightMotorPos -= speed+10.0;
		float[] vals = {leftMotorPos, rightMotorPos};
		return vals;
	}
	
	public float getLeftMotorPos() {
		return leftMotorPos;
	}
	
	public float getRightMotorPos() {
		return rightMotorPos; 
	}
	
	public float getSyncThresh() {
		return syncThresh; 
	}
}