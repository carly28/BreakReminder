import flash.events.MouseEvent;
private var trayIcon:BitmapData;

public function initApp():void{
	loadTrayIcon();
	displayTime(0);
	
	this.addEventListener(Event.CLOSING, minToTray);
	
	mini.addEventListener(MouseEvent.CLICK, minToTray);
	mini.addEventListener(MouseEvent.CLICK, TimerExample);
	
	
}

public function loadTrayIcon():void{
	var loader:Loader = new Loader();
	loader.contentLoaderInfo.addEventListener(Event.COMPLETE, readyToTray);
	loader.load(new URLRequest("assets/clock.png"));
	
	
}

private function minToTray(event:Event):void {
	var breakTime:Number = getBreaktime();
	
	if (breakTime == 0) {
		
		Alert.show("0 Hour 0 Second is not valid", "BREAKTIME", Alert.OK);
		return;
	}
	
	
	event.preventDefault();			
	dock();
	
}

public function readyToTray(event:Event):void{
	trayIcon = event.target.content.bitmapData;

	var myMenu:NativeMenu = new NativeMenu();

	var openItem:NativeMenuItem = new NativeMenuItem("Open");
	var closeItem:NativeMenuItem = new NativeMenuItem("Close");

	openItem.addEventListener(Event.SELECT, unDock);
	closeItem.addEventListener(Event.SELECT, closeApp);

	myMenu.addItem(openItem);
	myMenu.addItem(new NativeMenuItem("", true));
	myMenu.addItem(closeItem);

	if(NativeApplication.supportsSystemTrayIcon){
		SystemTrayIcon(NativeApplication.nativeApplication.icon).tooltip = "BreakReminder";

		SystemTrayIcon(NativeApplication.nativeApplication.icon).addEventListener(MouseEvent.CLICK, unDock);

		stage.nativeWindow.addEventListener(NativeWindowDisplayStateEvent.DISPLAY_STATE_CHANGING, winMinimized);

		SystemTrayIcon(NativeApplication.nativeApplication.icon).menu = myMenu;
	}
}

private function winMinimized(displayStateEvent:NativeWindowDisplayStateEvent):void{
	if(displayStateEvent.afterDisplayState == NativeWindowDisplayState.MINIMIZED){
		displayStateEvent.preventDefault();
		dock();
	}
}

public function dock():void{
	stage.nativeWindow.visible = false;

	NativeApplication.nativeApplication.icon.bitmaps = [trayIcon];
}

public function unDock(event:Event = null):void{
	stage.nativeWindow.visible = true;
	stage.nativeWindow.orderToFront();

	NativeApplication.nativeApplication.icon.bitmaps = [];
}

private function closeApp(event:Event):void{
	stage.nativeWindow.close();
}