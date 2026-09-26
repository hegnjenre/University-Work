package algorithms.studentAlgorithms;

import java.util.ArrayList;
import java.util.Arrays;

public class minmin {
    private int completedCounter = 0;
    boolean check = false;

    public double[][] actuallyClone(double[][] matrix){
        double[][] clonedMatrix = new double[matrix.length][matrix[0].length];
        for(int p=0; p<matrix.length; p++){
            for(int t=0; t<matrix[0].length; t++){
                clonedMatrix[p][t] = matrix[p][t];
            }
        }
        return clonedMatrix;
    }

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

    public ArrayList<Integer> generateSmallestList(double[] processorTimes){
        ArrayList<Double> smallestList = new ArrayList<Double>();
        ArrayList<Integer> smallestIndexes = new ArrayList<Integer>();
        smallestIndexes.add(0);
        smallestList.add(processorTimes[0]);
        for(int p=0; p<processorTimes.length; p++){
            boolean replaced = false;
            int s=0;
            while(s<4 && !replaced){
                if(smallestList.get(s) > processorTimes[p]){
                    smallestIndexes.remove(s);
                    smallestIndexes.add(p);
                    smallestList.remove(s);
                    smallestList.add(processorTimes[p]);
                    replaced = true;
                }
                else if(smallestIndexes.size() < 4){
                    smallestIndexes.add(p);
                    smallestList.add(processorTimes[p]);
                }
                s++;
            }
        }

        return smallestIndexes;
    }

    public double[] runAlgorithm(double[] processorTimes, double[][] etcMatrix){
        double[][] etcClone = actuallyClone(etcMatrix);
        // I use the clone for adding process times and etcMatrix for actual calculations and updates
        // turns out Java's .clone() function clones the pointer to the list rather than the list itself
        // so any updates to the original also updates the clone, which is the opposite of what I wanted.
        // so many headaches over Java, when's the class where we make our own language so I can be free
        // from this coffee mug shaped prison

        int pIndex;
        int tIndex;
        double tMin;
        double[] minTimesT; // min times for every task
        int[] minTimesP; // parallel array with index for associated processors
        ArrayList<Integer> smallestList = new ArrayList<>();
        ArrayList[] jobIdxs = new ArrayList[etcMatrix.length]; // 2d array list of all indexes of jobs done by each processor

        for(int i=0; i<16; i++){
            jobIdxs[i] = new ArrayList<Integer>(); //initialise full 2d array of ArrayLists
        }

        while (completedCounter < 512) {
            tIndex = 0;
            pIndex = 0;
            minTimesT = new double[etcMatrix[0].length];
            minTimesP = new int[etcMatrix[0].length];
            smallestList = generateSmallestList(processorTimes);

            for (int t = 0; t < etcMatrix[0].length; t++) { // find min for every task
                tMin = Double.MAX_VALUE;
                for (int p = 0; p < etcMatrix.length; p++) { // find min time
                    if ((etcMatrix[p][t]) <= tMin && !isLargestProcess(p, processorTimes) && smallestList.contains(p)) {
                        // ^find minimum task          ^check if processor isn't overloaded    ^ check that process isn't underloaded
                        //                                                                     ^ doing this lowers makespan range significantly
                        tMin = etcMatrix[p][t];
                        minTimesT[t] = tMin;
                        minTimesP[t] = p;
                    }
                }
            }

            tMin = minTimesT[0];
            for (int t = 1; t < minTimesT.length; t++) {
                if (minTimesT[t] <= tMin) {
                    tMin = minTimesT[t];
                    tIndex = t;            // shortest task
                    pIndex = minTimesP[t]; // associated processor
                }
            }

            //System.out.println("P" + pIndex + " is doing task: " + tIndex + " for " + etcClone[pIndex][tIndex]);
            //if(completedCounter <= 1){System.out.println( "t: " + tIndex + "\nog: " + etcMatrix[pIndex][tIndex] + "\nclone: " + etcClone[pIndex][tIndex]);}
            processorTimes[pIndex] += etcClone[pIndex][tIndex];
            jobIdxs[pIndex].add(tIndex);
            completedCounter++;

            for (int p = 0; p < etcMatrix.length; p++) { // for every processor, invalidate the completed task
                etcMatrix[p][tIndex] = Double.MAX_VALUE;
            }
            for(int t=0; t<etcMatrix[0].length; t++){
                etcMatrix[pIndex][t] += tMin;
            }
        }
//        System.out.println("Completed " + completedCounter + " Tasks.");
//        double makespan = 0;
//        for (int p=0; p<processorTimes.length; p++) {
//            makespan = Math.max(makespan, processorTimes[p]);
//            pIndex = p;
//        }
//        System.out.println("Makespan culprit: " + pIndex + ": " + makespan);
        int largest = 0;
        int smallest = 0;
        for(int p=0; p<processorTimes.length; p++){
            if(isLargestProcess(p, processorTimes)){largest = p;}
            else if(isSmallestProcess(p, processorTimes)){smallest = p;}
            //System.out.println("P" + p + " makespan: " + processorTimes[p]);
        }
        System.out.println("makespan range before LocalSearch = " + (processorTimes[largest] - processorTimes[smallest]));
        System.out.println("total makespan before LocalSearch = " + processorTimes[largest]);

        localsearch ls = new localsearch();
        processorTimes = ls.runAlgorithm(processorTimes, etcClone, jobIdxs);
        processorTimes = ls.runAlgorithm(processorTimes, etcClone, jobIdxs);
        // using the unedited clone of etcMatrix in local search to improve makespan
        // after testing it looked as though using local search twice produces the optimal, or at least local optimal
        // any more than this and results flip-flop between the two answers

        return processorTimes;
    }
}
