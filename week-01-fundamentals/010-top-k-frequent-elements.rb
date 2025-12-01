# https://leetcode.com/problems/top-k-frequent-elements/
# Given an integer array nums and an integer k, return the k most frequent elements. You may return the answer in any order.

# Example 1:

# Code
# Input: nums = [1,1,1,2,2,3], k = 2
# Output: [1,2]
# Explanation: 1 appears 3 times, 2 appears 2 times, 3 appears 1 time
#              So the top 2 frequent elements are [1, 2]

# Example 2:

# Code
# Input: nums = [1], k = 1
# Output: [1]
# Example 3:

# Code
# Input: nums = [4,1,-1,2,-1,2,3], k = 2
# Output: [-1,2]
# Explanation: -1 appears 2 times, 2 appears 2 times (tie, both in top 2)
#              1 appears 1 time, 4 appears 1 time, 3 appears 1 time

def top_k_frequent_v1(nums, k)
  h = Hash.new(0)

  for num in nums
    h[num] += 1
  end
  most_freq = []
  1.upto(k) do |i|
    max_value = h.values.max
    max_key = h.select {|k, v| v == max_value}.keys.first
    most_freq << max_key
    h.delete(max_key)
  end
  most_freq
end

# Beats 68.98 per cent
def top_k_frequent_v2(nums, k)
  h = Hash.new(0)
  nums.each { |num| h[num] += 1 }
  h.sort_by { |k, v| -v }
   .first(k)
   .map { |k, _v| k }
end

# Truly optimal
# BUCKET SORT
# Need to redo to be more fluent
def top_k_frequent(nums, k)
  freq = nums.tally
  buckets = Array.new(nums.size + 1) { [] }
  freq.each { |num, count| buckets[count] << num }
  
  result = []
  buckets.reverse_each do |bucket|
    result.concat(bucket)
    break if result.size >= k
  end
  result.first(k)
end