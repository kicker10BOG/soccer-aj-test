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
	final void event_testEvent() {
		int numAlive = 0 ;
		for(int i = 0; i < this.size; i++){
			MotorsInSyncMonitor monitor = this.elements[i];
			if(!monitor.isTerminated()){
				elements[numAlive] = monitor;
				numAlive++;

				final MotorsInSyncMonitor monitorfinalMonitor = monitor;
				monitor.Prop_1_event_testEvent();
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

interface IMotorsInSyncMonitor extends IMonitor, IDisableHolder {
}

class MotorsInSyncDisableHolder extends DisableHolder implements IMotorsInSyncMonitor {
	MotorsInSyncDisableHolder(long tau) {
		super(tau);
	}

	@Override
	public final boolean isTerminated() {
		return false;
	}

	@Override
	public int getLastEvent() {
		return -1;
	}

	@Override
	public int getState() {
		return -1;
	}

}

class MotorsInSyncMonitor extends com.runtimeverification.rvmonitor.java.rt.tablebase.AbstractSynchronizedMonitor implements Cloneable, com.runtimeverification.rvmonitor.java.rt.RVMObject, IMotorsInSyncMonitor {
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

	WeakReference Ref_motors = null;
	int Prop_1_state;
	static final int Prop_1_transition_testEvent[] = {2, 3, 2, 3};;

	boolean MotorsInSyncMonitor_Prop_1_Category_violation = false;

	MotorsInSyncMonitor(long tau) {
		this.tau = tau;
		Prop_1_state = 0;

	}

	@Override
	public final int getState() {
		return Prop_1_state;
	}

	private final long tau;
	private long disable = -1;

	@Override
	public final long getTau() {
		return this.tau;
	}

	@Override
	public final long getDisable() {
		return this.disable;
	}

	@Override
	public final void setDisable(long value) {
		this.disable = value;
	}

	final boolean Prop_1_event_testEvent() {
		SoccerMotorMotion motors = null;
		if(Ref_motors != null){
			motors = (SoccerMotorMotion)Ref_motors.get();
		}
		{
			System.out.println("testing");
		}
		RVM_lastevent = 0;

		Prop_1_state = Prop_1_transition_testEvent[Prop_1_state];
		MotorsInSyncMonitor_Prop_1_Category_violation = Prop_1_state == 1;
		return true;
	}

	final void Prop_1_handler_violation (){
		{
			System.out.println("motors out of sync");
		}

	}

	final void reset() {
		RVM_lastevent = -1;
		Prop_1_state = 0;
		MotorsInSyncMonitor_Prop_1_Category_violation = false;
	}

	// RVMRef_motors was suppressed to reduce memory overhead

	@Override
	protected final void terminateInternal(int idnum) {
		switch(idnum){
			case 0:
			break;
		}
		switch(RVM_lastevent) {
			case -1:
			return;
			case 0:
			//testEvent
			return;
		}
		return;
	}

	public static int getNumberOfEvents() {
		return 1;
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

	// Declarations for Timestamps
	private static long MotorsInSync_timestamp = 1;

	private static boolean MotorsInSync_activated = false;

	// Declarations for Indexing Trees
	private static final Tuple2<MotorsInSyncMonitor_Set, MotorsInSyncMonitor> MotorsInSync__Map = new Tuple2<MotorsInSyncMonitor_Set, MotorsInSyncMonitor>(new MotorsInSyncMonitor_Set() , null) ;

	public static int cleanUp() {
		int collected = 0;
		// indexing trees
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

	public static final void MotorsInSync_testEventEvent() {
		MotorsInSync_activated = true;
		while (!MotorsInSync_RVMLock.tryLock()) {
			Thread.yield();
		}

		Tuple2<MotorsInSyncMonitor_Set, MotorsInSyncMonitor> matchedEntry = null;
		{
			// FindOrCreateEntry
			matchedEntry = MotorsInSync__Map;
		}
		// D(X) main:1
		MotorsInSyncMonitor matchedLeaf = matchedEntry.getValue2() ;
		if ((matchedLeaf == null) ) {
			if ((matchedLeaf == null) ) {
				// D(X) main:4
				MotorsInSyncMonitor created = new MotorsInSyncMonitor(MotorsInSync_timestamp++) ;
				matchedEntry.setValue2(created) ;
				MotorsInSyncMonitor_Set enclosingSet = matchedEntry.getValue1() ;
				enclosingSet.add(created) ;
			}
			// D(X) main:6
			MotorsInSyncMonitor disableUpdatedLeaf = matchedEntry.getValue2() ;
			disableUpdatedLeaf.setDisable(MotorsInSync_timestamp++) ;
		}
		// D(X) main:8--9
		MotorsInSyncMonitor_Set stateTransitionedSet = matchedEntry.getValue1() ;
		stateTransitionedSet.event_testEvent();

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
	pointcut MotorsInSync_testEvent() : (call(float[] SoccerMotorMotion.go*(int))) && MOP_CommonPointCut();
	after () : MotorsInSync_testEvent() {
		MotorsInSyncRuntimeMonitor.MotorsInSync_testEventEvent();
	}

}
