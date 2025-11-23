# Unoptimized with time-complexity of O(n^3)

# Given an integer array nums, return all the triplets [nums[i], nums[j], nums[k]] such that i != j, i != k, and j != k, and nums[i] + nums[j] + nums[k] == 0.

# Notice that the solution set must not contain duplicate triplets.

 

# Example 1:

# Input: nums = [-1,0,1,2,-1,-4]
# Output: [[-1,-1,2],[-1,0,1]]
# Explanation: 
# nums[0] + nums[1] + nums[2] = (-1) + 0 + 1 = 0.
# nums[1] + nums[2] + nums[4] = 0 + 1 + (-1) = 0.
# nums[0] + nums[3] + nums[4] = (-1) + 2 + (-1) = 0.
# The distinct triplets are [-1,0,1] and [-1,-1,2].
# Notice that the order of the output and the order of the triplets does not matter.
# Example 2:

# Input: nums = [0,1,1]
# Output: []
# Explanation: The only possible triplet does not sum up to 0.
# Example 3:

# Input: nums = [0,0,0]
# Output: [[0,0,0]]
# Explanation: The only possible triplet sums up to 0.
 

# Constraints:

# 3 <= nums.length <= 3000
# -105 <= nums[i] <= 105

def three_sum_v1(nums)
  len = nums.size
  arr = []
  h = Hash.new(0)
  0.upto(len - 3) do |i|
    (i + 1).upto(len - 2) do |j|
      (j + 1).upto(len - 1) do |k|
        a = [nums[i], nums[j], nums[k]]
        if a.sum.zero?
          sorted = a.sort
          next if h.key?(sorted)
          arr << a
          h[sorted] += 1 
        end
      end
    end
  end
  arr
end


# In the optimized approach, we can have 
def three_sum_v2(nums)
  h = Hash.new(0)
  h2 = Hash.new(0)
  nums.each {|n| h2[n] += 1}
  set = nums.to_set
  len = nums.size
  arr = []
  0.upto(len - 2) do |i|
    (i + 1).upto(len - 1) do |j|
      sub_arr = [nums[i], nums[j]]
      comp = 0 - sub_arr.sum
      next if sub_arr.include?(comp) && h2[comp] <= sub_arr.count(comp)
      a = [nums[i], nums[j], comp].sort!
      next if !set.include?(comp) || h.key?(a)
      arr << a
      h[a] += 1
    end
  end
  arr
end

# This is the best approach: Two pointers approach
# Beats 81 per cent, time: 487 ms
# We will sort the array in order for the left and right pointer to work
# Outer loop starts here
# We will start one one loop starting from 0 upto nums.size - 3
# since we are considering three numbers to be added, hence, we will keep the loop upto two number before the last numbers
# Inside the loop, we will first check if i > 0 and nums[i] == nums[i-1](This means we have a duplicate)
# In this case we will go to the next iteration else move to the next line
# We assign left = i + 1 and right = nums.size - 1
# We will initiate a target variable and assign it a value target = -(nums[left] + nums[right])

# Inner loop starts here:
# While left < right, we will proceed as follows
# if target == nums[i], we will push this combination into an array
# arr << [nums[left], nums[right], target]
# Increment left by 1. Also, if, after increment, nums[left] == nums[left - 1], increment it again
# Decrement right by 1. Also, check if current nums[right] == nums[right + 1], decrement it again
# This is done in order get another combination of left, right and target.
# If we keep any of the left or right unchanged,
# it is not possible to find another combination which sums upto 0 if we don't change both the positions
# If target < nums[left] + nums[right], we will need to decrement the value which can be done by right = right - 1
# Else left = left + 1
def three_sum(nums)
  nums.sort!
  nsize = nums.size
  arr = []
  (0...nsize - 2).each do |i|
    next if i > 0 && nums[i] == nums[i - 1]
    # Why did we start left from i + 1
    # Because, first element is already tracked using 'i', so we are considering left from one element next to it.
    left = i + 1
    right = nsize - 1
    target = -nums[i]
    while left < right
      sum = nums[left] + nums[right]
      if sum == target
        arr << [nums[i], nums[left], nums[right]]
        left += 1

        # Pay attention to the while keyword
        # It will keep skipping the left element and move the pointer to the next one until it finds a different element
        left += 1 while left < right && nums[left] == nums[left-1]

        right -= 1
        right -= 1 while left < right && nums[right] == nums[right + 1]
      elsif sum < target
        left += 1
      else
        right -= 1
      end
    end
  end
  arr
end

nums = [-100,-70,-60,110,120,130,160]
three_sum(nums)
nums = [-1,0,1,0]
three_sum(nums)

puts three_sum([-1,0,1,2,-1,-4]).inspect  # [[-1,-1,2],[-1,0,1]]
puts three_sum([0,1,1]).inspect            # []
puts three_sum([0,0,0]).inspect            # [[0,0,0]]
puts three_sum([0,0,0,0]).inspect          # [[0,0,0]]