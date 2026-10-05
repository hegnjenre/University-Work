import java.io.*;
import java.util.*;

public class Players {
    private List<Player> allPlayers = new ArrayList<Player>();
    private File playersFile;

    public List<Player> getAllPlayers() {
        return allPlayers;
    }

    public void addPlayer(Player p){allPlayers.add(p);}

    public void savePlayers() {
        //write allPlayers to playersFile

        try (PrintWriter writer = new PrintWriter(new FileWriter("Cryptogram Assignment/src/players.txt"))) {
            for (Player p : allPlayers) {
                writer.println(p.toString());
            }
        } catch (IOException e) {
            System.out.println("error writing to players file " + e.getMessage());

        }

    }

    // loads players in from an empty file
    public void loadPlayers() {

        String filePath = "Cryptogram Assignment/src/players.txt";
        File playersRead = new File(filePath);

        // deals with case where file has not been created


        allPlayers.clear(); // clear allplayers before loading to prevent duplicates


        try (Scanner reader = new Scanner(playersRead)) {

            String line;

            // loops while there are still lines to be read in the file
            while (reader.hasNextLine()) {
                line = reader.nextLine();

                String[] playerData = line.split(",");

                if (playerData.length == 5) { // condition ensures only players are read in if stored in the correct format
                    Player p = new Player();
                    p.init(playerData[0]);
                    p.setCryptogramsPlayed(Integer.parseInt(playerData[1]));
                    p.setCryptogramsCompleted(Integer.parseInt(playerData[2]));
                    p.setTotalGuesses(Integer.parseInt(playerData[3]));
                    p.setTotalCorrectGuesses(Integer.parseInt(playerData[4]));

                    allPlayers.add(p); // adds player to the allPlayers list when the dat has been loaded

                }
            }
        } catch (FileNotFoundException e) {
            System.out.println("error reading players file " + e.getMessage());
        }
    }

    public int findPlayer(Player p){

        for (int i = 0; i < allPlayers.size(); i++) {
          if (allPlayers.get(i).getUsername().equals(p.getUsername())) {
          return i;}
        }
        return -1;
    }

    public double[] getAllPlayersAccuracies(){
        double[] accuracies = new double[allPlayers.size()];
        for(int i = 0; i < allPlayers.size(); i++){
            accuracies[i] = allPlayers.get(i).getAccuracy();
        }
        return accuracies;
    }

    public double[] getAllPlayersCryptogramsPlayed(){
        double[] played = new double[allPlayers.size()];
        for(int i = 0; i < allPlayers.size(); i++){
            played[i] = allPlayers.get(i).getNumCryptogramsPlayed();
        }
        return played;
    }
    public double[] getAllPlayersCryptogramsCompleted(){
        double[] completed = new double[allPlayers.size()];
        for(int i = 0; i < allPlayers.size(); i++){
            completed[i] = allPlayers.get(i).getNumCryptogramsCompleted();
        }
        return completed;
    }

    public void showStatistics(int index) {

        // check to ensure that the player index passed in is valid
        if (index >= 0  && index < allPlayers.size()) {
            // get the player we want to display from all players
            Player p = allPlayers.get(index);

            // display all stats stored in the file for this player on screen
            System.out.println("YOUR STATISTICS");
            System.out.println("Username: " + p.getUsername());
            System.out.println("Cryptograms played: " + p.getNumCryptogramsPlayed());
            System.out.println("Cryptograms completed: " + p.getNumCryptogramsCompleted());
            System.out.println("Total guesses: " + p.getTotalGuesses());
            System.out.println("Total correct guesses: " + p.getTotalCorrectGuesses());

        }
        else {
            // error message is displayed if index is out of bounds
            System.out.println("unable to display the statistics, player not found");
        }

    }

    public String leaderboard() {
        if(allPlayers.isEmpty()) {
            return "Nothing to show on leaderboard\n";
        }
        int tempMax;
        String finalLeaderboard= "";
        Player tempMaxPlayer;
        List<Player> tempPlayers = new ArrayList<>(List.copyOf(allPlayers));
        finalLeaderboard += ("No.\tUsername\tGames Completed\n");
        for (int i = 0; i < 10; i++) {
            tempMax = -1;
            if (tempPlayers.isEmpty()) {
                finalLeaderboard += (i+1 + "\n");
            }
            else {
            tempMaxPlayer = tempPlayers.getFirst();
            for (Player p : tempPlayers) {
                if (p.getNumCryptogramsCompleted() >= tempMax) {
                    tempMax = p.getNumCryptogramsCompleted();
                    tempMaxPlayer = p;
                }
            }
                finalLeaderboard += ((i + 1) + "\t" + tempMaxPlayer.getUsername() + "\t\t\t" + tempMax + "\n");
                tempPlayers.remove(tempMaxPlayer);
            }
        }
        return finalLeaderboard;
    }
}
