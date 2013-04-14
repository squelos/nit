module binaryTreeExample

import graph
	var rootNode:BinaryRootNode[Int] = new  BinaryRootNode[Int].withElement(2)
	var binaryTree:BinaryTree[Int] = new BinaryTree[Int](rootNode)
	var firstChild:BinaryChildNode[Int] = new BinaryChildNode[Int].withParent(1, rootNode, rootNode.leftChild)
	rootNode.leftChild = firstChild
	var secondChild = new BinaryChildNode[Int].withParent(2, rootNode, rootNode.rightChild)
	rootNode.rightChild = secondChild

	var thirdChild = new BinaryChildNode[Int].withParent(3, firstChild, firstChild.leftChild)
	firstChild.leftChild = thirdChild
	var fourthChild = new BinaryChildNode[Int].withParent(4, firstChild, firstChild.rightChild)
	firstChild.rightChild = fourthChild
	var fithChild = new BinaryChildNode[Int].withParent(5, secondChild, secondChild.leftChild)
	secondChild.leftChild = fithChild
	var sixthChild = new BinaryChildNode[Int].withParent(6, secondChild, secondChild.rightChild)
	secondChild.rightChild = sixthChild
	binaryTree.walkDfsLeftt


