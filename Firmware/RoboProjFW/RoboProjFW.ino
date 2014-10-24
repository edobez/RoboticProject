#include <Wire.h>
#include <TimerObject.h>
#include <wiinunchuck.h>
#include <Streaming.h>

#define RATE 1

int led1 = 12;
TimerObject *alive = new TimerObject(500,&alive_task);
TimerObject *chuk = new TimerObject(10,&chuk_task);
TimerObject *com = new TimerObject(100,&com_task);

int16_t posx,posy,posz;

void setup() {
	/* Serial init */
	Serial.begin(115200); // USB serial
	Serial2.begin(9600);  // Display serial
	
	/* Peripheral initialization */
	pinMode(led1, OUTPUT);
	digitalWrite(led1,HIGH);
	
	nunchuk_init();
	
	posx = 10000;
	posy = posx;
	
	alive->Start();
	chuk->Start();
	com->Start();
}

void loop() {
  	alive->Update();
	chuk->Update();
	com->Update();
}

void alive_task()
{
	digitalWrite(led1,!digitalRead(led1));
}

void chuk_task()
{
	nunchuk_get_data();
	
	posx += nunchuk_cjoy_x()/RATE;
	posx = constrain(posx,-32000,32000);
	
	posy += nunchuk_cjoy_y()/RATE;
	posy = constrain(posy,-32000,32000);
	
	posz += 100*nunchuk_cbutton();
	posz -= 100*nunchuk_zbutton();
	posz = constrain(posz,-32000,32000);
}

void com_task()
{

	/* Sending data to Simulink model as single bytes
	in order to form an int16. The data are sent as littleEndian.
	*/
	
	Serial.write( lowByte(posx)  );
	Serial.write( highByte(posx)  );
	
	Serial.write( lowByte(posy)  );
	Serial.write( highByte(posy)  );
	
	Serial.write( lowByte(posz)  );
	Serial.write( highByte(posz)  );
	
	Serial.write( lowByte(nunchuk_caccelx()) );
	Serial.write( highByte(nunchuk_caccelx()) );
	
	Serial.write( lowByte(nunchuk_caccely()) );
	Serial.write( highByte(nunchuk_caccely()) );
	
	Serial.write( lowByte(nunchuk_caccelz()) );
	Serial.write( highByte(nunchuk_caccelz()) );
	
	/* Display communication */
	Serial2.write(0x76);	// Reset display
	Serial2.print(nunchuk_cjoy_x());
	
	// Serial << posx << " " << posy << endl;
	//Serial << _BYTE(posx) << _BYTE(posy);
}