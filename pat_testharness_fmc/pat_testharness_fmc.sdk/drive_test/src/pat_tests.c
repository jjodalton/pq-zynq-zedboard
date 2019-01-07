


#include <stdio.h>
//#include "platform.h"

#include "xparameters.h" // has the peripheral address definitions
#include "xscutimer.h"
#include "pat_tests.h"

unsigned calcPeriod(unsigned input_period, unsigned desired_period)
{
	return desired_period / input_period ; // integer only result
}


void timerWait(XScuTimer* SCUTimer, unsigned period)
{
	XScuTimer_Stop(SCUTimer) ;
	XScuTimer_LoadTimer(SCUTimer, period) ;
	XScuTimer_DisableAutoReload(SCUTimer) ;

	XScuTimer_Start(SCUTimer) ;
	    while (XScuTimer_GetCounterValue(SCUTimer) > 0)
	    {
	    }
	XScuTimer_Stop(SCUTimer) ;
	return ;
}

#define QUAD_LED_IIC_ADDRESS 0x10eff0
void writeQuadLED(unsigned a, unsigned b, unsigned c, unsigned d)
{
	unsigned *transmit_buffer ;
	transmit_buffer =  XPAR_AXI_IIC_0_BASEADDR + 0x108; // hard coded LED badse adddress - can't find definition
	*transmit_buffer = QUAD_LED_IIC_ADDRESS ; // transmit slave address
	*transmit_buffer = 0x0e ; // segment test - all on
	*transmit_buffer = a ;
	*transmit_buffer = b ;
	*transmit_buffer = c ;
	*transmit_buffer = d ;
}

unsigned measureClkReturn(XScuTimer* SCUTimer)
{
	unsigned *clk_measure_control ;
	unsigned *clk_measurement ;
	unsigned *clk_measurement_ctrl ;
	clk_measure_control = (unsigned*) XPAR_AXI_GPIO_CLOCK_BASEADDR ;
	clk_measurement = (unsigned*) XPAR_AXI_GPIO_CLOCK_BASEADDR + 0x08;
	clk_measurement_ctrl = (unsigned*) XPAR_AXI_GPIO_CLOCK_BASEADDR + 0x0c;

	* clk_measurement_ctrl = 0xffffffff ; // set all to inputs

	// note this will interfere in pat clock setup too. Need to OR in existing state
	*clk_measure_control =  0x00 ; // reset, not enabled
	timerWait(SCUTimer, 0xfffff) ;
	*clk_measure_control =  0x0c ; // enabled, not reset
	timerWait(SCUTimer, 0xfffffff) ; // wait for measurement
	return *clk_measurement ;
}


void setAs(char bits)
{
	unsigned *As ;
	As = (unsigned*) XPAR_AXI_GPIO_ABPINS_BASEADDR ;
	*As = bits ;
	return ;
}

void setBs(char bits)
{
	unsigned *Bs ;
	unsigned *Bs_tri ;
	Bs = (unsigned*) XPAR_AXI_GPIO_ABPINS_BASEADDR + 0x08  ;
	Bs_tri = (unsigned*) XPAR_AXI_GPIO_ABPINS_BASEADDR + 0x0c  ;
	*Bs_tri = 0x00 ;
	*Bs = bits ;
	return ;
}

char readAs()
{
	unsigned *As ;
	unsigned bits ;
	As = (unsigned*) XPAR_AXI_GPIO_ABPINS_BASEADDR ;
	bits = *As ;
	return bits ;
}

char readBs()
{
	unsigned bits ;
	unsigned *Bs ;
	unsigned *Bs_tri ;
	Bs_tri = (unsigned*) XPAR_AXI_GPIO_ABPINS_BASEADDR + 0x0c  ;
	*Bs_tri = 0xff ;
	Bs = (unsigned*) XPAR_AXI_GPIO_ABPINS_BASEADDR + 0x08  ;
	bits = *Bs ;
	return bits ;
}


void setModes(unsigned mode, unsigned f5v_sel, unsigned vref_sel, unsigned clk_sel)
{
	unsigned *mode_p ;
	unsigned *mode_p_tri ;
	mode_p = (unsigned*) XPAR_AXI_GPIO_MODES_BASEADDR ;
	mode_p_tri = (unsigned*) XPAR_AXI_GPIO_MODES_BASEADDR + 0x04 ;
	printf("Old modes %#x", *mode_p_tri) ;
	*mode_p_tri = 0x00 ; // 5 bits of output ; must be done before writes to the out reg.
	printf("New modes %#x", *mode_p_tri) ;
	//*mode_p = ((clk_sel & 0x1) << 4) | ((vref_sel & 0x1) << 3) | ((f5v_sel & 0x1) << 2) | (mode & 0x3) ;
	*mode_p = 0xffff ;

	return ;
}


// isClkGen = 1 enables manual clk generator; 0 sets clock output to FPGA Clock gen
void setExtClockSource(unsigned isManualClk)
{
	unsigned *clk_source ;
	clk_source = (unsigned*) XPAR_AXI_GPIO_CLOCK_BASEADDR ;
	*clk_source = (isManualClk & 0x01) << 1 ;
	return ;
}

#define MANUAL_CLOCK_PERIOD  333    // @ 3ns/tick => 1us
void manualClockPulse(XScuTimer* SCUTimer)
{
	unsigned *clk_source ;
	clk_source = (unsigned*) XPAR_AXI_GPIO_CLOCK_BASEADDR ;

	*clk_source = 0x3 ;
	timerWait(SCUTimer, MANUAL_CLOCK_PERIOD) ;
	*clk_source = 0x2 ;
//	print("One pulse generated\n\r") ;
	return ;
}


// Set DAC output. 0's actively driven low; 1's tri-stated
#define DAC_WRITE_PERIOD 0xfff
void setDAC(XScuTimer* SCUTimer, unsigned value)
{
	unsigned* dac ;
	unsigned* dac_tristate ;
	dac = (unsigned*) XPAR_AXI_GPIO_DAC_BASEADDR ;
	dac_tristate = XPAR_AXI_GPIO_DAC_BASEADDR + 0x04 ; // Tristate: '1' := input '0' := output
	*dac_tristate = value & 0x3ff ;
	*dac = value & 0x3ff ;

	printf("Setting DAC value to %d\n\r", value) ;

	// now pulse write pin
	*dac_tristate = (value & 0x3ff) | 0x400 ;
	*dac = (value & 0x3ff) | 0x400 ;
	timerWait(SCUTimer, DAC_WRITE_PERIOD) ;
	*dac = value & 0x3ff ;
	*dac_tristate = value & 0x3ff ;
	print("DAC set.\n\r") ;
	return ;
}


#define SCLK_WAIT 0xfffff
// Send a byte out to the chip's sin interface
void sclkOutByte(XScuTimer* SCUTimer, char byte, char ssel, char saddr, char s_low_high)
{
	int i ;
	for (i = 0 ; i < 8 ; i++)
	{
		char bit ;
		char byte_out ;
		bit = (byte >> i) & 0x01 ;
		byte_out = (ssel & 0x01 << 1) | (bit << 2) | ((saddr & 0x7) << 3) | ((s_low_high & 0x01) << 7) ;
		setAs(byte_out) ;
		// wait, then set clock
		timerWait(SCUTimer, SCLK_WAIT) ;
		byte_out |= 0x01 ;
		setAs(byte_out) ;
		timerWait(SCUTimer, SCLK_WAIT) ;
		byte_out &= 0xfe ;
		setAs(byte_out) ; // reset sclk to 0
	}
}


// Configure low or high side to be on manual override for output pattern selection
void setPatternOverride(char s_low_high, char saddr)
{
	char byte_out ;
	byte_out = (0x01 << 1) | ((saddr & 0x7) << 3) | ((s_low_high & 0x01) << 7) ; // this includes ssel
	setAs(byte_out) ;

	return ;
}




char tweakToByte(tweak t)
{
	char byte ;
	byte = (t.sense << 6 | t.duration << 4 | t.delay << 1 | t.enable) ;
	return byte ;
}


void loadPattern(pattern p, XScuTimer* SCUTimer, char s_low_high, char saddr)
{
	char ssel = 1 ; // fix ssel to active

	printf("Programming pattern with n-Drive strength %#x\n",p.n_drive) ;
	printf("...and with p-Drive strength %#x\n",p.p_drive) ;

	setExtClockSource(CLK_EXT_PLL) ;
	setModes(MODE_DEBUG, 0, 0, CLK_EXT) ;

	// Load in the pattern, most significant byte and MSBit first.
	sclkOutByte(SCUTimer, tweakToByte(p.n_tweak_5), ssel, saddr, s_low_high) ;
	sclkOutByte(SCUTimer, tweakToByte(p.n_tweak_4), ssel, saddr, s_low_high) ;
	sclkOutByte(SCUTimer, tweakToByte(p.n_tweak_3), ssel, saddr, s_low_high) ;
	sclkOutByte(SCUTimer, tweakToByte(p.n_tweak_2), ssel, saddr, s_low_high) ;
	sclkOutByte(SCUTimer, tweakToByte(p.n_tweak_1), ssel, saddr, s_low_high) ;
	sclkOutByte(SCUTimer, tweakToByte(p.n_tweak_0), ssel, saddr, s_low_high) ;

	sclkOutByte(SCUTimer, p.n_tweak_delay, ssel, saddr, s_low_high) ;
	sclkOutByte(SCUTimer, p.n_drive, ssel, saddr, s_low_high) ;

	sclkOutByte(SCUTimer, tweakToByte(p.p_tweak_5), ssel, saddr, s_low_high) ;
	sclkOutByte(SCUTimer, tweakToByte(p.p_tweak_4), ssel, saddr, s_low_high) ;
	sclkOutByte(SCUTimer, tweakToByte(p.p_tweak_3), ssel, saddr, s_low_high) ;
	sclkOutByte(SCUTimer, tweakToByte(p.p_tweak_2), ssel, saddr, s_low_high) ;
	sclkOutByte(SCUTimer, tweakToByte(p.p_tweak_1), ssel, saddr, s_low_high) ;
	sclkOutByte(SCUTimer, tweakToByte(p.p_tweak_0), ssel, saddr, s_low_high) ;

	sclkOutByte(SCUTimer, p.p_tweak_delay, ssel, saddr, s_low_high) ;
	sclkOutByte(SCUTimer, p.p_drive, ssel, saddr, s_low_high) ;

	return ;
}


void loadDrivesOnly(XScuTimer* SCUTimer, char p_drive, char n_drive, char thePWM, char address)
{
	int i ;
	char ssel = 1 ; // fix ssel to active
	for (i = 0 ; i < 6 ; i++) sclkOutByte(SCUTimer, 0, ssel, address, thePWM) ;
	sclkOutByte(SCUTimer, n_drive, ssel, address, thePWM) ;
	for (i = 0 ; i < 6 ; i++) sclkOutByte(SCUTimer, 0, ssel, address, thePWM) ;
	sclkOutByte(SCUTimer, p_drive, ssel, address, thePWM) ;

	return ;
}



/*
 *  Run-time tests
 */

void runTestRingOscillator()
{
	print("Starting ring oscillator test program...\n\r") ;
	setModes(0x0, 0x0, 0x0, 0x0) ;
	setAs(0x58) ;
	while(1)
	{
		printf("Output seen is Osc1: %x, Osc2: %x\n\r", ((readBs()>> 6) & 0x1), ((readBs()>> 7) & 0x1) ) ;
	}
}

#define TEST_CLOCK_PERIOD 0xffffff
#define TEST_CLOCK_VCO_VOLTAGE 0x1f
void runTestClock(XScuTimer* SCUTimer, unsigned isExtClock)
{
	print("Running clock tests\n\r") ;
	print("Running external clock test...\n\r") ;
	setModes(0x0, 0x0, 0x0, 0x1) ;
	setExtClockSource(1) ; // use FPGA clock generator at ~20MHz

	print("You should now see a ~1.25MHz waveform on test chip's clock_out\n\r") ;
	timerWait(SCUTimer, TEST_CLOCK_PERIOD) ;


	print("Switching over to test chip's internal clock.") ;
	setDAC(SCUTimer, TEST_CLOCK_VCO_VOLTAGE) ;
	setModes(0x0, 0x0, 0x0, 0x0) ;
	print("You should now see a ~31MHz waveform on test chip's clock_out\n\r") ;
}


#define TEST_DRIVE_WAIT 0xfffff
// Test the p and n drivers weakly in an alternating pattern
void runTestDrive(XScuTimer* SCUTimer)
{
	print("Running drive test on low side\n\r") ;
	print("Setting drivers to pull up weakly...\n\r") ;
	loadDrivesOnly(SCUTimer, 0x01, 0x00, PWM_LOW, 0) ;

	setPatternOverride(PWM_LOW, 0) ;
	timerWait(SCUTimer, TEST_DRIVE_WAIT) ;

	print("Setting drivers to high impedence...\n\r") ;
	loadDrivesOnly(SCUTimer, 0x00, 0x00, PWM_LOW, 0) ;
	setPatternOverride(PWM_LOW, 0) ;

	print("Setting drivers to pull down weakly...\n\r") ;
	loadDrivesOnly(SCUTimer, 0x00, 0x01, PWM_LOW, 0) ;
	setPatternOverride(PWM_LOW, 0) ;

	print("Low side tests done. Setting to high impedence\n\r") ;
	loadDrivesOnly(SCUTimer, 0x00, 0x00, PWM_LOW, 0) ;
	setPatternOverride(PWM_LOW, 0) ;

	return ;
}





