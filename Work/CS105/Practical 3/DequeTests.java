import static org.junit.Assert.*;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

public class DequeTests {

    private Deque<Integer> deque;

    @Before
    public void setUp() {
        deque = new Deque<>();
    }

    @After
    public void tearDown() {
        deque = null; // Clean up the deque after each test
    }

    @Test
    public void testInsertFront() {
        deque.insertFront(10);
        assertEquals("Front should be 10", (Integer) 10, deque.getFront());
        assertEquals("Size should be 1", 1, deque.size());

        deque.insertFront(20);
        assertEquals("Front should be 20", (Integer) 20, deque.getFront());
        assertEquals("Size should be 2", 2, deque.size());
    }

    @Test
    public void testInsertRear() {
        deque.insertRear(30);
        assertEquals("Rear should be 30", (Integer) 30, deque.getRear());
        assertEquals("Size should be 1", 1, deque.size());

        deque.insertRear(40);
        assertEquals("Rear should be 40", (Integer) 40, deque.getRear());
        assertEquals("Size should be 2", 2, deque.size());
    }

    @Test
    public void testDeleteFront() {
        deque.insertRear(50);
        deque.insertRear(60);
        assertEquals("Deleted front should be 50", (Integer) 50, deque.deleteFront());
        assertEquals("New front should be 60", (Integer) 60, deque.getFront());
        assertEquals("Size should be 1", 1, deque.size());
    }

    @Test
    public void testDeleteRear() {
        deque.insertFront(70);
        deque.insertFront(80);
        assertEquals("Deleted rear should be 70", (Integer) 70, deque.deleteRear());
        assertEquals("New front should be 80", (Integer) 80, deque.getFront());
        assertEquals("Size should be 1", 1, deque.size());
    }

    @Test
    public void testGetFront() {
        deque.insertFront(90);
        assertEquals("Front should be 90", (Integer) 90, deque.getFront());
        deque.insertRear(100);
        assertEquals("Front should still be 90", (Integer) 90, deque.getFront());
    }

    @Test
    public void testGetRear() {
        deque.insertRear(110);
        assertEquals("Rear should be 110", (Integer) 110, deque.getRear());
        deque.insertFront(120);
        assertEquals("Rear should still be 110", (Integer) 110, deque.getRear());
    }

    @Test
    public void testIsEmpty() {
        assertTrue("Deque should be empty", deque.isEmpty());
        deque.insertFront(130);
        assertFalse("Deque should not be empty", deque.isEmpty());
        deque.deleteFront();
        assertTrue("Deque should be empty again", deque.isEmpty());
    }

    @Test
    public void testSize() {
        assertEquals("Size should be 0", 0, deque.size());
        deque.insertRear(140);
        assertEquals("Size should be 1", 1, deque.size());
        deque.insertFront(150);
        assertEquals("Size should be 2", 2, deque.size());
        deque.deleteRear();
        assertEquals("Size should be 1", 1, deque.size());
    }

}
