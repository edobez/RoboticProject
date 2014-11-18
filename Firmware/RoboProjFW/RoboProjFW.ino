#include <Wire.h>
#include <TimerObject.h>
#include <wiinunchuck.h>
#include <Streaming.h>

#define RATE 1

#define NJXOFFSET 0
#define NJYOFFSET 1

#define COM_HEADER 0x07
#define COM_FOOTER	0x0D
#define COM_DATANUM	7
#define COM_BUFSIZE	2+2*COM_DATANUM

int pin_led1 = 12;
TimerObject *alive = new TimerObject(500,&alive_task);
TimerObject *chuk = new TimerObject(10,&chuk_task);
TimerObject *com = new TimerObject(100,&com_task);

int16_t posx,posy,posz;
int16_t njx, njy, nbc, nbz, nax, nay, naz;

void setup() {
	/* Serial init */
	Serial.begin(115200); // USB serial
	Serial1.begin(115200); // Diagnostic serial
	Serial2.begin(9600);  // Display serial
	
	/* Peripheral initialization */
	pinMode(pin_led1, OUTPUT);
	digitalWrite(pin_led1,HIGH);
	
	nunchuk_init();
	
	/* Task start */
	alive->Start();
	chuk->Start();
	com->Start();
	
}

void loop() {
  	alive->Update();
	chuk->Update();
	com->Update();
}

void chuk_task()
{
	nunchuk_get_data();
	
	njx = integrate(njx,nunchuk_cjoy_x()-NJXOFFSET);
	njy = integrate(njy,nunchuk_cjoy_y()-NJYOFFSET);
	nbc = integrate(nbc,nunchuk_cbutton());
	nbz = integrate(nbz,nunchuk_zbutton());
	
	/* The values are switched on purpose! The nunchuck doesn't have ortonormal axis, so we change them */
	nax = integrate(nax,nunchuk_caccely());
	nay = integrate(nay,nunchuk_caccelx());
	naz = integrate(naz,nunchuk_caccelz());
	
}

void com_task()
{
	char buf[COM_BUFSIZE];
	int i = 0;
	
	/* Condition data before sending
	

	/* Sending data to Simulink model as single bytes
	in order to form an int16. The data are sent as littleEndian.
	*/
	buf[i++] = COM_HEADER;
	
	buf[i++] = lowByte(njx);
	buf[i++] = highByte(njx);
	
	buf[i++] = lowByte(njy);
	buf[i++] = highByte(njy);
	
	buf[i++] = lowByte(nbc);
	buf[i++] = highByte(nbc);
	
	buf[i++] = lowByte(nbz);
	buf[i++] = highByte(nbz);
	
	buf[i++] = lowByte(nax);
	buf[i++] = highByte(nax);
	
	buf[i++] = lowByte(nay);
	buf[i++] = highByte(nay);
	
	buf[i++] = lowByte(naz);
	buf[i++] = highByte(naz);

	buf[i++] = COM_FOOTER;
	
	Serial.flush(); // Make sure the previous com is complete
	Serial.write(buf,i);
	
	/* Clear accumulator var */
	njx = 0;
	njy = 0;
	nbc = 0;
	nbz = 0;
	nax = 0;
	nay = 0;
	naz = 0;
	
	/* Display communication */
	//Serial2.write(0x76);	// Reset display
	//Serial2.print(nunchuk_cjoy_x());
	
	// Serial << posx << " " << posy << endl;
	//Serial << _BYTE(posx) << _BYTE(posy);
}

void alive_task()
{
	digitalWrite(pin_led1,!digitalRead(pin_led1));
}

int16_t integrate(int16_t v, int16_t vd)
{
	int32_t temp = 0;
	
	temp = v + vd;
	temp = min(temp,32767);
	
	return (int16_t)temp;
}