#import('dart:builtin'); 
#import('dart:io');

class CountingInversionsClass {
  //Keep track of total inversions
  int count;
  String fileName;
  
  //Constructor function initializes arrays to be sorted/counted.
  CountingInversionsClass() {
    count = 0;
    //File from Design & Analysis of Algorithms I.  Contains 100,000 entries.
    fileName = "../IntegerArray.txt";
    File fileHandle = new File(fileName);
    //Read in list from a file.  Data is read in as strings.
    List<String> buffer = fileHandle.readAsLinesSync();
    //Create new buffer and parse number strings as integers.
    List<int> intBuffer = new List(buffer.length);
    for (var i = 0; i < buffer.length; i++) {
      intBuffer[i] = Math.parseInt(buffer[i]);
    }
    //Test arrays:  Maximum inversions is n choose 2 = n(n-1)/2.
    List<int> test1 = [1, 3, 5, 2, 4, 6];  //3 inversions
    List<int> test2 = [1, 2, 3, 4, 5, 6];  //0 inversions
    List<int> test3 = [6, 5, 4, 3, 2, 1];  //15 inversions
    //print(test3);
    //Call sort routine
    sort(intBuffer);
    print("List has $count inversions");  //2407905288 inversions
    //print(test3);
  }
  
  //Just calls recursive algorithm mergesort() and passes array and size.
  void sort(List<int> myArray) {
    mergesort(myArray, 0, myArray.length-1);
  }
  
  //Recursive calls through mergesort now also keeps track of # of inversions.
  void mergesort(List<int> inArray, int lo, int hi){
    if(hi <= lo) return;
    int mid = lo + ((hi - lo)/2).toInt();
    mergesort(inArray, lo, mid);
    mergesort(inArray, mid+1, hi);
    count += merge(inArray, lo, mid, hi);
  }
  
  //The hard part - the merge.  This algorithm comes from:
  //http://www.thealgorithmist.com/showthread.php/148-Number-of-Inversions
  int merge(List<int> array, int lo, int mid, int hi) {
    int counter = 0;
    List<int> tmpArray = new List<int>(hi-lo+1);
    int size = mid-lo+1;
    int i = lo;
    int j = mid+1;
    int k;
    //Compare "left" side with the "right" side and keep 
    //track of # of inversions using size variable.
    for(k = 0; i <= mid && j <= hi; k++){
      //"left" side smaller than "right" side - no inversion.
      if(array[i] <= array[j]) {
        tmpArray[k] = array[i++];
        size--;
      } else {
        //"left" side larger - inversion.
        tmpArray[k] = array[j++];
        counter += size;
      }
    }
    
    if (size > 0) {
      while (i <= mid) tmpArray[k++] = array[i++];
    } else {
      while (j <= hi) tmpArray[k++] = array[j++];
    }
    //Build the sorted array.
    k = 0;
    for (i = lo; i <= hi; i++) {
      array[i] = tmpArray[k];
      k++;
    }
    return counter;
  }
}

void main() {
  new CountingInversionsClass(); 
}
