package algorithms.studentAlgorithms;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Random;

public class localsearch {

    public boolean isLargestProcess(int processIndex, double[] processorTimes){
        double largest = 0.0;
        int largestIdx = 0;
        for(int p=0; p<processorTimes.length; p++){
            if(processorTimes[p] > largest){
                largestIdx = p;
                largest = processorTimes[p];
            }
        }

        return (largestIdx == processIndex);
    }

    public boolean isSmallestProcess(int processIndex, double[] processorTimes){
        double smallest = 0.0;
        int smallestIdx = 0;
        for(int p=0; p<processorTimes.length; p++){
            if(processorTimes[p] < smallest){
                smallestIdx = p;
                smallest = processorTimes[p];
            }
        }

        return (smallestIdx == processIndex);
    }

    public double[] runAlgorithm(double[] processorTimes, double[][] etcMatrix, ArrayList[] jobIdxs) {
//        int unassigned = 0;
//        ArrayList[] jobIdxs = new ArrayList[etcMatrix.length]; // 2d array list of all indexes of jobs done by each processor
//        Random rand = new Random();
//
//        for(int i=0; i<16; i++){
//            jobIdxs[i] = new ArrayList<Integer>(); //initialise full 2d array of ArrayLists
//        }
//
//        while(unassigned <= 511){ //assign each task to a random processor
//            int randProcessor = (int) (Math.random() * 16); // 16 upper bound exclusive
//            processorTimes[randProcessor] += etcMatrix[randProcessor][unassigned];
//            jobIdxs[randProcessor].add(unassigned);
//            unassigned++;
//        }

        for (int i=0; i<513; i++) { // loop for twice the total amount of jobs

            double max = 0.0;
            int maxIdx = 0;
            double min = Double.MAX_VALUE;
            int minIdx = 0;
            //find problem processor - highest total makespan
            //and find best processor - lowest total makespan
            for (int p = 0; p < processorTimes.length; p++) {
                if (processorTimes[p] > max) {
                    max = processorTimes[p];
                    maxIdx = p;
                }
            }
            for (int p = 0; p < processorTimes.length; p++) {
                if (processorTimes[p] < min) {
                    min = processorTimes[p];
                    minIdx = p;
                }
            }

            // find the longest job in list of problem processor's jobs
            max = 0.0;
            int maxJobIdx = 0;
            for (int t = 0; t < jobIdxs[maxIdx].size(); t++) {
                if (etcMatrix[maxIdx][(Integer) jobIdxs[maxIdx].get(t)] > max) { // get the time taken for the job and compare with max
                    max = etcMatrix[maxIdx][(Integer) jobIdxs[maxIdx].get(t)];
                    maxJobIdx = t;
                }
            }

            //System.out.println("Most Loaded: " + maxIdx + " - " + processorTimes[maxIdx] + "  Least Loaded: " + minIdx + " - " + processorTimes[minIdx] + "  Longest Job: " + jobIdxs[maxIdx].get(maxJobIdx) + " - " + etcMatrix[maxIdx][(Integer) jobIdxs[maxIdx].get(maxJobIdx)] + "  Added to Least Loaded: " + etcMatrix[minIdx][(Integer) jobIdxs[maxIdx].get(maxJobIdx)]);
            processorTimes[minIdx] += etcMatrix[minIdx][(Integer) jobIdxs[maxIdx].get(maxJobIdx)]; //swap jobs
            jobIdxs[minIdx].add(jobIdxs[maxIdx].get(maxJobIdx));
            processorTimes[maxIdx] -= etcMatrix[maxIdx][(Integer) jobIdxs[maxIdx].get(maxJobIdx)];
            jobIdxs[maxIdx].remove(jobIdxs[maxIdx].get(maxJobIdx));
        }

        int largest = 0;
        int smallest = 0;
        for(int p=0; p<processorTimes.length; p++){
            if(isLargestProcess(p, processorTimes)){largest = p;}
            else if(isSmallestProcess(p, processorTimes)){smallest = p;}
            //System.out.println("P" + p + " makespan: " + processorTimes[p]);
        }
        System.out.println("makespan range after LocalSearch = " + (processorTimes[largest] - processorTimes[smallest]));
        System.out.println("total makespan after LocalSearch = " + processorTimes[largest]);

        return processorTimes;
    }

}
