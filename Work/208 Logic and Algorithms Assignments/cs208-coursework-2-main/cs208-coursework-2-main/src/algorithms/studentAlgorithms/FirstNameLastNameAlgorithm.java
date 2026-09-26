package algorithms.studentAlgorithms;

import algorithms.SchedulingAlgorithm;
import algorithms.RoundRobinAlgorithm;

import java.util.ArrayList;
import java.util.Arrays;

/**
 * Please rename this class to FirstNameLastNameAlgorithm
 */
public class FirstNameLastNameAlgorithm extends SchedulingAlgorithm {

    private String studentName = "Gordon Matthew";

    /**
     * Fill in this method for your submission. You have a maximum of 4.5 minutes of processing time.
     * If your submission exceeds this time, then your grade will be penalised.
     *
     * @param etcMatrix The Estimate To Compute Matrix (ETC Matrix) of the chosen file.
     * @return The total amount of time required for each processor
     */

    @Override
    public double[] runAlgorithm(double[][] etcMatrix) {
        double[] processorTimes = new double[etcMatrix.length];
        ArrayList<Integer> completedTasks = new ArrayList<>();
        int completeCount = 0;

        minmin mm = new minmin();
        processorTimes = mm.runAlgorithm(processorTimes, etcMatrix);

        //RoundRobinAlgorithm rr = new RoundRobinAlgorithm();
        //processorTimes = rr.runAlgorithm(etcMatrix);

        return processorTimes;
    }

    @Override
    public String getName() {
        return studentName;
    }
}
