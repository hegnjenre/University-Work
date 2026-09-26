import au.com.bytecode.opencsv.CSVWriter;
import java.util.Arrays;
import java.io.*;

public class SortTests extends Sortings {

    private static int testLength = 360;
    private static int loopLength = 4000;

    public static void writeDataLineByLine(String filePath, long[] TimeTakenAvgSel, long[] TimeTakenAvgMer)
    {
        // first create file object for file placed at location
        // specified by filepath
        File file = new File(filePath);
        try {
            // create FileWriter object with file as parameter
            FileWriter outputfile = new FileWriter(file);

            // create CSVWriter object filewriter object as parameter
            CSVWriter writer = new CSVWriter(outputfile);

            // adding header to csv
            String[] headerSel = {"Length n ", "Selection Sort Time", "Mergesort Time"};
            writer.writeNext(headerSel);

            // add data to csv
            for(int i=0; i<testLength; i++) {
                //System.out.println("avg at " + i + ": " + Long.toString(TimeTakenAvgSel[i]));
                String[] dataSel = {Integer.toString(i), Long.toString(TimeTakenAvgSel[i]), Long.toString(TimeTakenAvgMer[i])};
                writer.writeNext(dataSel);
            }

            // closing writer connection
            writer.close();
        }
        catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        int[] testArray;
        long longestTime = 0;
        int removeFirst = 0;
        long[] timeAvgSel = new long[testLength];
        long[] timeAvgMer = new long[testLength];
        boolean ihatethevm = false;

        //int[] test = {11,10,9,8,7,6,5,4,3,2,1};
        //merge_sort(test, test.length);
        //selection_sort(test, test.length);
        //System.out.println(Arrays.toString(test));

        for(int n = 0; n < testLength; n++){
            //System.out.println("MERGE " + n);
            for(int loop = 1; loop<=loopLength; loop++){
                //System.out.println("Length: " + n);
                steps = 0;
                timeTaken = 0;
                testArray = genArray(sortArray, n).clone();
                //System.out.println("Before: " + Arrays.toString(testArray));
                long endTime;
                long startTime = System.nanoTime();
                merge_sort(testArray, testArray.length);
                endTime = System.nanoTime();
                timeTaken = (endTime - startTime);
                //System.out.println("Operations Done: " + steps);
                //System.out.println("Time taken in ns: " + timeTaken);

                //System.out.println("After: " + Arrays.toString(testArray) + "\n");
                if (removeFirst > testLength-2) {
                    if (!ihatethevm && removeFirst != 8008132){
                        ihatethevm = true;
                        n = 0;
                        removeFirst = 8008132;
                    }
                    timeAvgMer[n] += timeTaken;
                    if (timeTaken > longestTime){
                        longestTime = timeTaken;
                    }
                }
            }
            if (removeFirst > testLength-2) {
                timeAvgMer[n] = timeAvgMer[n] / loopLength;
            }
            else{
                removeFirst++;
            }
            if (ihatethevm){
                n = -1;  // properly reset
                ihatethevm = false;
            }
        }




//----------------------------------------------------------------------------------

        removeFirst = 0;
        longestTime = 0;

        for(int n = 0; n < testLength; n++){
            for(int loop = 1; loop<=loopLength; loop++){
                //System.out.println("Length: " + n);
                steps = 0;
                timeTaken = 0;
                testArray = genArray(sortArray, n).clone();
                long endTime;
                long startTime = System.nanoTime();
                selection_sort(testArray, testArray.length);
                endTime = System.nanoTime();
                timeTaken = (endTime - startTime);

                //System.out.println("Select time: " + timeTaken);
                //System.out.println("Operations Done: " + steps);
                //System.out.println("Time taken in ns: " + timeTaken);

                //System.out.println("After: " + Arrays.toString(testArray) + "\n");
                if (removeFirst > 10) {
                    if (!ihatethevm && removeFirst != 8008132){
                        n = 0;
                        ihatethevm = true;
                        removeFirst = 8008132;
                    }
                    timeAvgSel[n] += timeTaken;
                    if (timeTaken > longestTime){
                        longestTime = timeTaken;
                    }
                }
            }
            //System.out.println("Longest: at " + (n) + " - " + longestTime);
            if (removeFirst > 10) { // make sure not to average 0s
                timeAvgSel[n] = timeAvgSel[n] / loopLength;
            }
            else{
                removeFirst++; //redo length n
            }
            if (ihatethevm){
                n = -1; // properly reset
                ihatethevm = false;
            }
        }
        //System.out.println("FullAvg: " + Arrays.toString(timeAvgSel) + "\n");

        writeDataLineByLine("C://Users/lieze/Documents/217/208 ass/src/testOutput.csv", timeAvgSel, timeAvgMer);
    }
}

