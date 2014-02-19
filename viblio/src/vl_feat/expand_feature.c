#include <vl/homkermap.h>
#include "stdio.h"

int expand(float* x, float* psi, int num_row, int num_col, char* kernel_type, int order, float gamma){
	double period = -1 ; // use default
	vl_size psiStride = 1 ;
	
	// find kernel type
	int kt;
	if(strcmp(kernel_type, "inter") == 0)
		kt = VlHomogeneousKernelIntersection;
	else if (strcmp(kernel_type, "chi2") == 0)
		kt = VlHomogeneousKernelChi2;
	else if (strcmp(kernel_type, "js") == 0)
		kt = VlHomogeneousKernelJS;
	else
		return -1;
	
	VlHomogeneousKernelMap * hom = vl_homogeneouskernelmap_new(kt, (double)gamma, order, period, VlHomogeneousKernelMapWindowRectangular) ;
	
	for(int i = 0; i<num_row; i++ ){
		for(int j= 0; j<num_col; j++){
				//printf("%f\n", *x);
				vl_homogeneouskernelmap_evaluate_f(hom, psi, psiStride, *x++);
				psi += 2 * order + 1;
		}
	}
	vl_homogeneouskernelmap_delete(hom) ;
	return 1;
}


int main(){
	printf("hello world\n");
	float gamma = 1.0 ;
	int order = 20 ;
	float x [2];
	float psi [41*2] ;
	
	x[0] = 0.5;
	x[1] = 0.5;
	
	int res = expand(x, psi, 1, 2, "chi2", order, gamma);
	
	printf("%d\n", res);
	float s = 0;
	for(int i = 0; i<41*2; i++){
		s += psi[i]*psi[i];
	}
	printf("%f\n", s);
	
	return 0;
}
