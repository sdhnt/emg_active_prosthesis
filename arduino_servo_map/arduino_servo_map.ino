int servopos=0;
#include <Servo.h>
String inString = "";
Servo myServo; 
boolean dotflag=false;
int pos=0;
int loopctr=0;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  myServo.attach(9);

}

void loop() {
  loopctr++;
  // put your main code here, to run repeatedly:
  while (Serial.available() > 0) {
    int inChar = Serial.read();
    if (isDigit(inChar)&&dotflag!=true) {
      // convert the incoming byte to a char and add it to the string:
      inString += (char)inChar;
    }
    if(inChar=='.'){
      dotflag=true;
    }
    // if you get a newline, print the string, then the string's value:
    if (inChar == '\n') {
      pos=inString.toInt();
      // clear the string for new input:
      inString = "";
      dotflag=false;
    }
  }
  //if(loopctr==10000){
  Serial.println(pos);
  myServo.write(pos);
  //loopctr=0;
  //}

}
