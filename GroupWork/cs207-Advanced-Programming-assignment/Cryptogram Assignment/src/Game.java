import java.io.BufferedReader;
import java.io.IOException;
import java.security.Key;
import java.util.*;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.BufferedReader;
import java.util.Random;

public class Game  {
    Player currentPlayer;
    protected HashMap<Object, Character> playerGameMapping = new HashMap<>();

    protected Cryptogram currentCryptogram;
    protected String cryptType;

    protected String filePath = "phrases.txt";


    public Game(Player currentPlayer, String cryptType) throws IOException, InterruptedException {

        this.currentPlayer = currentPlayer;
        this.cryptType = cryptType;
        generateCryptogram(cryptType);

    }
    public Game(Player currentPlayer) throws IOException, InterruptedException {
        this.currentPlayer = currentPlayer;
    }


    // method for generating a new cryptogram
    public void generateCryptogram(String cryptType) throws IOException, InterruptedException  {

        String phrase = generatePhrase().toLowerCase();
        Set<Character> uniqueChars = getUniqueChars(phrase);
        currentPlayer.incrementCryptogramsPlayed();
        if(cryptType.equals("letter")) {
            this.currentCryptogram = new LetterCryptogram(phrase, uniqueChars);
        }
        else {
            this.currentCryptogram = new NumberCryptogram(phrase, uniqueChars);
        }

    }

    /**
     * method for allowing the player to enter a letter
     * @param targetLetter stores the integer or character that maps to a character in the phrase
     * @param guess is what the user thinks is the actual letter in the phrase for that integer or character
     * status is determined by numbers as follows:-
     *
     *             -1 = cryptogram not generated
     *              0 = game ongoing, player needs to make decision
     *              1 = game continues
     *              2 = game is over
     *
     */
    public int enterLetter(Object targetLetter, char guess) {

        // check to ensure that a cryptogram has been generated
        if (currentCryptogram == null) {
            System.out.println("A cryptogram has not been generated yet");
            return -1;
        }
        //check if the player has already made a guess for this letter
        else if (playerGameMapping.get(targetLetter) != null) {
            System.out.println("A mapping has already been entered for " + targetLetter + ", would you like to overwrite this (y/n)?");
            return 0;
        }
        else if (!currentCryptogram.getCryptogramAlphabet().containsKey(targetLetter)) {
            System.out.println(targetLetter + " cannot be guessed");
            currentPlayer.incrementNumGuesses();
            return 1;
        }
        else if(playerGameMapping.containsValue(guess)) {
            System.out.println("You have already tried to map a letter to this value");
            currentPlayer.incrementNumGuesses();
            return 1;
        }
        else {
            // stores this guess in the players map
            playerGameMapping.put(targetLetter, guess);
            //increment number of correct guesses and total guesses if guess correct, otherwise just increment total guesses
            if(guess == currentCryptogram.getCryptogramAlphabet().get(targetLetter)) { // correct
                currentPlayer.incrementNumCorrectGuesses();
                currentPlayer.incrementNumGuesses();
            }
            else { // incorrect
                currentPlayer.incrementNumGuesses();
            }
            //checks if the number of mappings entered by the user match that in the cryptogram alphabet
            if(playerGameMapping.size() == currentCryptogram.getCryptogramAlphabet().size()) {
                //check if the user mappings match that in the cryptogram alphabet
                if(playerGameMapping.equals(currentCryptogram.getCryptogramAlphabet())) {
                    System.out.println("You have successfully guessed the cryptogram!");
                    currentPlayer.incrementCryptogramsCompleted();
                    return 2;
                }
                else {
                    //game over
                    System.out.println("You were unsuccessful in guessing the cryptogram");
                    return 2;
                }
            }
            else {currentPlayer.updateAccuracy(); return 1;}
        }
    }

    public void overwriteLetter(Object target, char guess){
        playerGameMapping.remove(target);
        playerGameMapping.put(target, guess);
    }

    // removes a chosen letter a user has entered
    public void undoLetter(Object target) {
        if (currentCryptogram == null) {
            System.out.println("A cryptogram has not been generated yet");
            return;
        }

        // checks if the player mapping contains the target
        // if so it is removed
        if (playerGameMapping.containsKey(target)) {
            playerGameMapping.remove(target);
        }
        else {
            System.out.println("letter has not been found");
        }


    }
    public void viewFrequencies() {
        System.out.println(currentCryptogram.getFrequencies());

    }

    public String generatePhrase() {
        Random rand = new Random();
        ArrayList<String> list = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(Game.class.getResourceAsStream(filePath)))) {
            String line;
            while ((line = reader.readLine()) != null) {
                list.add(line);
            }
        } catch (IOException e) {
            System.out.println("Error reading file");
            return null;
        }
        catch (NullPointerException n) {
            System.out.println("Invalid file path");
            return null;
        }
        int randomNum = rand.nextInt(15); //get random line number of quote
        return list.get(randomNum);

    }
    public Set<Character> getUniqueChars(String phrase) {
        Set<Character> uniqueChars = new LinkedHashSet<>();
        for (char ch : phrase.toCharArray()) {
            if (Character.isLetter(ch)) { // Only add if alphanumeric char
                uniqueChars.add(Character.toLowerCase(ch));

            }
        }

        return uniqueChars;
    }
    public void replaceLetter(Object targetLetter, char guess) {
        playerGameMapping.remove(targetLetter);
        playerGameMapping.put(targetLetter, guess);
        if(guess == currentCryptogram.getCryptogramAlphabet().get(targetLetter)) {
            currentPlayer.incrementNumCorrectGuesses();
            currentPlayer.incrementNumGuesses();
        }
        else {
            currentPlayer.incrementNumGuesses();
        }
    }

    public HashMap<Object, Character> getPlayerGameMapping() {
        return playerGameMapping;
    }
    public Cryptogram getCurrentCryptogram() {
        return currentCryptogram;
    }

    public String showSolution() {
        String mappings = "";
        Object[] keys = this.currentCryptogram.getCryptogramAlphabet().keySet().toArray();
        for(int i=0; i<keys.length; i++){
            mappings += (keys[i] + "=" + this.currentCryptogram.getCryptogramAlphabet().get(keys[i]) + " ");
        }
        return ("Key: " + mappings + "\nPhrase: " + this.currentCryptogram.getPhrase() + "\n");
    }
    public void getHint(){
        HashMap<Object, Character> tempMappings = new HashMap<>();

        //fill tempMapping up with the correct mappings
        this.currentCryptogram.getCryptogramAlphabet().forEach((key, value) -> tempMappings.put(key, value));
        //eliminate any correct guesses the user has made from tempMappings
        this.playerGameMapping.forEach((key, value)-> {if(tempMappings.containsKey(key) && tempMappings.get(key) == value){tempMappings.remove(key);}});
        ArrayList<Object> keySet = new ArrayList<>(tempMappings.keySet());
        int randIndex  = new Random().nextInt(keySet.size());
        Object key = keySet.get(randIndex);
        if(playerGameMapping.containsKey(key)) {
            playerGameMapping.remove(key);
            playerGameMapping.put(key, tempMappings.get(key));
        }
        else {
            playerGameMapping.put(key, tempMappings.get(key));
        }
    }
}
