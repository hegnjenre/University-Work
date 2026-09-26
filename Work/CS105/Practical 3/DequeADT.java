public interface DequeADT<E> {

    // Insert an element at the front of the deque
    public void insertFront(E item);

    // Insert an element at the rear of the deque
    public void insertRear(E item);

    // Remove and return the element from the front of the deque
    public E deleteFront();

    // Remove and return the element from the rear of the deque
    public E deleteRear();

    // Get the front element without removing it
    public E getFront();

    // Get the rear element without removing it
    public E getRear();

    // Check if the deque is empty
    public boolean isEmpty();

    // Get the number of elements in the deque
    public  int size();

    // Display the elements in the deque
    public void display();
}
