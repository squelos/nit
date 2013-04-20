module random_generator

extern RandGen
	
	new is extern `{
               srand(time(NULL));
       `}


	#returns a Pseudo Random Int between min and Max
       fun int_rand( min : Int, max : Int ): Int is extern `{
		double scaled = (double)rand()/RAND_MAX;
               return (int)((max - min +1)*scaled + min);
       `}

	#returns a pseudo Random Float between Min and Max
       fun float_rand(min :Float, max:Float): Float is extern `{
		double scaled = (double)rand()/RAND_MAX;            
		return (double)((max - min +1)*scaled + min);
       `}
end
