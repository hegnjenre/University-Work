import org.junit.jupiter.api.Order;
import org.junit.jupiter.api.Test;

import java.util.HashMap;

import static org.junit.jupiter.api.Assertions.*;

public class tests {

        @Test
        @Order(1)
        //test that when a new game is created, a new cryptogram is created of the type the user entered
        public void cryptogramGenerationLetter(){
            try {
                Player test = new Player();
                test.init("Test");
                Game testGameLetter = new Game(test, "letter");
                assertNotNull(testGameLetter.currentCryptogram);
                String letterPhrase = testGameLetter.getCurrentCryptogram().phrase.toLowerCase();
                //check that each letter of phrase is contained in cryptogram alphabet
                for (char c : letterPhrase.toCharArray()) {
                    if(Character.isLetter(c)) {
                        assertTrue(testGameLetter.currentCryptogram.getCryptogramAlphabet().containsValue(c));
                    }
                }
                //check that each letter of the phrase is mapped to an alphabetic character
                testGameLetter.currentCryptogram.getCryptogramAlphabet().forEach((key, value) ->
                {assertTrue((char)key >= 'a' && (char)key <= 'z');});
            }
            catch (Exception e) {
                e.printStackTrace();
            }


        }
        @Test
        @Order(2)
        public void cryptogramGenerationNumber(){
            try {
                Player test = new Player();
                test.init("Test");
                Game testGameNumber = new Game(test, "number");
                assertNotNull(testGameNumber.currentCryptogram);
                String numberPhrase = testGameNumber.getCurrentCryptogram().phrase.toLowerCase();
                //check that each letter of phrase is contained in cryptogram alphabet
                for (char c : numberPhrase.toCharArray()) {
                    if(Character.isLetter(c)) {
                        assertTrue(testGameNumber.currentCryptogram.getCryptogramAlphabet().containsValue(c));
                    }
                }
                //check that each letter of the phrase is mapped to a number between 1 and 26 inclusive
                testGameNumber.currentCryptogram.getCryptogramAlphabet().forEach((key, value) ->
                {assertTrue((Integer)key >= 1 && (Integer)key <= 26);});
            }
            catch (Exception e) {
                e.printStackTrace();
            }
        }
        @Test
        @Order(3)
        public void noPhrasesFileMessage(){
            try {

                Player test = new Player();
                test.init("Test");
                Game testGameNoPhrasesFile = new Game(test);
                testGameNoPhrasesFile.filePath = "nophrases.txt";

                //checks that nothing is returned, error message appears in console
                assertEquals(null, testGameNoPhrasesFile.generatePhrase());
            }
            catch (Exception e) {
                e.printStackTrace();
            }
        }
        @Test
        @Order(4)
        public void mapCorrectLetterUpdates(){
            try {
                Player test = new Player();
                test.init("Test");
                Game testGame = new Game(test);
                testGame.currentCryptogram = new Cryptogram("");

                //create crytogram of the word 'test', t is mapped to a, e to b and so on
                testGame.currentCryptogram.getCryptogramAlphabet().put("a", 't');
                testGame.currentCryptogram.getCryptogramAlphabet().put("b", 'e');
                testGame.currentCryptogram.getCryptogramAlphabet().put("c", 's');
                testGame.enterLetter("b", 'e');
                assertEquals(1, test.getTotalCorrectGuesses());
                assertEquals(1, test.getTotalGuesses());

            }
            catch (Exception e) {
                e.printStackTrace();
            }
        }
        @Test
        @Order(5)
        public void mapIncorrectLetterUpdates(){
            try {
                Player test = new Player();
                test.init("Test");
                Game testGame = new Game(test);
                testGame.currentCryptogram = new Cryptogram("");

                //create crytogram of the word 'test', t is mapped to a, e to b and so on
                testGame.currentCryptogram.getCryptogramAlphabet().put("a", 't');
                testGame.currentCryptogram.getCryptogramAlphabet().put("b", 'e');
                testGame.currentCryptogram.getCryptogramAlphabet().put("c", 's');
                testGame.enterLetter("b", 'f');
                assertEquals(0, test.getTotalCorrectGuesses());
                assertEquals(1, test.getTotalGuesses());
            }
            catch (Exception e) {
                e.printStackTrace();
            }
        }

        @Test
        @Order(6)
        public void replaceLetter(){
            try {
                Player test = new Player();
                test.init("Test");
                Game testGame = new Game(test);
                testGame.currentCryptogram = new Cryptogram("");
                //create crytogram of the word 'test', t is mapped to a, e to b and so on
                testGame.currentCryptogram.getCryptogramAlphabet().put("a", 't');
                testGame.currentCryptogram.getCryptogramAlphabet().put("b", 'e');
                testGame.currentCryptogram.getCryptogramAlphabet().put("c", 's');
                testGame.enterLetter("b", 'f');
                //check that the right status has been issued
                assertEquals(0, testGame.enterLetter("b", 'e'));
                testGame.replaceLetter("b", 'e');
                //check that the players guess have been replaced
                assertEquals('e',testGame.getPlayerGameMapping().get("b"));

            }
            catch (Exception e){
                e.printStackTrace();
            }
        }
        @Test
        @Order(7)
        public void repeatedCryptoValue(){
            try {
                Player test = new Player();
                test.init("Test");
                Game testGame = new Game(test);
                testGame.currentCryptogram = new Cryptogram("");
                //create crytogram of the word 'test', t is mapped to a, e to b and so on
                testGame.currentCryptogram.getCryptogramAlphabet().put("a", 't');
                testGame.currentCryptogram.getCryptogramAlphabet().put("b", 'e');
                testGame.currentCryptogram.getCryptogramAlphabet().put("c", 's');
                testGame.enterLetter("b", 'f');
                //try to guess with letter that has already been used for another target letter
                testGame.enterLetter("c", 'f');
                //check guess for repeated target letter has not been made
                assertEquals('f',testGame.getPlayerGameMapping().get("b"));
                assertEquals(null,testGame.getPlayerGameMapping().get("c"));
            }
            catch(Exception e) {
                e.printStackTrace();
            }
        }
        @Test
        @Order(8)
        public void successfulGame(){
            try {
                Player test = new Player();
                test.init("Test");
                Game testGame = new Game(test);
                testGame.currentCryptogram = new Cryptogram("");
                testGame.currentPlayer.incrementCryptogramsPlayed(); // must be done manually since it is actually incremented
                // in the generate function that isn't called here
                //create crytogram of the word 'test', t is mapped to a, e to b and so on
                testGame.currentCryptogram.getCryptogramAlphabet().put("a", 't');
                testGame.currentCryptogram.getCryptogramAlphabet().put("b", 'e');
                testGame.currentCryptogram.getCryptogramAlphabet().put("c", 's');
                testGame.enterLetter("a", 't');
                testGame.enterLetter("b", 'e');
                assertEquals(2, testGame.enterLetter("c", 's'));
                assertEquals(1, test.getNumCryptogramsCompleted());
                assertEquals(1, test.getNumCryptogramsPlayed());


            }
            catch(Exception e) {
                e.printStackTrace();
            }
        }
        @Test
        @Order(9)
        public void failedGame(){
            try {
                Player test = new Player();
                test.init("Test");
                Game testGame = new Game(test);
                testGame.currentCryptogram = new Cryptogram("");
                testGame.currentPlayer.incrementCryptogramsPlayed(); // must be done manually since it is actually incremented
                // in the generate function that isn't called here
                //create crytogram of the word 'test', t is mapped to a, e to b and so on
                testGame.currentCryptogram.getCryptogramAlphabet().put("a", 't');
                testGame.currentCryptogram.getCryptogramAlphabet().put("b", 'e');
                testGame.currentCryptogram.getCryptogramAlphabet().put("c", 's');
                testGame.enterLetter("a", 'f');
                testGame.enterLetter("b", 'e');
                assertEquals(2, testGame.enterLetter("c", 's'));
                assertEquals(0, test.getNumCryptogramsCompleted());
                assertEquals(1, test.getNumCryptogramsPlayed());
            }
            catch(Exception e) {
                e.printStackTrace();
            }
        }
        @Test
        @Order(10)
        public void targetNotInAlphabet(){
            try {
                Player test = new Player();
                test.init("Test");
                Game testGame = new Game(test);
                testGame.currentCryptogram = new Cryptogram("");
                //create crytogram of the word 'test', t is mapped to a, e to b and so on
                testGame.currentCryptogram.getCryptogramAlphabet().put("a", 't');
                testGame.currentCryptogram.getCryptogramAlphabet().put("b", 'e');
                testGame.currentCryptogram.getCryptogramAlphabet().put("c", 's');
                testGame.enterLetter("d", 'f');
                assertEquals(0, test.getTotalCorrectGuesses());
                assertEquals(1, test.getTotalGuesses());
            }
            catch(Exception e) {
                e.printStackTrace();
            }
        }


        @Test
        @Order(11)
        public void undoMappedLetter(){
            try {
                Player test = new Player();
                test.init("Test");
                Game testUndoMappedLetter = new Game(test);
                testUndoMappedLetter.currentCryptogram = new Cryptogram("");

                testUndoMappedLetter.currentCryptogram.getCryptogramAlphabet().put("a", 't');
                testUndoMappedLetter.currentCryptogram.getCryptogramAlphabet().put("b", 'e');
                testUndoMappedLetter.currentCryptogram.getCryptogramAlphabet().put("c", 's');
                testUndoMappedLetter.enterLetter("b", 'e');
                assertEquals('e', testUndoMappedLetter.getPlayerGameMapping().get("b"));
                testUndoMappedLetter.undoLetter("b");
                assertEquals(0, testUndoMappedLetter.getPlayerGameMapping().size());

            }
            catch (Exception e) {
                e.printStackTrace();
            }
        }
        @Test
        @Order(12)
        public void undoNoMappedLetter(){
            try {
                Player test = new Player();
                test.init("Test");
                Game testUndoMappedLetter = new Game(test);
                testUndoMappedLetter.currentCryptogram = new Cryptogram("");

                testUndoMappedLetter.currentCryptogram.getCryptogramAlphabet().put("a", 't');
                testUndoMappedLetter.currentCryptogram.getCryptogramAlphabet().put("b", 'e');
                testUndoMappedLetter.currentCryptogram.getCryptogramAlphabet().put("c", 's');
                testUndoMappedLetter.undoLetter("b");
                assertEquals(0, testUndoMappedLetter.getPlayerGameMapping().size());
            }
            catch (Exception e) {
                e.printStackTrace();
            }
        }


        // for some reason Junit does not save or load to the same file path that main does?
        // even though it is an explicit file path to Cryptogram Assignment/src/players.txt
        // I do not know how to make JUnit save and load to the correct place
        //@Test
        @Order(13)
        public void SavingAndLoading(){
            // instantiate test player
            Players allPlayers = new Players();
            Player p =  new Player();
            p.init("Test");

            // give the player some history
            p.incrementCryptogramsPlayed();
            p.incrementNumGuesses();
            p.incrementNumCorrectGuesses();

            // add them to allplayers list
            allPlayers.addPlayer(p);

            // save the list of all players to the file
            allPlayers.savePlayers();
            System.out.println(allPlayers.getAllPlayers());

            // load all players into a fresh new players list
            Players newPlayers = new Players();
            newPlayers.loadPlayers();
            System.out.println(newPlayers.getAllPlayers());


            // get the index of the player we have saved to the file
            // this should not equal -1
            int index = newPlayers.findPlayer(p);
            assertNotEquals(-1, index, "Player should be found in file as they have been saved");

            // create a new instance of the player class and get the player we saved to the file
            Player currentPlayer = newPlayers.getAllPlayers().get(index);


            // check to ensure the history given to the player before writing to file matches
            assertEquals("Test", currentPlayer.getUsername());
            assertEquals(1, currentPlayer.getNumCryptogramsPlayed());
            assertEquals(1, currentPlayer.getTotalGuesses());
            assertEquals(1, currentPlayer.getTotalCorrectGuesses());

        }

        @Test
        @Order(14)
        public void displayPlayerStats(){
            Players allPlayers = new Players();
            Player p =  new Player();
            p.init("Test");

            // give player some statistics
            p.setCryptogramsPlayed(10);
            p.setCryptogramsCompleted(5);
            p.setTotalGuesses(100);
            p.setTotalCorrectGuesses(50);


            // add player to allplayers and get the index of the test player
            allPlayers.addPlayer(p);
            allPlayers.savePlayers();
            int index = allPlayers.findPlayer(p);

            // should pass this test as the player has been added to allplayers
            assertNotEquals(-1, index, "Player should be found in file as they have been saved");

            // display the stats of the user on screen
            allPlayers.showStatistics(index);


        }

        @Test
        @Order(15)
        public void displayLeaderboard(){
            Players allPlayers = new Players();
            for(int i = 0; i<11; i++) {
                Player p =  new Player();
                p.init("p" + Integer.toString(i));
                p.setCryptogramsPlayed(100+i);
                p.setCryptogramsCompleted(70+i);
                allPlayers.addPlayer(p);
            }
            allPlayers.savePlayers();
            assertEquals("No.\tUsername\tGames Completed\n1\tp10\t\t\t80\n2\tp9\t\t\t79\n3\tp8\t\t\t78\n4\tp7\t\t\t77\n5\tp6\t\t\t76\n6\tp5\t\t\t75\n7\tp4\t\t\t74\n8\tp3\t\t\t73\n9\tp2\t\t\t72\n10\tp1\t\t\t71\n", allPlayers.leaderboard());
            Player edit = allPlayers.getAllPlayers().get(10); // get p10
            edit.setCryptogramsCompleted(78);                 // change p10 to be worse than p9, so lower on the leaderboard
            allPlayers.savePlayers();
            assertEquals("No.\tUsername\tGames Completed\n1\tp9\t\t\t79\n2\tp10\t\t\t78\n3\tp8\t\t\t78\n4\tp7\t\t\t77\n5\tp6\t\t\t76\n6\tp5\t\t\t75\n7\tp4\t\t\t74\n8\tp3\t\t\t73\n9\tp2\t\t\t72\n10\tp1\t\t\t71\n", allPlayers.leaderboard());
        }

        @Test
        @Order(16)
        public void testNoPlayersNoLeaderBoard(){
            Players allPlayers = new Players();
            assertEquals("Nothing to show on leaderboard\n", allPlayers.leaderboard());
        }

        @Test
        @Order(17)
        public void testHintGivenAndCorrect(){
            try {
                Player test = new Player();
                test.init("Test");
                Game testGame = new Game(test);
                testGame.currentCryptogram = new Cryptogram("");
                //create crytogram of the word 'of', small so we can track where the hint has been placed
                testGame.currentCryptogram.getCryptogramAlphabet().put("a", 'o');
                testGame.currentCryptogram.getCryptogramAlphabet().put("b", 'f');
                testGame.getHint();
                assertEquals(1, testGame.playerGameMapping.size()); // check that hint has added an answer
                HashMap<Object, Character> getMap = testGame.getPlayerGameMapping();
                assertTrue((getMap.containsKey("a") && getMap.get("a") == 'o') || (getMap.containsKey("b") && getMap.get("b") == 'f'));
                                                                            // check both possibilities
            }
            catch(Exception e) {
                e.printStackTrace();
            }
        }

        @Test
        @Order(18)
        public void testSolutionIsCorrect(){
            try {
                Player test = new Player();
                test.init("Test");
                Game testGame = new Game(test);
                testGame.currentCryptogram = new Cryptogram("test");
                testGame.currentCryptogram.getCryptogramAlphabet().put("a", 't');
                testGame.currentCryptogram.getCryptogramAlphabet().put("b", 'e');
                testGame.currentCryptogram.getCryptogramAlphabet().put("c", 's');
                assertEquals(("Key: a=t b=e c=s \nPhrase: " + testGame.getCurrentCryptogram().getPhrase() + "\n"), testGame.showSolution());
            }
            catch(Exception e) {
                e.printStackTrace();
            }
        }

        @Test
        @Order(19)
        public void checkFrequenciesEmpty(){
            try {
                Player test = new Player();
                test.init("Test");
                Game testGame = new Game(test);
                testGame.currentCryptogram = new Cryptogram("");
                HashMap<Object, Integer> testMap = testGame.getCurrentCryptogram().getFrequencies();
                assertTrue(testMap.isEmpty());
            }
            catch(Exception e) {
                e.printStackTrace();
            }
        }

        @Test
        @Order(20)
        public void checkFrequencies(){
            try {
                Player test = new Player();
                test.init("Test");
                Game testGame = new Game(test);
                testGame.currentCryptogram = new Cryptogram("tteesstt");
                testGame.currentCryptogram.getCryptogramAlphabet().put("a", 't');
                testGame.currentCryptogram.getCryptogramAlphabet().put("b", 't');
                testGame.currentCryptogram.getCryptogramAlphabet().put("c", 't');
                testGame.currentCryptogram.getCryptogramAlphabet().put("d", 't');
                testGame.currentCryptogram.getCryptogramAlphabet().put("e", 'e');
                testGame.currentCryptogram.getCryptogramAlphabet().put("f", 'e');
                testGame.currentCryptogram.getCryptogramAlphabet().put("g", 's');
                testGame.currentCryptogram.getCryptogramAlphabet().put("h", 's');
                HashMap<Object, Integer> testMap = testGame.getCurrentCryptogram().getFrequencies();
                assertEquals(4, testMap.get('t'));
                assertEquals(2, testMap.get('e'));
                assertEquals(2, testMap.get('s'));
            }
            catch(Exception e) {
                e.printStackTrace();
            }
        }
    }
