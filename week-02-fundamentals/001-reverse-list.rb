# https://leetcode.com/problems/reverse-linked-list/

# Given the head of a singly linked list, reverse the list, and return the reversed list.

# Example 1:
# Input: head = [1,2,3,4,5]
# Output: [5,4,3,2,1]
# Constraints:

# The number of nodes in the list is the range [0, 5000].
# -5000 <= Node.val <= 5000
 

# Follow up: A linked list can be reversed either iteratively or recursively. Could you implement both?
# Definition for singly-linked list.
class ListNode
  attr_accessor :val, :next
  def initialize(val = 0, _next = nil)
    @val = val
    @next = _next
  end
end

# Convert the array: [1,2,3,4,5] to a linked list:
# 1 -> 2 -> 3 -> 4 -> 5
# @param {ListNode} head
# @return {ListNode}
# Iterative approach: Beats 100 per cent
# But this is NOT the correct approach as we are returning array object instead of a linked list
def reverse_list_v1(head)
  return [] if head.nil?
  n1 = head

  arr = [n1.val]
  while n1.next
    arr << n1.next.val
    n1 = n1.next
  end
  arr.reverse
end

head = ListNode.new(1, ListNode.new(2, ListNode.new(3, ListNode.new(4, ListNode.new(5)))))
pp reverse_list_v1(head)

# Recursive approach
# Beats 2.53 per cent
# This is also incorrect as it returns an array object
def reverse_list_v2(head, arr = [])
  return arr if head.nil?
  n1 = head

  if n1.next
    reverse_list_v2(n1.next, arr + [n1.val])
  else
    arr << n1.val
    arr.reverse
  end
end
puts "#############################"
pp reverse_list_v2(head, [])

# Iterative approach and it should return a LinkedList(ListNode) object
# Beats 100 per cent
def reverse_list_v3(head)
  return head if head.nil?
  n1 = head
  prev = ListNode.new(n1.val, nil)
  while n1.next
    n1 = n1.next
    prev = ListNode.new(n1.val, prev)
  end
  prev
end

puts "=============================="
pp reverse_list_v3(head).inspect

# Recursive approach
# This also beats 100 per cent
def reverse_list(head, prev = nil)
  return if head.nil?
  n1 = head
  prev = ListNode.new(n1.val, prev)
  if n1.next
    reverse_list(n1.next, prev)
  else
    prev
  end
end

puts "-----------------------------------------------"
pp reverse_list(head).inspect