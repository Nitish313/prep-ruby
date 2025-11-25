# https://leetcode.com/problems/group-anagrams/ 
# Given an array of strings strs, group the anagrams together. You can return the answer in any order.
# Example 1:
# Input: strs = ["eat","tea","tan","ate","nat","bat"]
# Output: [["bat"],["nat","tan"],["ate","eat","tea"]]
# Explanation:

# There is no string in strs that can be rearranged to form "bat".
# The strings "nat" and "tan" are anagrams as they can be rearranged to form each other.
# The strings "ate", "eat", and "tea" are anagrams as they can be rearranged to form each other.

# Example 2:
# Input: strs = [""]
# Output: [[""]]

# Example 3:
# Input: strs = ["a"]
# Output: [["a"]]

# Constraints:

# 1 <= strs.length <= 104
# 0 <= strs[i].length <= 100
# strs[i] consists of lowercase English letters.

def group_anagrams_v1(strs)
  h = {}
  for str in strs
    if h.keys.empty?
      h[str] = [str]
    else
      matched_key = h.keys.select {|k| k == str || k.split('').sort == str.split('').sort }.first
      matched_key.any? ? h[matched_key] << str : h[str] = [str]
    end
  end
  h.values
end

# Optimized approach
def group_anagrams(strs)
  h = Hash.new { |hash, key| hash[key] = [] }
  
  strs.each do |str|
    # Sort the string to create a "signature"
    sorted = str.chars.sort.join
    
    # Use the signature as the hash key
    h[sorted] << str
  end
  
  h.values
end

puts group_anagrams(["eat","tea","tan","ate","nat","bat"]).inspect
# Should output groups like: [["eat","tea","ate"], ["tan","nat"], ["bat"]]

puts group_anagrams([""]).inspect
# Should output: [[""]]

puts group_anagrams(["a"]).inspect
# Should output: [["a"]]