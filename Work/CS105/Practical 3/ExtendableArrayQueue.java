/**
 * This class is for completion in Practical 3ii
*/
public class ExtendableArrayQueue<E> implements QueueADT<E>
{
   protected E[] Q; // Q will refer to the array
   protected int f; // front - array index of element at front of queue
   protected int r; // rear - array index of where next element added will be placed 
   protected int N;  // array capacity

   /**
    * Constructor for objects of class ExtendableArrayQueue.
    * In practical 3ii no change need be made to this constructor.
    * With this constructor a queue can initially hold up to 
    * 3 (i.e.N-1) items when using the approach described in lectures.
    */
   public ExtendableArrayQueue()
   {
       N=4;
       Q = (E[]) new Object[N];
       f=0;
       r=0;
   }
   
   // Complete the method bodies below and add any further methods if 
   // appropriate. Many of the method bodies can be the same as in Q3i

   public void printQueue(){
      String debug = ("Front: " + f + " Rear: " + r + " Queue: ");
      for(int i=0;i<N;i++) {
         debug += ("" + Q[i]);
      }
      System.out.println(debug);
   }

   public void enqueue(E element){
      if(size() == N-1){
         Q = extendCapacity();
         enqueue(element);
      }
      else{
         Q[r] = element;
         System.out.println("Enqueued " + element);
         r = ((r+1) % (N));
      }
   }
   
   /**
     @throws EmptyQueueException
   */
   public E dequeue(){
      if (isEmpty()){
         throw new EmptyQueueException("The queue is empty");
      }
      else{
         E elementRemoved = Q[f];
         Q[f] = null;
         f = (f+1) % N;
         System.out.println("Dequeued " + elementRemoved);
         return elementRemoved;
      }
   }
   
   /**
     @throws EmptyQueueException
   */
   public E front(){
      if (r == f)
         throw new EmptyQueueException("The queue is empty");
      else
         return Q[f];
   }

   public int size(){
      return ((r-f+N) % N);
   }

   public boolean isEmpty(){
      return f == r;
   }

   public E[] extendCapacity() {
      E[] newQ = (E[]) new Object[(N*2)];
      if(f <= r){
         for (int i = f; i <= r; i++) { //copy array into new array of double size
            newQ[i] = Q[i];
         }
      }
      else {
         int fIndex = f; // index for front items
         int rStart = 0; // index for placing rear items after fronts
         for (int i = 0; fIndex <= (N - 1); i++) { //copy items from front to end
            //System.out.println("Q[fIndex] = " + Q[fIndex]);
            rStart++;
            newQ[i] = Q[fIndex];
            fIndex++;
         }
         int rIndex = 0; // index for rear items
         for (int i = rStart; rIndex <= r; i++) { //copy items from Q[0] to r
            //System.out.println("Q[rIndex] = " + Q[rIndex]);
            newQ[i] = Q[rIndex];
            rIndex++;
         }
      }
      f = 0;
      r = N-1; // set rear to position after last element (since extending we know it's full so N is last element)
      N = N*2; // set to newQ size
      return newQ;
   }
}
