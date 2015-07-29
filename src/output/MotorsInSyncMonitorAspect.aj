package mop;
import java.io.*;
import java.util.*;
import notmop.SoccerMotorMotion;
import java.util.concurrent.*;
import java.util.concurrent.locks.*;
import java.lang.ref.*;
import com.runtimeverification.rvmonitor.java.rt.*;
import com.runtimeverification.rvmonitor.java.rt.ref.*;
import com.runtimeverification.rvmonitor.java.rt.table.*;
import com.runtimeverification.rvmonitor.java.rt.tablebase.AbstractIndexingTree;
import com.runtimeverification.rvmonitor.java.rt.tablebase.SetEventDelegator;
import com.runtimeverification.rvmonitor.java.rt.tablebase.TableAdopter.Tuple2;
import com.runtimeverification.rvmonitor.java.rt.tablebase.TableAdopter.Tuple3;
import com.runtimeverification.rvmonitor.java.rt.tablebase.IDisableHolder;
import com.runtimeverification.rvmonitor.java.rt.tablebase.IMonitor;
import com.runtimeverification.rvmonitor.java.rt.tablebase.DisableHolder;
import com.runtimeverification.rvmonitor.java.rt.tablebase.TerminatedMonitorCleaner;
import java.util.concurrent.atomic.AtomicInteger;
import org.aspectj.lang.*;

final class MotorsInSyncMonitor_Set extends com.runtimeverification.rvmonitor.java.rt.tablebase.AbstractMonitorSet<MotorsInSyncMonitor> {

	MotorsInSyncMonitor_Set(){
		this.size = 0;
		this.elements = new MotorsInSyncMonitor[4];
	}
	final void event_checkMotorsBefore(SoccerMotorMotion motors) {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			MotorsInSyncMonitor monitor = this.elements[i];
			if(!monitor.isTerminated()){
				elements[numAlive] = monitor;
				numAlive++;

				final MotorsInSyncMonitor monitorfinalMonitor = monitor;
				monitor.Prop_1_event_checkMotorsBefore(motors);
				if(monitorfinalMonitor.MotorsInSyncMonitor_Prop_1_Category_violation) {
					monitorfinalMonitor.Prop_1_handler_violation();
				}
			}
		}
		for(int i = numAlive; i < this.size; i++){
			this.elements[i] = null;
		}
		size = numAlive;
	}
	final void event_motorsInSync(SoccerMotorMotion motors) {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			MotorsInSyncMonitor monitor = this.elements[i];
			if(!monitor.isTerminated()){
				elements[numAlive] = monitor;
				numAlive++;

				final MotorsInSyncMonitor monitorfinalMonitor = monitor;
				monitor.Prop_1_event_motorsInSync(motors);
				if(monitorfinalMonitor.MotorsInSyncMonitor_Prop_1_Category_violation) {
					monitorfinalMonitor.Prop_1_handler_violation();
				}
			}
		}
		for(int i = numAlive; i < this.size; i++){
			this.elements[i] = null;
		}
		size = numAlive;
	}
	final void event_stopInSync(SoccerMotorMotion motors) {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			MotorsInSyncMonitor monitor = this.elements[i];
			if(!monitor.isTerminated()){
				elements[numAlive] = monitor;
				numAlive++;

				final MotorsInSyncMonitor monitorfinalMonitor = monitor;
				monitor.Prop_1_event_stopInSync(motors);
				if(monitorfinalMonitor.MotorsInSyncMonitor_Prop_1_Category_violation) {
					monitorfinalMonitor.Prop_1_handler_violation();
				}
			}
		}
		for(int i = numAlive; i < this.size; i++){
			this.elements[i] = null;
		}
		size = numAlive;
	}
}

class MotorsInSyncMonitor extends com.runtimeverification.rvmonitor.java.rt.tablebase.AbstractAtomicMonitor implements Cloneable, com.runtimeverification.rvmonitor.java.rt.RVMObject {
	protected Object clone() {
		try {
			MotorsInSyncMonitor ret = (MotorsInSyncMonitor) super.clone();
			return ret;
		}
		catch (CloneNotSupportedException e) {
			throw new InternalError(e.toString());
		}
	}

	float prevLeftMotorPos = 0;

	float prevRightMotorPos = 0;

	static final int Prop_1_transition_checkMotorsBefore[] = {1, 1, 3, 3};;
	static final int Prop_1_transition_motorsInSync[] = {0, 0, 3, 3};;
	static final int Prop_1_transition_stopInSync[] = {2, 0, 3, 3};;

	volatile boolean MotorsInSyncMonitor_Prop_1_Category_violation = false;

	private final AtomicInteger pairValue;

	MotorsInSyncMonitor() {
		this.pairValue = new AtomicInteger(this.calculatePairValue(-1, 0) ) ;

	}

	@Override public final int getState() {
		return this.getState(this.pairValue.get() ) ;
	}
	@Override public final int getLastEvent() {
		return this.getLastEvent(this.pairValue.get() ) ;
	}
	private final int getState(int pairValue) {
		return (pairValue & 3) ;
	}
	private final int getLastEvent(int pairValue) {
		return (pairValue >> 2) ;
	}
	private final int calculatePairValue(int lastEvent, int state) {
		return (((lastEvent + 1) << 2) | state) ;
	}

	private final int handleEvent(int eventId, int[] table) {
		int nextstate;
		while (true) {
			int oldpairvalue = this.pairValue.get() ;
			int oldstate = this.getState(oldpairvalue) ;
			nextstate = table [ oldstate ];
			int nextpairvalue = this.calculatePairValue(eventId, nextstate) ;
			if (this.pairValue.compareAndSet(oldpairvalue, nextpairvalue) ) {
				break;
			}
		}
		return nextstate;
	}

	final boolean Prop_1_event_checkMotorsBefore(SoccerMotorMotion motors) {
		{
			System.out.println("go* starting!");
			this.prevLeftMotorPos = motors.getLeftMotorPos();
			this.prevRightMotorPos = motors.getRightMotorPos();
		}

		int nextstate = this.handleEvent(0, Prop_1_transition_checkMotorsBefore) ;
		this.MotorsInSyncMonitor_Prop_1_Category_violation = nextstate == 2;

		return true;
	}

	final boolean Prop_1_event_motorsInSync(SoccerMotorMotion motors) {
		{
			if ( ! (Math.abs(Math.abs(motors.getLeftMotorPos() - this.prevLeftMotorPos) - Math.abs(motors.getRightMotorPos() - this.prevRightMotorPos)) < motors.getSyncThresh()) ) {
				return false;
			}
			{
				System.out.println("go* ending!");
				System.out.println("diff in left: " + Math.abs(motors.getLeftMotorPos() - this.prevLeftMotorPos));
				System.out.println("diff in right: " + Math.abs(motors.getRightMotorPos() - this.prevRightMotorPos));
			}
		}

		int nextstate = this.handleEvent(1, Prop_1_transition_motorsInSync) ;
		this.MotorsInSyncMonitor_Prop_1_Category_violation = nextstate == 2;

		return true;
	}

	final boolean Prop_1_event_stopInSync(SoccerMotorMotion motors) {
		{
			System.out.println("stop Worked!");
		}

		int nextstate = this.handleEvent(2, Prop_1_transition_stopInSync) ;
		this.MotorsInSyncMonitor_Prop_1_Category_violation = nextstate == 2;

		return true;
	}

	final void Prop_1_handler_violation (){
		{
			System.out.println("motors out of sync at line" + com.runtimeverification.rvmonitor.java.rt.ViolationRecorder.getLineOfCode());
		}

	}

	final void reset() {
		this.pairValue.set(this.calculatePairValue(-1, 0) ) ;

		MotorsInSyncMonitor_Prop_1_Category_violation = false;
	}

	// RVMRef_motors was suppressed to reduce memory overhead

	//alive_parameters_0 = [SoccerMotorMotion motors]
	boolean alive_parameters_0 = true;

	@Override
	protected final void terminateInternal(int idnum) {
		int lastEvent = this.getLastEvent();

		switch(idnum){
			case 0:
			alive_parameters_0 = false;
			break;
		}
		switch(lastEvent) {
			case -1:
			return;
			case 0:
			//checkMotorsBefore
			//alive_motors
			if(!(alive_parameters_0)){
				RVM_terminated = true;
				return;
			}
			break;

			case 1:
			//motorsInSync
			//alive_motors
			if(!(alive_parameters_0)){
				RVM_terminated = true;
				return;
			}
			break;

			case 2:
			//stopInSync
			//alive_motors
			if(!(alive_parameters_0)){
				RVM_terminated = true;
				return;
			}
			break;

		}
		return;
	}

	public static int getNumberOfEvents() {
		return 3;
	}

	public static int getNumberOfStates() {
		return 4;
	}

}

class MotorsInSyncRuntimeMonitor implements com.runtimeverification.rvmonitor.java.rt.RVMObject {
	private static com.runtimeverification.rvmonitor.java.rt.map.RVMMapManager MotorsInSyncMapManager;
	static {
		MotorsInSyncMapManager = new com.runtimeverification.rvmonitor.java.rt.map.RVMMapManager();
		MotorsInSyncMapManager.start();
	}

	// Declarations for the Lock
	static final ReentrantLock MotorsInSync_RVMLock = new ReentrantLock();
	static final Condition MotorsInSync_RVMLock_cond = MotorsInSync_RVMLock.newCondition();

	private static boolean MotorsInSync_activated = false;

	// Declarations for Indexing Trees
	private static Object MotorsInSync_motors_Map_cachekey_motors;
	private static MotorsInSyncMonitor MotorsInSync_motors_Map_cachevalue;
	private static final MapOfMonitor<MotorsInSyncMonitor> MotorsInSync_motors_Map = new MapOfMonitor<MotorsInSyncMonitor>(0) ;

	public static int cleanUp() {
		int collected = 0;
		// indexing trees
		collected += MotorsInSync_motors_Map.cleanUpUnnecessaryMappings();
		return collected;
	}

	// Removing terminated monitors from partitioned sets
	static {
		TerminatedMonitorCleaner.start() ;
	}
	// Setting the behavior of the runtime library according to the compile-time option
	static {
		RuntimeOption.enableFineGrainedLock(false) ;
	}

	public static final void MotorsInSync_checkMotorsBeforeEvent(SoccerMotorMotion motors) {
		MotorsInSync_activated = true;
		while (!MotorsInSync_RVMLock.tryLock()) {
			Thread.yield();
		}

		CachedWeakReference wr_motors = null;
		MapOfMonitor<MotorsInSyncMonitor> matchedLastMap = null;
		MotorsInSyncMonitor matchedEntry = null;
		boolean cachehit = false;
		if ((motors == MotorsInSync_motors_Map_cachekey_motors) ) {
			matchedEntry = MotorsInSync_motors_Map_cachevalue;
			cachehit = true;
		}
		else {
			wr_motors = new CachedWeakReference(motors) ;
			{
				// FindOrCreateEntry
				MapOfMonitor<MotorsInSyncMonitor> itmdMap = MotorsInSync_motors_Map;
				matchedLastMap = itmdMap;
				MotorsInSyncMonitor node_motors = MotorsInSync_motors_Map.getNodeEquivalent(wr_motors) ;
				matchedEntry = node_motors;
			}
		}
		// D(X) main:1
		if ((matchedEntry == null) ) {
			if ((wr_motors == null) ) {
				wr_motors = new CachedWeakReference(motors) ;
			}
			// D(X) main:4
			MotorsInSyncMonitor created = new MotorsInSyncMonitor() ;
			matchedEntry = created;
			matchedLastMap.putNode(wr_motors, created) ;
		}
		// D(X) main:8--9
		final MotorsInSyncMonitor matchedEntryfinalMonitor = matchedEntry;
		matchedEntry.Prop_1_event_checkMotorsBefore(motors);
		if(matchedEntryfinalMonitor.MotorsInSyncMonitor_Prop_1_Category_violation) {
			matchedEntryfinalMonitor.Prop_1_handler_violation();
		}

		if ((cachehit == false) ) {
			MotorsInSync_motors_Map_cachekey_motors = motors;
			MotorsInSync_motors_Map_cachevalue = matchedEntry;
		}

		MotorsInSync_RVMLock.unlock();
	}

	public static final void MotorsInSync_motorsInSyncEvent(SoccerMotorMotion motors) {
		MotorsInSync_activated = true;
		while (!MotorsInSync_RVMLock.tryLock()) {
			Thread.yield();
		}

		CachedWeakReference wr_motors = null;
		MapOfMonitor<MotorsInSyncMonitor> matchedLastMap = null;
		MotorsInSyncMonitor matchedEntry = null;
		boolean cachehit = false;
		if ((motors == MotorsInSync_motors_Map_cachekey_motors) ) {
			matchedEntry = MotorsInSync_motors_Map_cachevalue;
			cachehit = true;
		}
		else {
			wr_motors = new CachedWeakReference(motors) ;
			{
				// FindOrCreateEntry
				MapOfMonitor<MotorsInSyncMonitor> itmdMap = MotorsInSync_motors_Map;
				matchedLastMap = itmdMap;
				MotorsInSyncMonitor node_motors = MotorsInSync_motors_Map.getNodeEquivalent(wr_motors) ;
				matchedEntry = node_motors;
			}
		}
		// D(X) main:1
		if ((matchedEntry == null) ) {
			if ((wr_motors == null) ) {
				wr_motors = new CachedWeakReference(motors) ;
			}
			// D(X) main:4
			MotorsInSyncMonitor created = new MotorsInSyncMonitor() ;
			matchedEntry = created;
			matchedLastMap.putNode(wr_motors, created) ;
		}
		// D(X) main:8--9
		final MotorsInSyncMonitor matchedEntryfinalMonitor = matchedEntry;
		matchedEntry.Prop_1_event_motorsInSync(motors);
		if(matchedEntryfinalMonitor.MotorsInSyncMonitor_Prop_1_Category_violation) {
			matchedEntryfinalMonitor.Prop_1_handler_violation();
		}

		if ((cachehit == false) ) {
			MotorsInSync_motors_Map_cachekey_motors = motors;
			MotorsInSync_motors_Map_cachevalue = matchedEntry;
		}

		MotorsInSync_RVMLock.unlock();
	}

	public static final void MotorsInSync_stopInSyncEvent(SoccerMotorMotion motors) {
		MotorsInSync_activated = true;
		while (!MotorsInSync_RVMLock.tryLock()) {
			Thread.yield();
		}

		CachedWeakReference wr_motors = null;
		MapOfMonitor<MotorsInSyncMonitor> matchedLastMap = null;
		MotorsInSyncMonitor matchedEntry = null;
		boolean cachehit = false;
		if ((motors == MotorsInSync_motors_Map_cachekey_motors) ) {
			matchedEntry = MotorsInSync_motors_Map_cachevalue;
			cachehit = true;
		}
		else {
			wr_motors = new CachedWeakReference(motors) ;
			{
				// FindOrCreateEntry
				MapOfMonitor<MotorsInSyncMonitor> itmdMap = MotorsInSync_motors_Map;
				matchedLastMap = itmdMap;
				MotorsInSyncMonitor node_motors = MotorsInSync_motors_Map.getNodeEquivalent(wr_motors) ;
				matchedEntry = node_motors;
			}
		}
		// D(X) main:1
		if ((matchedEntry == null) ) {
			if ((wr_motors == null) ) {
				wr_motors = new CachedWeakReference(motors) ;
			}
			// D(X) main:4
			MotorsInSyncMonitor created = new MotorsInSyncMonitor() ;
			matchedEntry = created;
			matchedLastMap.putNode(wr_motors, created) ;
		}
		// D(X) main:8--9
		final MotorsInSyncMonitor matchedEntryfinalMonitor = matchedEntry;
		matchedEntry.Prop_1_event_stopInSync(motors);
		if(matchedEntryfinalMonitor.MotorsInSyncMonitor_Prop_1_Category_violation) {
			matchedEntryfinalMonitor.Prop_1_handler_violation();
		}

		if ((cachehit == false) ) {
			MotorsInSync_motors_Map_cachekey_motors = motors;
			MotorsInSync_motors_Map_cachevalue = matchedEntry;
		}

		MotorsInSync_RVMLock.unlock();
	}

}


public aspect MotorsInSyncMonitorAspect implements com.runtimeverification.rvmonitor.java.rt.RVMObject {
	public MotorsInSyncMonitorAspect(){
	}

	// Declarations for the Lock
	static ReentrantLock MotorsInSync_MOPLock = new ReentrantLock();
	static Condition MotorsInSync_MOPLock_cond = MotorsInSync_MOPLock.newCondition();

	pointcut MOP_CommonPointCut() : !within(com.runtimeverification.rvmonitor.java.rt.RVMObject+) && !adviceexecution()&& BaseAspect.notwithin();
	pointcut MotorsInSync_checkMotorsBefore(SoccerMotorMotion motors) : (call(* SoccerMotorMotion.go*(*)) && target(motors)) && MOP_CommonPointCut();
	before (SoccerMotorMotion motors) : MotorsInSync_checkMotorsBefore(motors) {
		MotorsInSyncRuntimeMonitor.MotorsInSync_checkMotorsBeforeEvent(motors);
	}

	pointcut MotorsInSync_motorsInSync(SoccerMotorMotion motors) : (call(* SoccerMotorMotion.go*(*)) && target(motors)) && MOP_CommonPointCut();
	after (SoccerMotorMotion motors) : MotorsInSync_motorsInSync(motors) {
		MotorsInSyncRuntimeMonitor.MotorsInSync_motorsInSyncEvent(motors);
	}

	pointcut MotorsInSync_stopInSync(SoccerMotorMotion motors) : (call(* SoccerMotorMotion.stop()) && target(motors)) && MOP_CommonPointCut();
	after (SoccerMotorMotion motors) : MotorsInSync_stopInSync(motors) {
		MotorsInSyncRuntimeMonitor.MotorsInSync_stopInSyncEvent(motors);
	}

}
