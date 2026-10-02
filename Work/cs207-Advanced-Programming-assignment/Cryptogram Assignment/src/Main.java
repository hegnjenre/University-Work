import java.io.*;

import org.junit.jupiter.api.Order;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Set;
import java.util.concurrent.atomic.AtomicBoolean;

public class Main {
    public static void main(String[] args) throws IOException {

        // before the game is started, load all players in from the players.txt file
        Players allplayers = new Players();
        allplayers.loadPlayers();

        BufferedReader reader = new BufferedReader(
                new InputStreamReader(System.in));

        String input;
        boolean exit = false;
        boolean gameExit = false;

        System.out.println("------------- Cryptogram Game (Text Version) -------------");
        System.out.println("Please enter your username below");
        String username = reader.readLine();

        // creates a new instance of the player class and sets the name to the username entered
        Player currentPlayer = new Player();
        currentPlayer.init(username);

        // fetch the index of where the player is stored in the Players class
        int playerIndex = allplayers.findPlayer(currentPlayer);


        if (playerIndex == -1) { // if the player is not in the file, create an account for the new player
            allplayers.addPlayer(currentPlayer);
            playerIndex = allplayers.findPlayer(currentPlayer);
            System.out.println("Account created for " + username);
        }
        else { // player has been found in the file
            currentPlayer = allplayers.getAllPlayers().get(playerIndex);
            System.out.println("Account found, welcome back " +  username);
        }

        try {
            while (!exit) {
                gameExit = false;
                System.out.println("Enter \"start\" to start a game, \"stats\" to view your stats or \"exit\" to exit: ");
                input = reader.readLine();

                if (input.equals("view statistics")) {
                    allplayers.showStatistics(playerIndex);
                }

                if (input.equals("start")) {
                    System.out.println("Enter \"letter\" for a letter cryptogram or \"number\" for a number cryptogram: ");
                    input = reader.readLine();

                    if (input.equals("letter") || input.equals("number")) {
                        Game newGame = new Game(currentPlayer, input);
                        String correctPhrase = newGame.getCurrentCryptogram().phrase;
                        currentPlayer.incrementCryptogramsPlayed();

                        while (!gameExit) {
                            System.out.println("Current Cryptogram: ");
                            for(char c: correctPhrase.toCharArray()) {
                                if(c >= 'a' && c <= 'z') {
                                    newGame.currentCryptogram.getCryptogramAlphabet().forEach((key, value) ->
                                    {if (value == c && key.getClass().getName().equals("java.lang.Integer")) {System.out.print(key + " ");}
                                    else if(value == c && key.getClass().getName().equals("java.lang.Character")){System.out.print(key);}});
                                }
                                else if(c == ' '){
                                    System.out.print(" ");
                                }

                            }
                            System.out.println();
                            for(char c: correctPhrase.toCharArray()) {
                                int keysIndex = 0;
                                int objIndex = 0;
                                Boolean keyFound = false;
                                if(c >= 'a' && c <= 'z') {
                                    Boolean found = false;
                                    Object[] keys = newGame.currentCryptogram.getCryptogramAlphabet().keySet().toArray();

                                    while(!keyFound && keysIndex < keys.length){ //finds correct keyIndex for current key
                                        if (newGame.getCurrentCryptogram().getCryptogramAlphabet().get(keys[keysIndex]).equals(c)){
                                            keyFound = true;
                                        }
                                        else{keysIndex++;}
                                    }

                                    if (keys[keysIndex].getClass().getName().equals("java.lang.Integer")) {
                                        String intKeyToStr = keys[keysIndex].toString();
                                        //this is basically the unwrapped version of the previous lambda function,
                                        //this way we can have a condition for the length of the key, to properly adjust the player key string
                                        while(!found && objIndex < keys.length){ //finds whether current letter has had a guess input
                                            if (newGame.playerGameMapping.get(keys[objIndex]) != null &&
                                                    newGame.getCurrentCryptogram().getCryptogramAlphabet().get(keys[objIndex]).equals(c)){
                                                found = true;
                                            }
                                            else{objIndex++;}
                                        }

                                        if (found){ // guess is in playerGameMapping
                                            if (intKeyToStr.length() > 1) {
                                                System.out.print(newGame.playerGameMapping.get(keys[objIndex]) + "  ");
                                            }
                                            else{
                                                System.out.print(newGame.playerGameMapping.get(keys[objIndex]) + " ");
                                            }
                                        }

                                        else { // guess is not
                                            if (intKeyToStr.length() > 1) { //double digit
                                                System.out.print("__ ");
                                            } else {                           //single digit
                                                System.out.print("_ ");
                                            }
                                        }
                                    }
                                    else if(keys[keysIndex].getClass().getName().equals("java.lang.Character")){
                                        while(!found && objIndex < keys.length){ //finds whether current letter has had a guess input
                                            if (newGame.playerGameMapping.get(keys[objIndex]) != null &&
                                                    newGame.getCurrentCryptogram().getCryptogramAlphabet().get(keys[objIndex]).equals(c)){
                                                found = true;
                                            }
                                            else{objIndex++;}
                                        }

                                        if (found) { // guess is in playerGameMapping
                                            System.out.print(newGame.playerGameMapping.get(keys[objIndex]));
                                        }
                                        else {
                                            System.out.print("_");
                                        }
                                    }
                                }
                                else if(c == ' '){
                                    System.out.print(" ");
                                }

                            }
                            System.out.println();

                            System.out.println("What do you want to do?\n");
                            System.out.println("1: enter a guess");
                            System.out.println("2: undo a guess");
                            System.out.println("3: exit the game");
                            System.out.println("4: get a hint");
                            System.out.println("5: show solution");
                            input = reader.readLine();
                            switch (input) {
                                case "1", "guess":
                                    Object targetLetter;
                                    Object guess;
                                    System.out.println("What letter would you like to guess for?");
                                    input = reader.readLine();
                                    if(isInt(input)){ // converts to ascii to check if number
                                        targetLetter = Integer.valueOf(input);
                                    }
                                    else {
                                        targetLetter = Character.toLowerCase(input.charAt(0));
                                    }
                                    System.out.println("What is your guess for "+targetLetter+"?");
                                    input = reader.readLine();
                                    guess = Character.toLowerCase(input.charAt(0));
                                    switch (newGame.enterLetter((Object)targetLetter, (char) guess)){
                                        case 0:
                                            input = reader.readLine();
                                            if(input.equals("y")){newGame.overwriteLetter(targetLetter, (char) guess);}
                                            else if (input.equals("n")){System.out.println("No Overwriting Done");}
                                            else{System.out.println("Invalid Key");}
                                        case 1:
                                            break;
                                        case 2:
                                            gameExit = true;
                                    }
                                    break;
                                case "2", "undo":
                                    System.out.println("Which of your guesses would you like to undo?");
                                    input = reader.readLine();
                                    if (isInt(input)) {
                                        newGame.undoLetter(Integer.valueOf(input));
                                    }
                                    else{
                                        newGame.undoLetter(input.charAt(0));
                                    }
                                    break;
                                case "3", "exit":
                                    gameExit = true;
                                case "4", "hint":
                                    newGame.getHint();
                                    break;
                                case "5", "solution":
                                    System.out.println(newGame.showSolution());
                                    gameExit = true;
                                    break;
                            }
                        }
                    }
                    else{
                        System.out.println("Cryptogram must be of type letter or number");
                    }
                }
                else if (input.equalsIgnoreCase("stats")){
                    currentPlayer.displayStats();
                }
                else if (input.equalsIgnoreCase("exit")){
                    exit = true;
                }
                else{
                    System.out.println("Invalid Input.");
                }
            }
            allplayers.savePlayers();
            System.out.println("Player data saved into text file");
        }catch (Exception e) {
            e.printStackTrace();
            System.exit(0);
        }
    }

    public static boolean isInt(String input){
        if ((int) input.charAt(0) > 47 && (int) input.charAt(0) < 58) {return true;}
        else{return false;}
    }
}