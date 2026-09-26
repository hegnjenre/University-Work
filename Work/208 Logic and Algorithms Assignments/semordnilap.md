semordnilap 



get word from input called 'oldWord'

initialise new empty word called 'newWord'



if oldWord is empty then

&nbsp;	**return false**



loop n for length of oldWord

&nbsp;	newWord = newWord + oldWord\[at position oldWord.length-n]

end loop



loop k for length of dictionary

&nbsp;	if newWord equals the word found at dictionary\[position k] then

&nbsp;		**newWord is a semordnilap, return true**

	end if

end loop



**newWord is not a semordnilap, return false**







n = length of oldword

increased size of n will linearly increase time taken to complete algorithm

O(n)



k = time taken to find word in dictionary

increased size of n will not alter the size of k, it is a constant overhead

+k



O(n)+k



best case scenario is an empty string, O(1)

worst case scenario is an invalid semordnilap, as the overhead will be at its largest, O(n)+k





improved performance could come from comparing newWord with a set of all known semordnilaps, that way newWord can be used as a key to confirm it's validity, this would make k = 1.



with that improvement, the worst case complexity would be O(n)





