.binarysearch:
	@ ADD YOUR CODE HERE
	@========================================================================================
	@===============================IMPLEMENTING BINARY SEARCH===============================
		
		sub sp, sp, 4			   @ allocating storage on stack
		st ra, 0[sp]			   @ pushing return address for current call, onto stack

		@------------------------------------------------------------------------------------
						@ - starting address of array (r4), @ - Number to be searched (r0)
						@ - initial start index in (r5),	@ - initial end index in (r6)
		@------------------------------------------------------------------------------------
		
		cmp r6, r5			       @ if (end >= start)
		beq .calc_mid              @ mid is calculated
		bgt .calc_mid			
		b .search_return		   @ if (start > end) -> no match found, go to search_return

		.calc_start:
			add r5, r7, 1          @ new start = mid + 1				
			call .binarysearch	   @ recursion call with (start = mid + 1, end = end)
			b .search_return
			
		.calc_end:
			sub r6, r7, 1          @ new end = mid - 1
			call .binarysearch	   @ recursion call with (start = start, end = mid - 1)	
			b .search_return

		.calc_mid:
			add r7, r6, r5		   @ mid = (start + end)/2, stored in r7
			lsr r7, r7, 1
			mul r4, r7, 4          @ retrieving address of mid element for current iteration 
			ld r8, 0[r4]		   @ value of array[mid] in r8
			
			cmp r8, r0
			beq .match			   @ if current value = x, search complete		
			bgt .calc_end		   @ if current value > x, go to calc_end 
			b .calc_start		   @ if current value < x, go to calc_start
		
		.match:
			mov r1, 1			   @ match found, returning 1 in r1 
		
		.search_return:
			ld ra, 0[sp]		   @ poping return address for current call, outof stack
			add sp, sp, 4		   @ freeing the allocated stack
		
			ret					   @ returning after completion of search function		
	@========================================================================================
		
.bubble_sort:		
	@========================================================================================
	@==============================IMPLEMENTING BUBBLE SORT==================================
		
		mov r4, r2				  	   @ r4 containing copy of the starting address of array			
	
		@---------------------------------outter_loop----------------------------------------		
			mov r5, 0                  @ (i) for outter_loop
			.outter_loop:		
				cmp r3, r5			   @ if (i = N), terminate outter_loop
				beq .sort_return	   @ by going to sort_return
				add r5, r5, 1          @ i++			
		
			@-------------------------------inner_loop----------------------------		
				mov r6, 0              @ (j) for inner_loop
				sub r10, r3, r5 	   @ calculating N-i
				
				.inner_loop:
					cmp r10, r6		   @ if (j = N - i), terminate inner_loop
					beq .outter_loop   @ by going back to outter_loop

					mul r4, r6, 4	   @ retrieving address of element
					add r6, r6, 1      @ j++
					ld r7, 0[r4]	   @ value at index[j] loaded in r7
					ld r8, 4[r4]       @ value at index[j+1] loaded in r8
					
					cmp r7, r8		   @ if ( array[j] > array[j+1] )
					bgt .swap		   @ calling swap 
					b .inner_loop
			@---------------------------end of inner_loop--------------------------
			
		@------------------------------------------------------------------------------------	
		.swap:
			mov r9, r7  		 	   @ r9 used as buffer for swaping
			mov r7, r8			 	   @ swaping array[j] with array[j+1]
			mov r8, r9
			st r7, 0[r4]	     	   @ value array[j] stored back to the array
			st r8, 4[r4]        	   @ value array[j+1] stored back to the array		
			b .inner_loop
		
		.sort_return:
			ret						   @ returns the sorted array
	@========================================================================================

.main:

	@ Loading the values as an array into the registers
	mov r0, 0    
	mov r1, 12	     @ replace 12 with the number to be sorted
	st r1, 0[r0]
	mov r1, 7	     @ replace 7 with the number to be sorted
	st r1, 4[r0]
	mov r1, 11       @ replace 11 with the number to be sorted
	st r1, 8[r0] 
	mov r1, 9   	 @ replace 9 with the number to be sorted
	st r1, 12[r0] 
	mov r1, 3   	 @ replace 3 with the number to be sorted
	st r1, 16[r0]
	mov r1, 15  	 @ replace 15 with the number to be sorted
	st r1, 20[r0]
	@ EXTEND ON SIMILAR LINES FOR MORE NUMBERS
	
	@ Store the Element to be searched in r0
	mov r0,16        @-------------------- ENTER THE Number TO BE SEARCHED--------------------
	
	@Flag for storing the boolean result
	mov r1, 0
	
	mov r2, 0        @ Starting address of the array
	
	@ Retreive the end address of the array
	mov r3, 6		 @ REPLACE 6 WITH N, where, N is the number of numbers being sorted
	
	@ ADD YOUR CODE HERE
	@=====================================================================================
			/* CONVENTIONS USED IN THIS PROGRAM:-
				r0: number to be searched
				r1: hold result of search in bool 
				r2: starting address of array
				r3: no of elements in array(N)			
			*/
		@---------------------------------------------------------------------------------
			@ PASSING THIS TWO PARAMETERS TO BUBBLE SORT FUNCTION
			@ - starting address of array (r4), @ - Number of elements N (r3) 
			
			call .bubble_sort		@ used bubble sorting to sort the array				
		@---------------------------------------------------------------------------------
			mov r4, r2				@ copy of the starting address of array
			mov r5, 0       		@ start index as 0
			sub r6, r3, 1			@ end index as N-1

			@ PASSING THIS FOUR PARAMETERS TO BINARY SEARCH FUNCTION
			@ - starting address of array (r4), @ - Number to be searched (r0)
			@ - initial start index in (r5),	@ - initial end index in (r6)	

	@======================================================================================
	
	call .binarysearch
	
	@ ADD YOUR CODE HERE
	@======================================================================================
		@..............................coded & submitted by................................
		@................................ANIRUDDH NAGAR....................................
		@..............................CTech - 2021EET2113 ................................
	@======================================================================================
	
	@ Print statement for the result 
	@ Boolean result is stored in r1
	.print r1
    
