
import flash.events.MouseEvent;
import flash.utils.Timer;
import flash.events.TimerEvent;
import mx.controls.NumericStepper;


private var BREAKTIME_in_seconds:Number = 60;

private const DELAY:int = 5;
private const INTERVAL:int = 1000 * 5;

private var myTimer:flash.utils.Timer = new flash.utils.Timer(INTERVAL);


private function TimerExample(e:MouseEvent):void {
	var breakTime:Number = getBreaktime();
	if (breakTime == 0) {
		
		//Alert.show("0 Hour 0 Second is not valid", "BREAKTIME", Alert.OK);
		return;
	}
	
	
	myTimer.reset();
	displayTime(0);
	

	mini.setStyle("icon", ClockRun);
	
	myTimer.addEventListener(TimerEvent.TIMER, timerHandler);
	myTimer.start();
	
	SystemTrayIcon(NativeApplication.nativeApplication.icon).tooltip = "Reminder is RUNNING";
	
}

private function timerHandler(event:TimerEvent):void {
	getBreaktime();


	trace("myTimer.currentCount:",myTimer.currentCount * DELAY);
	trace("BREAKTIME:", BREAKTIME_in_seconds);
	

	displayTime(myTimer.currentCount * DELAY);
	
	if (myTimer.currentCount * DELAY >= BREAKTIME_in_seconds) {		
			
		myTimer.stop();
		myTimer.removeEventListener(TimerEvent.TIMER, timerHandler);
		
		unDock();	
		
		Alert.show("BREAK TIME", "BREAKTIME", Alert.OK);
		mini.setStyle("icon", ClockStop);
		
		getSound();
		
		SystemTrayIcon(NativeApplication.nativeApplication.icon).tooltip = "STOPPED. Start timer again";
	}
	
	
}

private function getBreaktime():Number {	
	BREAKTIME_in_seconds = (hourInput.selectedItem * 60 * 60) + (minInput.selectedItem * 60);
	
	return BREAKTIME_in_seconds;
}

private function displayTime(time:int):void {
	var hour:int = (time / 60) / 60;
	var min:int = time / 60;
	var sec:int = time % 60;
	
	var hour_val:String;
	var min_val:String;
	var sec_val:String;

	if (hour < 10) {
		hour_val = "0" + String(hour);
	} else {
		hour_val = String(hour);
	}
	
	if (min < 10 ) {
		min_val = "0" + String(min);
	} else {
		min_val = String(min);
	}	
	
	if (sec <= 9 ) {
		sec_val = "0" + String(sec);
	} else if (sec >= 10) {
		sec_val = String(sec);
	} else {
		sec_val = "00";
	}
	
	
	//if 60
	if (min_val == "60") {
		min_val = "00";
	}
	
	if (sec_val == "60" ) {
		sec_val = "00";
	}
	
	//mini.label = "Click to Start/Reset Time: " + hour_val + ":" + min_val + ":" + sec_val;
	
	curTime.text = "Time: " + hour_val + ":" + min_val + ":" + sec_val
}