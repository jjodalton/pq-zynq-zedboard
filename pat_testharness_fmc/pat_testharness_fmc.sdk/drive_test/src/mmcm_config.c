/*
 * mmcm_config.c
 *
 *  Created on: 13 Nov 2014
 *      Author: harry
 */


// below could be read from their relevant registers too.
#define CLKFBOUT_MULT 9.0 // VCO frequency multiplier (float form)
#define DIVCLK_DIVIDE 1.0 // Clock division before VCO (float form)
#define SYSCLK_FREQ 100.0 // MHz



float mmcmCalcDivider(float targetFrequency)
{
	float dividerValue ;
	dividerValue = (SYSCLK_FREQ * (CLKFBOUT_MULT / DIVCLK_DIVIDE)) / targetFrequency ;
	return dividerValue ;
}


int getHeadFromFloat(float x)
{
	return x ; // gets integer part
}

// return part of float after decimal point in float form e.g. 0.222 from 3.222
float getFloatTailFromFloat(float x)
{
	int y ;
	y = x ;
	return x - y ;
}

// return part of float after decimal point in integer form to 3 s.f. e.g. 222 from 3.222
int getTailFromFloat(float x)
{
	int y ;
	y = getHeadFromFloat(x) ;
	x = x - y ;
	y = x * 1000 ;
	return y ;
}

unsigned constructMMCMDivider(float targetFrequency)
{
	unsigned result ;
	float divider ;
	divider = mmcmCalcDivider(targetFrequency) ;
	result = 0x40000 | ((getTailFromFloat(divider) & 0x3ff) << 8) | (getHeadFromFloat(divider) & 0xff) ;
	return result ;
}


void mmcmWriteDivider(unsigned baseAddress, unsigned clockID, unsigned divider)
{
	unsigned *regAddress ;
	regAddress = baseAddress + 0x208 + (clockID * 0x0c) ;
	printf("Old divider is %#x\n\r", *regAddress) ;
	*regAddress = divider ;
	printf("Divider written to %#x\n\r", regAddress) ;
	printf("Updated divider is %#x\n\r", *regAddress) ;
	return ;
}

// write phase to the register. Phase is a signed number
// will only work is phase/duty config enabled on MMCM block
void mmcmWritePhase(unsigned baseAddress, unsigned clockID, int phase)
{
	int *regAddress ;
	regAddress = baseAddress + 0x20c + (clockID * 0x0c) ;
	printf("Phase is: %#x\n\r", *regAddress) ;
	*regAddress = phase ;
	printf("New Phase is: %#x\n\r", *regAddress) ;
	return ;
}

// input of duty cycle is in %. i.e. 50 => 50%
// will only work is phase/duty config enabled on MMCM block
void mmcmWriteDutyCycle(unsigned baseAddress, unsigned clockID, unsigned dutyCycle)
{
	unsigned *regAddress ;
	regAddress = baseAddress + 0x210 + (clockID * 0x0c) ;
	printf("Duty reg is: %#x\n\r", *regAddress) ;
	*regAddress = 1000 * dutyCycle ;
	printf("New Duty reg is: %#x\n\r", *regAddress) ;
	return ;
}

void mmcmReconfigure(unsigned baseAddress)
{
	unsigned *regAddress ;
	regAddress = baseAddress + 0x04 ; // status register
	printf("MMCM Status register is %#x\n\r", *regAddress) ;
	while (*regAddress == 0) {}  // 0 => not ready
	regAddress = baseAddress + 0x25c ;
	printf("MMCM register 23 is %#x\n\r", *regAddress) ;
	*regAddress = 0x07 ; // begin reconfiguration
	*regAddress = 0x02 ; // end reconfiguration
	return ;
}
