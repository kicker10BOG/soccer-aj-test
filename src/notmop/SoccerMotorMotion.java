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
		 motors.stop();
		 System.out.println("-->left end: "+motors.getLeftMotorPos());
		 System.out.println("-->right end: "+motors.getRightMotorPos());
		 
		 System.out.println();

		 System.out.println("goBackward(10)");
		 System.out.println("->left Start: "+motors.getLeftMotorPos());
		 System.out.println("->right Start: "+motors.getRightMotorPos());
		 motors.goBackward(10);
		 motors.stop();
		 System.out.println("-->left end: "+motors.getLeftMotorPos());
		 System.out.println("-->right end: "+motors.getRightMotorPos());
		 
		 System.out.println();

		 System.out.println("goForwardNoSync(30)");
		 System.out.println("->left Start: "+motors.getLeftMotorPos());
		 System.out.println("->right Start: "+motors.getRightMotorPos());
		 motors.goForwardNoSync(30);
		 motors.stop();
		 System.out.println("-->left end: "+motors.getLeftMotorPos());
		 System.out.println("-->right end: "+motors.getRightMotorPos());
		 
		 System.out.println();

		 System.out.println("goBackwardNoSync(10)");
		 System.out.println("->left Start: "+motors.getLeftMotorPos());
		 System.out.println("->right Start: "+motors.getRightMotorPos());
		 motors.goBackwardNoSync(10);
		 motors.stop();
		 motors.stop();
		 System.out.println("-->left end: "+motors.getLeftMotorPos());
		 System.out.println("-->right end: "+motors.getRightMotorPos());

	}
	
	public void stop() {
		// stop motors
	}
	
	public void goForward(int speed) {
		leftMotorPos += speed;
		rightMotorPos += speed;
	}

	public void goBackward(int speed) {
		leftMotorPos -= speed;
		rightMotorPos -= speed;
	}
	
	public void goForwardNoSync(int speed) {
		leftMotorPos += speed;
		rightMotorPos += speed+10.0;
	}
	
	public void goBackwardNoSync(int speed) {
		leftMotorPos -= speed;
		rightMotorPos -= speed+10.0;
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