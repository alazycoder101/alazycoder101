=begin
1. MinAbsSum
Given array of integers, find the lowest absolute sum of elements.
Task description
For a given array A of N integers and a sequence S of N integers from the set {?1, 1}, we define val(A, S) as follows:

val(A, S) = |sum{ A[i]*S[i] for i = 0..N?1 }|

(Assume that the sum of zero elements equals zero.)

For a given array A, we are looking for such a sequence S that minimizes val(A,S).

Write a function:

class Solution { public int solution(int[] A); }

that, given an array A of N integers, computes the minimum value of val(A,S) from all possible values of val(A,S) for all possible sequences S of N integers from the set {?1, 1}.

For example, given array:

  A[0] =  1
  A[1] =  5
  A[2] =  2
  A[3] = -2
your function should return 0, since for S = [?1, 1, ?1, 1], val(A, S) = 0, which is the minimum possible value.

Assume that:

N is an integer within the range [0..20,000];
each element of array A is an integer within the range [?100..100].
Complexity:

expected worst-case time complexity is O(N*max(abs(A))2);
expected worst-case space complexity is O(N+sum(abs(A))), beyond input storage (not counting the storage required for input arguments).
Elements of input arrays can be modified.

=end
public class MinAbsSum {
def minAbsSum(a) {
  return 0 if a.length == 0
  sum = 0, int max = -1000
  # O(N)
  (0 .. a.length).each do |i|
    value = a[i].abs
    sum += value
    if (max < value)
      max = value;
    end
    a[i] = value
  end
  # O(max(abs(a))) space but no more than O(sum(abs(a))), so ignore it
  # O(N)
  counts = Array.new(max + 1, 0);
  a.each do |val|
    counts[val] += 1
  end
  # O(sum(abs(a)))
  r = Array.new(sum + 1, -1)
  # outer is O(max(abs(a)))
  # inner is O(sum(abs(a))) which is less than O(N * max(abs(a)))
  # we don't care of 0 values
  counts.each_with_index do |val, i|

    # we check r[j]. if it's not less than 0, then it means we've reached j value with previous steps, so no need to spend current
    # if it's less than 0, spend 1 current number if r[j - i] has been reached
    r.each_with_index do |v, j|
      # negative value means we haven't reached this value, so we have to spend 1 current if we can
      if (r[j] >= 0)
        r[j] = counts[i];
      elsif (j - i >= 0 && r[j - i] > 0)
        r[j] = r[j - i] - 1
      end
      # the value in r[j] then means how many of the current values are left when we reached the value j
    end
    result = sum
    # don't have to traverse all the arrays, since i - the sum of elements. if it's reachable then (sum - i) - reachable as well.
    # so if the value is reachable then the diff is abs(i - (sum - i)), which is the same as abs(sum - 2 * i)
    (0..r.length/2).each_with_index do |v, i|
      if (r[i] >= 0 && result > (sum - 2 * i).abs)
        result = (sum - 2 * i).abs
      end
    end
    result
  end
end
