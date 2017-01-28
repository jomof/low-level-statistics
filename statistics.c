#include "statistics.h"

double jaf_sum(double * numbers, 
	       int size) {
	double sum = 0;
	for (int i = 0; i < size; ++i) {
		sum += numbers[i];
	}
	return sum;
}
