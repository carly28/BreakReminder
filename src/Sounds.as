import flash.events.Event;
import flash.media.Sound;
import flash.media.SoundChannel;
import flash.net.URLRequest;

private var sound:Sound = new Sound();
private var sound2:SoundChannel = new SoundChannel();

private function getSound():void {
	
	sound.addEventListener(Event.COMPLETE, soundLoaded);
	sound.load(new URLRequest("assets/DoorBell.mp3"));
	
	
}

private function soundLoaded(e:Event):void {
	sound2 = sound.play();
}