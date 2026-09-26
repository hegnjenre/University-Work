import static java.util.Arrays.*;

import java.util.Arrays;
import java.util.Random;

public class Sortings {

    public static int[] sortArray;
    public static long timeTaken;
    public static int steps;
    private static Random rand = new Random();

    public static int[] genArray(int[] array, int len) {
        array = new int[len];
        for (int i = 0; i < len; i++) {
            array[i] = rand.nextInt(250);
        }
        return array;
    }

    //O(n^2): we must find the lowest level n times to sort the whole list,
    // and the average comparisons needed to find the lowest value is n/2
    //  O(n/2 * n) = O(n^2)
    public static void selection_sort(int[] list, int n) {
        if (n < 2) {return;}
        // too small to be sorted
        for (int o = 0; o < n; o++) {
            //steps++; // find smallest
            int smallest = list[o];
            int idx = o;
            int temp;
            for (int i = (o + 1); i < (n); i++) {
                //steps++; // pairwise comparison operation
                if (smallest > list[i]) {
                    //steps++;
                    smallest = list[i];
                    idx = i;
                }
            }
            //steps++; // assign to sorted area
            temp = list[o];
            list[o] = smallest;
            list[idx] = temp;
        }
    }

    public static int[] splitList(int[] array, int lower, int upper){
        // lower inclusive
        // upper exclusive
        int newArrLength;

        //steps++; // split
        if(upper-lower <= 0){newArrLength = 1;}
        else {newArrLength=upper - lower;}

        int[] splitArray = new int[newArrLength];
        int newIDX = 0;

        for(int oldIDX=lower; oldIDX<upper; oldIDX++){
            splitArray[newIDX] = array[oldIDX];
            newIDX++;
        }
        return splitArray;
    }

    //O(nlogn): n is the number of comparisons, logn is the number of layers of recursion
    // O(n * logn)
    public static void merge_sort(int[] list, int n) {
        if (n < 2) {return;} // comparison

        int split = n/2;
        int[] left = splitList(list, 0, split);
        int[] right = splitList(list, split, list.length);

        //steps++; // recurse
        merge_sort(left, split);
        merge_sort(right, n - split);
        merge(list, left, right, split, n - split);
    }

    public static void merge(int[] list, int[] listL, int[] listR, int left, int right) {

        //steps++; // comparison for merge
        int i = 0, j = 0, k = 0;
        while (i < left && j < right) { // add to new list while both left and right have elements
            if (listL[i] <= listR[j]) {
                list[k+1] = listL[i+1];
                i++;
                k++;
            }
            else {
                list[k+1] = listR[j+1];
                j++;
                k++;
            }

        }

        while (i < left) { // continue to add from left list and right is depleted
            list[k+1] = listL[i+1];
            i++;
            k++;
        }
        while (j < right) { // continue to add from right list once left is depleted
            list[k+1] = listR[j+1];
            j++;
            k++;
        }
    }

//    public static int[] merge_sort(int[] list) {
//        int splitIDX = list.length / 2;
//        //int[] leftList = copyOfRange(list, 0, splitIDX);  //built-in splitting is slower than mine
//        //int[] rightList = copyOfRange(list, splitIDX, list.length);
//        int[] leftList = splitList(list, 0, splitIDX);
//        int[] rightList = splitList(list, splitIDX, list.length);
//
//        //steps++;
//        if (list.length > 2) {         // still bigger than 1, if equal to zero then pass
//            leftList = merge_sort(leftList);
//            rightList = merge_sort(rightList);
//        } else if (list.length == 1 || list.length == 0) {
//            return list;
//        }
//
//        list = merge(leftList, rightList);
//        //System.out.println("Merge timeIn: " + timeTaken);
//        return list;
//    }
//
//    public static int[] merge(int[] lArr, int[] rArr) {
//        int[] mergedArr = new int[lArr.length + rArr.length];
//
//        //steps++;
//        if ((lArr.length + rArr.length) == 2) { // if only two items
//            if (lArr[0] > rArr[0]) {       // swap once
//                mergedArr[0] = rArr[0];
//                mergedArr[1] = lArr[0];
//            } else if (lArr[0] < rArr[0]) { // already sorted
//                mergedArr[0] = lArr[0];
//                mergedArr[1] = rArr[0];
//            }
//            return mergedArr;
//        }
//
//        int il = 0; // old array indexes
//        int ir = 0;
//        int x = 0; // new array index
//
//        while (il < lArr.length && ir < rArr.length) {
//            //steps++;
//            if (lArr[il] >= rArr[ir]) {
//                mergedArr[x] = rArr[ir];
//                x++;
//                ir++;
//            } else if (lArr[il] < rArr[ir]) {
//                mergedArr[x] = lArr[il];
//                x++;
//                il++;
//            }
//        }
//        //steps++;
//        if (il != lArr.length) {
//            for (int i = 0 + il; i < lArr.length; i++) {
//                mergedArr[x] = lArr[i];
//                x++;
//            }
//        } else if (ir != rArr.length) {
//            for (int i = 0 + ir; i < rArr.length; i++) {
//                mergedArr[x] = rArr[i];
//                x++;
//            }
//        }
//        return mergedArr;
//    }
}