import processing.serial.*;
import java.io.*;
int mySwitch=0;
int counter=0;
String [] subtext;
int ttllines;
int ctr1=0;
int loopctr=0;
Serial myPort;


void setup(){
 //Create a switch that will control the frequency of text file reads.
 //When mySwitch=1, the program is setup to read the text file.
 //This is turned off when mySwitch = 0
 mySwitch=1;
 
 //Open the serial port for communication with the Arduino
 //Make sure the COM port is correct
 myPort = new Serial(this, "/dev/ttyUSB0", 9600);
 myPort.bufferUntil('\n');
}

void draw() {
  
  loopctr++;

 File file=new File("/home/sdhnt/fyp/servomap.txt");
 BufferedReader br=null;
 
  try{
 
 br=new BufferedReader(new FileReader(file));
 String text=null;
 
 /* keep reading each line until you get to the end of the file */
  while((text=br.readLine())!=null){
    
    if(loopctr%30==0)
    {
    print(text+'\n');
    myPort.write(text+'\n');
    delay(1);
    }
  }
  
  
 subtext=new String[ttllines+1];
 
 }
catch(FileNotFoundException e){
 e.printStackTrace();
 }catch(IOException e){
 e.printStackTrace();
 }finally{
 try {
 if (br != null){
 br.close();
 }
 } catch (IOException e) {
 e.printStackTrace();
 }}
  
  
}

 
