.quicksort:
	@ ADD YOUR CODE HERE
	@======================================================================================		
		sub sp, sp, 4			@ allocating storage on stack   
		st ra, 0[sp]		    @ pushing return address for current call, onto stack
		
		cmp r4, r3              @ check 
		bgt .greater_end		@ if (end > start) go to .greater_end
		b .sort_return			@ else go to .sort_return
	
		.greater_end:
			sub sp, sp, 8			   
			st r3, 0[sp]		@ start index of current iteration, pushed onto stack
			st r4, 4[sp]	    @   end index of current iteration, pushed onto stack			
			call .partition	   		
			ld r3, 0[sp]		@ start index of current iteration, poped outof stack		
			ld r4, 4[sp]		@   end index of current iteration, poped outof stack
			add sp, sp, 8		
		
							/* @ The partition index returned is contained in r6.
							   @ Partition index is used to devide the array in two parts.
							   @ first part  - (start = start, end = partition index - 1) 
							   @ second part - (start = partition index + 1, end = end)
							   @ Quicksort is called for both partitions in each iteration.
							*/   
		   
			sub sp, sp, 12			   
			st r3, 0[sp]		
			st r4, 4[sp]	    			
			st r7, 8[sp]	    @ current partition index, pushed onto stack
			sub r4, r7, 4  		
			call .quicksort		@ recursive call, passing (start = start, end = partition index - 1) 	
			ld r3, 0[sp]				
			ld r4, 4[sp]		
			ld r7, 8[sp]	    @ current partition index, poped outof stack	
			add sp, sp, 12

			sub sp, sp, 8			   
			st r3, 0[sp]		
			st r4, 4[sp]	    			
			add r3, r7,4 
			
			call .quicksort		@ recursive call, passing (start = partition index + 1, end = end)
			ld r3, 0[sp]		
			ld r4, 4[sp]		
			add sp, sp, 8	
		
		.sort_return:	
			ld ra, 0[sp]		@ poping return address for current call, outof stack
			add sp, sp, 4		@ freeing the allocated stack
			
			ret					@ returns sorted array 
	@======================================================================================	
	
.partition:
			
	@ ADD YOUR CODE HERE
	@======================================================================================
		ld r5, [r4] 		    @ pivot value at array[end] 
		sub r7, r3, 4		    @ i = start - 1
		mov r6, r3			    @ j = start 
		sub r11, r4, 4			@ (end-1), terminating point for j loop
        
		.loop:	
			cmp r6, r11			@ if (j > end-1), skip to final_swap | else continue 
			bgt .final_swap
						
			ld r8, [r6]		   	@ value at array[j]

			cmp r8, r5			@ if (pivot < array[j]), skip to next iteration
			bgt .inc_j

			add r7, r7, 4		@ i++		
			ld r9, [r7]			@ value at array[i]
			mov r10, r9  	    @ r10 used as buffer for swaping
			mov r9, r8		    @ swaping (array[i], array[j]) 
			mov r8, r10
			st r9, [r7]	        @ storing the swaped value back to array
			st r8, [r6]	
			
		.inc_j:
			add r6, r6, 4		@ j++
			b .loop
		
		.final_swap:
			add r7,r7,4			@ i = i+1
			ld r9, [r7]			@ value at array[i]
			mov r10, r5  	    
			mov r5, r9		    @ swaping pivot with array[i] 
			mov r9, r10 
			st r5, [r4]		    @ storing the swaped value back to array
			st r9, [r7]			

		ret						@ returns partition index in (r7) to the caller function
	@======================================================================================	

.main:

	@ Loading the values as an array into the registers
	mov r0, 0    
	mov r1, 12	        @ replace 12 with the number to be sorted
	st r1, 0[r0]  		
	mov r1, 7	        @ replace 7 with the number to be sorted
	st r1, 4[r0]
	mov r1, 11          @ replace 11 with the number to be sorted
	st r1, 8[r0]
	mov r1, 9           @ replace 9 with the number to be sorted
	st r1, 12[r0]
	mov r1, 3           @ replace 3 with the number to be sorted
	st r1, 16[r0]
	mov r1, 15          @ replace 15 with the number to be sorted
	st r1, 20[r0]
	@ EXTEND ON SIMILAR LINES FOR MORE NUMBERS

	mov r2, 0           @ Starting address of the array 
	
	@ Retreive the end address of the array
	mov r3, 5	        @ REPLACE 5 WITH N-1, where, N is the number of numbers being sorted
	mul r3, r3, 4		
	add r4, r2, r3      @ copying end index in r4 
		
	
	@ ADD YOUR CODE HERE 
	@======================================================================================		
			/* CONVENTIONS USED BY ME IN THIS PROGRAM:-
				r2: starting address of array
				r3: start index
				r4: end index
				r5: pivot value
				r6: j ( used in partition)
				r7: i ( used in partition)
				r8: value at index [j]
				r9: value at index [i]
				r10: buffer for swaping
			*/
		@----------------------------------------------------------------------------------	
			mov r3, r2  @ copying starting index in r3
			
			@ PASSING THIS THREE PARAMETERS TO THE QUICK-SORT FUNCTION
			@ - starting address (r2), start index (r3), end index (r4)				
		
	@======================================================================================	
	
	call .quicksort

	@ ADD YOUR CODE HERE 
	@======================================================================================
		@..............................coded & submitted by................................
		@................................ANIRUDDH NAGAR....................................
		@..............................CTech - 2021EET2113 ................................
	@======================================================================================	
	
	@ Print statements for the result
        mov r3, 5      @ REPLACE 5 WITH N-1, where, N is the number of numbers being sorted 
        mov r2, 0      @ Starting address of the array
        .printLoop:
           ld r1, 0[r2]
           .print r1
           add r2,r2,4  @ Incrementing address value
           cmp r3, 0    @ r3 contains number of elements in array
           sub r3,r3,1  
	   bgt .printLoop