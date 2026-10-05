import java.io.*;
import java.util.*;

public class Player {

    private String username;
    private double accuracy;   // percentage accuracy e.g 63.25 = 0.6325
    private int totalGuesses;
    private int totalCorrectGuesses;
    private int cryptogramsPlayed;
    private int cryptogramsCompleted;

    public void init(String name){
        username = name;
        accuracy = 0.0; // initialise accuracy as 0.0, as they have completed no games
        totalGuesses = 0;
        totalCorrectGuesses = 0;
        cryptogramsPlayed = 0;
        cryptogramsCompleted = 0;
    }

    public String  getUsername() {
        return username;
    }

    public double getAccuracy(){return accuracy;}

    public int getNumCryptogramsPlayed(){return cryptogramsPlayed;}

    public int getNumCryptogramsCompleted(){return cryptogramsCompleted;}

    public void setCryptogramsPlayed(int cryptogramsPlayed){
        this.cryptogramsPlayed = cryptogramsPlayed;
    }

    public void setCryptogramsCompleted(int cryptogramsCompleted){
        this.cryptogramsCompleted = cryptogramsCompleted;
    }

    public void setTotalGuesses(int totalGuesses){
        this.totalGuesses = totalGuesses;
    }

    public void setTotalCorrectGuesses(int totalCorrectGuesses){
        this.totalCorrectGuesses = totalCorrectGuesses;
    }

    public void updateAccuracy(){accuracy = ((double) (totalCorrectGuesses) / totalGuesses) * 100;}

    public void incrementCryptogramsCompleted(){cryptogramsCompleted++;}

    public void incrementCryptogramsPlayed(){cryptogramsPlayed++;}

    public void incrementNumGuesses(){totalGuesses++;}

    public void incrementNumCorrectGuesses(){totalCorrectGuesses++;}

    public int getTotalGuesses(){return totalGuesses;}

    public int getTotalCorrectGuesses(){return totalCorrectGuesses;}

    public void displayStats(){
        updateAccuracy();
        System.out.println(this.username + ":\n" +
                        "   Guess Accuracy: " + this.accuracy + "%\n" +
                        "   Total Guesses: " + this.totalGuesses + "\n" +
                        "   Correct Guesses: " + this.totalCorrectGuesses + "\n" +
                        "   Incorrect Guesses: " + (this.totalGuesses - this.totalCorrectGuesses) + "\n" +
                        "   Cryptograms Played: " + this.cryptogramsPlayed + "\n" +
                        "   Cryptograms Completed: " + this.cryptogramsCompleted);
    }

    // ensure correct format when saving player details to file
    @Override
    public String toString(){
        return username + "," + cryptogramsPlayed + "," + cryptogramsCompleted + "," + totalGuesses + "," + totalCorrectGuesses;
    }

}
