import java.util.HashMap;
import java.util.LinkedHashSet;
import java.util.Set;
import java.util.List;
import java.util.Collections;
import java.util.ArrayList;


public class LetterCryptogram extends Cryptogram {

    protected HashMap<Character,Character> cryptogramAlphabet = new HashMap<>();

    public LetterCryptogram(String phrase, Set<Character> uniqueChars) {
        super(phrase);
        setCryptogramAlphabet(uniqueChars);

    }

    // takes in a letter and returns the corresponding letter this maps to
    public char getPlainLetter(char cryptoLetter) {
        return cryptogramAlphabet.get(cryptoLetter);
    }
    public void setCryptogramAlphabet(Set<Character> uniqueChars) {
        int count = 0;
        List<Character> letters = new ArrayList<>();
        for (char c = 'a'; c <= 'z'; c++) {
            letters.add(c);
        }
        Collections.shuffle(letters);
        for (Character c : uniqueChars) {
            this.cryptogramAlphabet.put(c, letters.get(count));
            this.setCryptogramAlphabet((Object)letters.get(count), c);
            count++;
        }
    }

}
