module binaryTreeExample

import graph
#We are going to consume the 
#graph module (included in the Std)
class Client
	var rootNode:BinaryRootNode[Int] = new  BinaryRootNode[Int].withElement(2)
	var binaryTree:BinaryTree[Int] = new BinaryTree[Int](rootNode)
	var firstChild:BinaryChildNode[Int] = new BinaryChildNode[Int].withParent(22, rootNode, rootNode.leftChild)

end
