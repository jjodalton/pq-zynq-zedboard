/*
 * mmcm_config.h
 *
 *  Created on: 13 Nov 2014
 *      Author: harry
 */

#ifndef MMCM_CONFIG_H_
#define MMCM_CONFIG_H_


float mmcmCalcDivider(float targetFrequency) ;
int getHeadFromFloat(float x) ;
float getFloatTailFromFloat(float x) ;
int getTailFromFloat(float x) ;
unsigned constructMMCMDivider(float targetFrequency) ;
void mmcmWriteDivider(unsigned baseAddress, unsigned clockID, unsigned divider) ;
void mmcmReconfigure(unsigned baseAddress) ;

#endif /* MMCM_CONFIG_H_ */
