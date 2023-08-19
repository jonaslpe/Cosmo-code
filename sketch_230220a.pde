import processing.serial.*;
import ddf.minim.*;

Serial myPort;
Minim minim;
AudioPlayer player;
AudioPlayer player2;
byte arbitraryCode = 97;

void fadeInto(AudioPlayer a){
//Skifter fade mellom to lyder; fra L til C  
  a.play();
  float volumeUp = 0;
  int time = millis();
  int fadeDuration = 2000 ;
  int start = millis();
  int finish = start + fadeDuration;
  
  while (volumeUp <= 1){
    volumeUp = map(time, start, finish, 0, 1);
    print("Up:");
    print(volumeUp);
    a.setGain(volumeUp);
    time = millis();
    
  }
  a.setGain(1);
}

void fadeOut(AudioPlayer b){
//Skifter fade mellom to lyder; fra L til C  
  float volumeDown = 1;
  int time = millis();
  int fadeDuration = 5000 ;
  int start = millis();
  int finish = start + fadeDuration;
  
  while (volumeDown >= 0){
    volumeDown = map(time, start, finish, 1, 0);
    print("Down:");
    println(volumeDown);
    b.setGain(volumeDown);
    time = millis();
    
  }
  b.setGain(0);
}

void setup(){  
 myPort = new Serial(this, "COM5", 9600);
minim = new Minim(this);  
player = minim.loadFile("Merkur.wav");



}
void draw() {  
while (myPort.available() > 0) { 
int inByte = myPort.readChar();
println(inByte);
if (inByte == '1') {
fadeInto(player);}  
else if (inByte == '2') { 
fadeOut(player);
player.pause();
player.rewind(); }
 }}
