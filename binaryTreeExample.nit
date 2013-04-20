module binaryTreeExample

import tree
	#var rootNode:BinaryNode[Int] = new  BinaryNode[Int](8888)
	var binaryTree:BinaryTree[Int] = new BinaryTree[Int].withValue(863)
	binaryTree.rootNode.addLeft(1)
	binaryTree.rootNode.addRight(2)
	binaryTree.rootNode.leftChild.addLeft(3)
	binaryTree.rootNode.leftChild.addRight(4)
	binaryTree.rootNode.rightChild.addLeft(5)
	binaryTree.rootNode.rightChild.addRight(6)
	var element = binaryTree.rootNode.rightChild
	var element2 = binaryTree.rootNode.leftChild

	element.leftChild.addLeft(7)
	element.leftChild.addRight(8)
	print "Printing the depth of a child Node, should be 1"
	print element.depth

	print "Testing the BfsLeft Iterator"
	var iterator = binaryTree.bfsLeftIterator
	while iterator.is_ok
	do
		print iterator.item.element
		iterator.next
	end
	print "Testing the Bfs Right Iterator"
	var iteratorBfsRight = binaryTree.bfsRightIterator
	while iteratorBfsRight.is_ok
	do
		print iteratorBfsRight.item.element
		iteratorBfsRight.next
	end
	print "Testing the DFS Left Iterator"
	var iteratorDfsLeft = binaryTree.dfsLeftIterator
	while iteratorDfsLeft.is_ok
	do
		print iteratorDfsLeft.item.element
		iteratorDfsLeft.next
	end
	print "Testing the  DFS Right Iterator"
	var iteratorDfsRight = binaryTree.dfsRightIterator
	while iteratorDfsRight.is_ok
	do
		print iteratorDfsRight.item.element
		iteratorDfsRight.next
	end
	print "Testing the BinarySearchTree"


	var bstInsertTime = get_time
	var binarySearchT = new BinarySearchTree[Int].withImplicitRoot(20)
	#print "Values inserted : 20, 2, 5, 6,7,8,9,14,25,85, 98,42,53,52,156,975,853,352,9878"
	binarySearchT.insert(2)
	binarySearchT.insert(5)
	var listToInsert = new List[Int].from([999,988,867,799,900,690,500,790,400,300,200,111,7544,2553,5266,3456,3464])
	var vals = 0
	var vals2 = 9000
	#while vals < 1000
	#do
	#	listToInsert.add(vals.rand)
	#	vals += 1
	#	while vals2 > 8000
	#	do
	#		listToInsert.add(vals2.rand)
	#		vals2 = vals2 - 1
	#	end
	#	vals2 = 9000
	#end

	for a in listToInsert do
		binarySearchT.insert(a)

	end
	print "insert finished"
	bstInsertTime = get_time - bstInsertTime
	print "Bst Insert Time was :"
	print bstInsertTime.to_s  

	var bstSortTime = get_time
	var listSorted = new List[Int]

	var iterator2 = binarySearchT.iterator
	print "iterator created"
	while iterator2.is_ok
	do
		
		#listSorted.add(iterator2.item.key)
		print iterator2.item.key
		iterator2.next
	end

	bstSortTime = get_time - bstSortTime
	print "bst Sort Time was : "
	print bstSortTime

	var compSorter = new ComparableSorter[Int]
	var array = listToInsert.to_a
	var arraySortTime = get_time
	compSorter.sort(array)
	arraySortTime = get_time - arraySortTime
	print "array sorting was : "
	print arraySortTime


	# region Test RedBlack Tree
	var  redBlackTree = new RBTree[Int, String].withImplicitRoot(10, "RootNode")
	redBlackTree.insert(40, "Random Value")
	redBlackTree.insert(20, "Random Value2")
	redBlackTree.insert(30, "Random Value3")
	redBlackTree.insert(560, "Random Value4")
	redBlackTree.insert(2, "Random Value5")
	redBlackTree.insert(34, "Random Value6")
	redBlackTree.insert(533, "Random Value7")
	redBlackTree.insert(245, "Random Value8")

	print redBlackTree.findKeyNode(20).value
	print redBlackTree.delete(2).as(not null)
	print "creating iterator"
	var iterator3 =  redBlackTree.iterator
	print "iterator created"
	var stuffToPrint = " hello"
	while iterator3.is_ok
	do
			
		stuffToPrint = iterator3.item.value.to_s + " " + iterator3.item.key.to_s
		print stuffToPrint
		iterator3.next	
		
	end
	print "ended printing the iterator items"


