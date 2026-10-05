import java.util.HashMap;
import java.util.LinkedHashSet;
import java.util.Set;
import java.util.List;
import java.util.ArrayList;
import java.util.Collections;

public class NumberCryptogram extends Cryptogram {

    protected HashMap<Integer, Character> cryptogramAlphabet = new HashMap<>();

    public NumberCryptogram(String phrase, Set<Character> uniqueChars) {
        super(phrase);
        setCryptogramAlphabet(uniqueChars);



    }

    // takes in a number and returns the corresponding letter this maps to
    public char getPlainLetter(int cryptoValue) {
            return cryptogramAlphabet.get(cryptoValue);
    }

    public void setCryptogramAlphabet(Set<Character> uniqueChars) {
        int count = 0;
        ArrayList<Integer> numbers = new ArrayList<>();
        for (int i = 1; i <= 26; i++) {
            numbers.add(i);
        }
        Collections.shuffle(numbers);
        for (Character c : uniqueChars) {
            cryptogramAlphabet.put(numbers.get(count), c);
            this.setCryptogramAlphabet((Object)numbers.get(count), c);
            count++;
        }
    }
}
