#include <stdio.h>
#include <stdlib.h>
#include <math.h>


// use call with log/ln as this may be faster
// use constant of value 20.0/log(10.0)
static __inline float _20log10f(float x)
{
  return(8.685889f*logf(x));
}

double SUIpathLoss(double f, double TxH, double RxH, double d, int mode)
{
        /*
           f = Frequency (MHz) 1900 to 11000
           TxH =  Transmitter height (m)
           RxH = Receiver height (m)
           d = distance (km)
           mode A1 = URBAN / OBSTRUCTED
           mode B2 = SUBURBAN / PARTIALLY OBSTRUCTED
           mode C3 = RURAL / OPEN
           http://www.cl.cam.ac.uk/research/dtg/lce-pub/public/vsa23/VTC05_Empirical.pdf
         */
	//f /=1e3;
        d *= 1e3;               // km to m

        // Urban (A1) is default
        float a = 4.6;
        float b = 0.0075;
        float c = 12.6;
        float s = 10.6; // Optional fading value. Max 10.6dB
        float XhCF = -10.8;

        if (mode == 2) { // Suburban
                a = 4.0;
                b = 0.0065;
                c = 17.1;
        }
        if (mode == 3) { // Rural
                a = 3.6;
                b = 0.005;
                c = 20;
                XhCF = -20;
        }
        float d0 = 100;
        float A = _20log10f((4 * M_PI * d0) / (300.0 / f));
        float y = a - (b * TxH) + (c / TxH);
        //Correction factors
        float Xf = 6.0 * log10(f / 2000.0);
        float Xh = XhCF * log10(RxH / 2000.0);
	Xh *=-1;
	fprintf(stdout,"A %lf y %lf Xf %lf Xh %lf\n",A,y,Xf,Xh);
        return A + (10 * y * log10(d / d0)) + Xf + Xh + s;


}

int main(){

	fprintf(stdout,"%lf\n",SUIpathLoss(3500.0,15.0,10.0,1,1));
	fprintf(stdout,"%lf\n",SUIpathLoss(3500.0,15.0,10.0,1,2));
	fprintf(stdout,"%lf\n",SUIpathLoss(3500.0,15.0,10.0,1,3));
}
