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


	var bstInsertTime = get_time
	var binarySearchT = new BinarySearchTree[Int].withImplicitRoot(20)
	#print "Values inserted : 20, 2, 5, 6,7,8,9,14,25,85, 98,42,53,52,156,975,853,352,9878"
	binarySearchT.insert(2)
	binarySearchT.insert(5)
	var listToInsert = new List[Int].from([999,988,867,799,900,690,500,790,400,300,200,111,7544,2553,5266,3456,3464])
	var vals = 0
	var vals2 = 9000
	while vals < 1000
	do
		listToInsert.add(vals.rand)
		vals += 1
		while vals2 > 8000
		do
			listToInsert.add(vals2.rand)
			vals2 = vals2 - 1
		end
		vals2 = 9000
	end



	for a in listToInsert do
		binarySearchT.insert(a)

	end
	print "insert finished"
	bstInsertTime = get_time - bstInsertTime
	print "Bst Insert Time was :"
	print bstInsertTime.to_s  



	var bstSortTime = get_time
	var listSorted = new List[Int]()

	var iterator2 = binarySearchT.iterator
	print "iterator created"
	while iterator2.is_ok
	do
		
		#listSorted.add(iterator2.item.key)
		#print iterator2.item.key
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

