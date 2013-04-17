module binaryTreeExample

import graph
	var rootNode:BinaryRootNode[Int] = new  BinaryRootNode[Int].withElement(8888)
	var binaryTree:BinaryTree[Int] = new BinaryTree[Int](rootNode)
	rootNode.addLeft(1)
	rootNode.addRight(2)
	rootNode.leftChild.addLeft(3)
	rootNode.leftChild.addRight(4)
	rootNode.rightChild.addLeft(5)
	rootNode.rightChild.addRight(6)
	var element = rootNode.rightChild
	var element2 = rootNode.leftChild

	element.leftChild.addLeft(7)
	element.leftChild.addRight(8)
	print "Printing the depth of a child Node, should be 1"
	print element.depth
	print "walking DFS left"
	binaryTree.walkDfsLeft
	print "Walking Dfs Right"
	binaryTree.walkDfsRight
	print "walking BFS Left"
	binaryTree.walkBfsLeft
	print "walking BFS right"
	binaryTree.walkBfsRight

	print "Testing the Iterator"

	var iterator = binaryTree.bfsLeftIterator
	while iterator.is_ok
	do
		print iterator.item.element
		iterator.next
	end

	print "Testing the BinarySearchTree"


	var binarySearchT = new BinarySearchTree[Int].withImplicitRoot(20)
	print "Values inserted : 20, 2, 5, 6,7,8,9,14,25,85, 98,42,53,52,156,975,853,352,9878"
	binarySearchT.insert(2)
	binarySearchT.insert(5)
	var listToInsert = [999,988,867,799,900,690,500,790,400,300,200,111]
	for a in listToInsert do
		print binarySearchT.insert(a)

	end
	print "insert finished"

	var iterator2 = binarySearchT.iterator
	print "iterator created"
	while iterator2.is_ok
	do
		print iterator2.item.key
		iterator2.next
	end

