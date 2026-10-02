import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Objects;

public class Cryptogram {

    protected String phrase;

    protected HashMap<Object, Character> cryptogramAlphabet = new HashMap<>();

    public Cryptogram(String phrase) {

        this.phrase = phrase;
    }
    public void setCryptogramAlphabet(Object key, Character value) {
        cryptogramAlphabet.put(key, value);
    }

    public String getPhrase() {
        return phrase;
    }
    public HashMap<Object, Character> getCryptogramAlphabet() {
        return cryptogramAlphabet;
    }


    public HashMap<Object, Integer> getFrequencies() {
        HashMap<Object, Integer> frequencies = new HashMap<>();

        // stores the phrase in an array of chars so each character can be processed one at a time
        // coverts to upper case so the same characters in upper and lower case are not counted separately
        char[] phraseArray = phrase.replaceAll("\\s+", "").toLowerCase().toCharArray();


        // loops through each character in the phraseArray
        for (char c : phraseArray) {
            // only checks character if it is not a space or punctuation
            if (Character.isLetter(c)) {
                frequencies.put(c, frequencies.getOrDefault(c, 0) + 1);
            }
        }

        return frequencies;
    }
}
