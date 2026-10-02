public class DoubleNode<E> {

    // Instance variables
    private E element;
    private DoubleNode<E> next;
    private DoubleNode<E> previous;

    /** Creates a node with null references
     * to its element, next node, and previous node. */
    public DoubleNode() {
        this(null, null,null);
    }


    /** Creates a node with the given element, next node, and previous node. */
    public DoubleNode(E e, DoubleNode<E> n, DoubleNode<E> p) {
        element = e;
        next = n;
        previous = p;
    }

    // Accessor methods
    public E getElement() {
        return element;
    }

    public DoubleNode<E> getNext() {
        return next;
    }

    public DoubleNode<E> getPrevious() {
        return previous;
    }

    // Mutator methods
    public void setElement(E newElem) {
        element = newElem;
    }

    public void setNext(DoubleNode<E> newNext){
        next = newNext;
    }

    public void setPrevious(DoubleNode<E> newPrevious){
        previous = newPrevious;
    }
}
