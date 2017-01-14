


double jaf_sum(double * numbers, size_t size) {
	double sum = 0;
	for (int i = 0; i < size; ++i) {
		sum += numbers[i];
	}
	return sum;
}