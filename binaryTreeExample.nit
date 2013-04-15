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
	#rootNode.rightChild.leftChild.addLeft(9)
	#rootNode.rightChild.rightChild.addRight(10)
	#var secondChild = new BinaryChildNode[Int].withParent(2, rootNode, rootNode.rightChild)
	#rootNode.rightChild = secondChild

	#var thirdChild = new BinaryChildNode[Int].withParent(3, firstChild, firstChild.leftChild)
	#firstChild.leftChild = thirdChild
	#var fourthChild = new BinaryChildNode[Int].withParent(4, firstChild, firstChild.rightChild)
	#firstChild.rightChild = fourthChild
	#var fithChild = new BinaryChildNode[Int].withParent(5, secondChild, secondChild.leftChild)
	#secondChild.leftChild = fithChild
	#var sixthChild = new BinaryChildNode[Int].withParent(6, secondChild, secondChild.rightChild)
	#secondChild.rightChild = sixthChild
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


