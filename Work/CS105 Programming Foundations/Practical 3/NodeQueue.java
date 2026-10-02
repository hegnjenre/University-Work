/**
 * This class is for completion in Practical 3iii
 * The Node class is supplied for you
*/
public class NodeQueue<E> implements QueueADT<E>
{
    // references to the head and tail of 
    // the linked list
    protected Node<E> head, tail;   
    // number of elements in the queue
    protected int size;     

    /** constructs an empty queue
    */
    public NodeQueue() {    
       head = null; tail = null;
       size = 0;
    }

    public void printQueue(){
        System.out.println("null");
    }

   // Complete the method bodies below. Take care
   // that exceptions of the correct types are thrown by 
   // your methods as specified in the method comments.
   
    public int size() {
        return size;
    }
    
    public boolean isEmpty() {
        return size == 0;
    }
    
    public void enqueue(E elem) {
    // create and link in a new node at tail
        if(head == null){ // first node?
            head = new Node<E>(elem, null);
            size++;
        }
        else { // after first node
            if(size==1){
                head.setNext(new Node(elem, null));
                tail = head.getNext();
                size++;
            }
            else{
                tail.setNext(new Node(elem, null));
                tail = tail.getNext();
                size++;
            }
        }
    }

    /**
     @throws EmptyQueueException
    */
    public E front() {
        if (isEmpty()) {
            throw new EmptyQueueException("Empty Queue");
        }
        return head.getElement();
    }

    /**
     @throws EmptyQueueException
    */
    public E dequeue() {
        if (isEmpty()) {
            throw new EmptyQueueException("Empty Queue");
        }
        E elementRemoved = head.getElement(); // grab element before removal
        head = head.getNext(); // remove head node
        size--;
        return elementRemoved; // return grabbed element
    }
}
