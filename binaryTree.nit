module binaryTree

#Can have multiple children 
abstract class AbstractNode[E]
	private var _element:E

	#returns the element value
	fun element:E
	do
		return _element
	end

	#sets the element value
	fun element=(elem:E)
	do
		_element = elem
	end

	#initializes with an element[E]
	init(elem:E)do
		_element = elem
	end
end 


#Only has an AbstractNode[E]
abstract class AbstractTree[E]
	var rootNode:AbstractNode[E]
end

#Node that has 2 nullable Children and a nullable parent
class BinaryNode[E]
	super AbstractNode[E]
	
	private var _leftChild:nullable BinaryNode[E]
	private var _rightChild:nullable BinaryNode[E]
	private var _parent:nullable BinaryNode[E]

	private init(elem:E) do
		_element = elem
	end

	#Creates a new BinaryChildNode with a parent
	private init withParent(elem:E,parentNode:BinaryNode[E])
	do
		init(elem)
		_parent = parentNode
	end

	#creates the left and right node from the values E, and registers them as
	#children
	private init withChildren(elem:E,left:E, right:E, parentNode:nullable BinaryNode[E])
	do
		init(elem)
		addLeft(left)
		addRight(right)
		_parent = parentNode
	end

	#initializes with a left child and a parent
	# The parentSide arg is set to Self 
	private init withLeft(elem:E,left:nullable BinaryNode[E], parentNode:nullable BinaryNode[E])
	do
		init(elem)
		_leftChild = left
		_leftChild.parent = self
		_parent = parentNode
	end
	#Adds a new left child and registers the parent of the child to self
	fun addLeft(child:E)
	do
		_leftChild = new BinaryNode[E].withParent(child, self)
		_leftChild.parent = self
	end

	#Adds a right child and registers the parent of the child to Self
	fun addRight(child:E)
	do
		_rightChild = new BinaryNode[E].withParent(child, self)
		_leftChild.parent = self
	end
	
	#sets the leftChildNode and sets its parent to self
	private fun leftChild=(left:nullable BinaryNode[E])
	do
		_leftChild = left
		left.parent = self
	end
	
	#returns the left child node
	fun leftChild:nullable BinaryNode[E]
	do
		return _leftChild
	end
	
	#Sets the rightChild of this node
	#also sets the right child's parent to this node(self)
	private fun rightChild=(right:nullable BinaryNode[E])
	do
		_rightChild = right
		right.parent = self
	end

	#Returns the rightChild of this node
	fun rightChild:nullable BinaryNode[E]
	do
		return _rightChild
	end

	#Sets the parent value
	private fun parent=(parent:BinaryNode[E])
	do
		_parent = parent
	end

	#returns the parent of this child
	fun parent:nullable BinaryNode[E]
	do
		return _parent
	end
	
	#Returns the depth of the node. 
	#Root depth is 0
	fun depth:Int
	do
		var depth = 0#Root is 0 depth
		
		if depth == 0 and parent != null then return 1
		var par = parent

		while par != null
		do
			depth += 1
			par = par.parent
		end
		return depth
	end
end


#Contains multiple nodes, and starts with a root node
class BinaryTree[E]
	#super AbstractTree[E]
	var rootNode:BinaryNode[E]
	
	private init(root:BinaryNode[E])
	do
		rootNode = root
	end

	#Initializes a Tree with a new root constructed from the value
	init withValue(value:E)
	do
		rootNode = new BinaryNode[E](value)
	end

	#returns an iterator using a left depth First Search traverse method
	fun dfsLeftIterator:TreeIterator[BinaryNode[E],E]
	do
		return new TreeIteratorDfsLeft[BinaryNode[E],E](self)
	end

	#Returns an iterator using a right Depth First Search traverse method
	fun dfsRightIterator:TreeIterator[BinaryNode[E],E]
	do
		return new TreeIteratorDfsRight[BinaryNode[E],E](self)
	end

	#Returns an iterator using a Left breadth search traverse method
	fun bfsLeftIterator:TreeIterator[BinaryNode[E],E]
	do
		return new TreeIteratorBfsLeft[BinaryNode[E],E](self)
	end

	#Returns a new TreeIterator that uses a Right Breadth First Search to traverse the tree
	fun bfsRightIterator:TreeIterator[BinaryNode[E],E]
	do		
		return new TreeIteratorBfsRight[BinaryNode[E],E](self)
	end

	#Returns a new TreeIterator that can traverse the tree in a Post Order Fashion
	fun postOrderIterator:TreeIterator[BinaryNode[E],E]
	do
		return new TreeIteratorPostOrder[BinaryNode[E],E](self)
	end

	#Returns a new TreeIterator that can traverse the tree in a Pre Order Fashion
	fun preOrderIterator:TreeIterator[BinaryNode[E],E]
	do
		return new TreeIteratorPreOrder[BinaryNode[E],E](self)
	end

	#if true, walks to the right, else walks to the left
	private fun walkDfs(direction:Bool)
	do
		var nodesToWalk:List[nullable BinaryNode[E]] = new List[nullable BinaryNode[E]]
		if direction then #walk right
			if rootNode.leftChild != null then nodesToWalk.push(rootNode.leftChild)
			if rootNode.rightChild != null  then nodesToWalk.push(rootNode.rightChild)
		else #walks left
			if rootNode.rightChild != null then nodesToWalk.push(rootNode.rightChild)
			if rootNode.leftChild != null then nodesToWalk.push(rootNode.leftChild)
		end

		while nodesToWalk.length >0 
		do
			var currentNode = nodesToWalk.pop
			if direction then  #walk right
				if currentNode.leftChild != null then
					nodesToWalk.push(currentNode.leftChild)
				end
				if currentNode.rightChild != null then
					nodesToWalk.push(currentNode.rightChild)
				end
			else #walk left
				if currentNode.rightChild != null then
					nodesToWalk.push(currentNode.rightChild)
				end
				if currentNode.leftChild != null then
					nodesToWalk.push(currentNode.leftChild)
				end
			end
		end
	end

	private fun walkBfs(direction:Bool)
	do
		var nodes = new List[nullable BinaryNode[E]]
		
		if direction then #walk right
			if rootNode.leftChild !=  null then nodes.push(rootNode.leftChild)
			if rootNode.rightChild !=  null then nodes.push(rootNode.rightChild)
		else#walks left
			if rootNode.rightChild != null then nodes.push(rootNode.rightChild)
			if rootNode.leftChild != null then nodes.push(rootNode.leftChild)
		end

		while nodes.length > 0
		do
			var currentNode = nodes.shift
			if direction then #walk right
				if currentNode.leftChild !=  null then 
					nodes.push(currentNode.leftChild)
				end
				if currentNode.rightChild !=  null then 
					nodes.push(currentNode.rightChild)
				end
			else #walk left
				if currentNode.rightChild != null then 
					nodes.push(currentNode.rightChild)
				end
				if currentNode.leftChild != null then 
					nodes.push(currentNode.leftChild)
				end
			end
			
		end
	end

	#if true, then BFS, else DFS walk
	private fun walkWithList(direction:Bool, list:List[nullable BinaryNode[E]],bfs:Bool)
	do
		var node:nullable BinaryNode[E]
		node = rootNode.as(nullable BinaryNode[E])
		var tmpStack = new List[nullable BinaryNode[E]]
		loop
			if node != null then
				tmpStack.push(node)
				if direction then
					 node = node.rightChild
				else
					node = node.leftChild
				end
			else
				if tmpStack.length == 0 then return
				if bfs then
					node = tmpStack.shift
				else				
					node = tmpStack.pop
				end 
				list.push(node)
				if direction then
					node = node.leftChild
				else
					node = node.rightChild
				end
			end
		end
	end

	private fun walkPreOrder(list:List[nullable BinaryNode[E]])
	do
		var node:nullable BinaryNode[E]
		node = rootNode.as(nullable BinaryNode[E])
		var tmpStack = new List[nullable BinaryNode[E]]
		while tmpStack.length != 0 or node != null
		do
			if node != null then
				list.push(node)
				tmpStack.push(node.rightChild)
				node = node.leftChild
			else
				node = tmpStack.pop
			end
		end
	end

	private fun walkPostOrder(list: List[nullable BinaryNode[E]])
	do
		var node:nullable BinaryNode[E]
		node = rootNode.as(nullable BinaryNode[E])
		var tmpStack = new List[nullable BinaryNode[E]]
		var prevNode:nullable BinaryNode[E] = null
		tmpStack.push(node)
		var currNode:nullable BinaryNode[E]

		while tmpStack.length != 0
		do
			currNode = tmpStack.last
			if prevNode == null or prevNode.leftChild == currNode or prevNode.
			rightChild == currNode then
				if currNode.leftChild != null then
					tmpStack.push(currNode.leftChild)
				else if currNode.rightChild != null then
					tmpStack.push(currNode.rightChild)
				end
			else if currNode.leftChild == prevNode then
				if currNode.rightChild != null then tmpStack.push(currNode.rightChild)
			else			
				list.push(currNode)
				tmpStack.pop
			end
			prevNode = currNode
		end
	end
end


abstract class TreeIterator[E,T]
	super Iterator[E]
	
	private var sourceTree:BinaryTree[T]
	private var currentItem:nullable E
	private var nodes:List[nullable BinaryNode[T]] = new List[nullable BinaryNode[T]]
	private var i:Int = 1
	private var ok:Bool = false

	#Returns true if the currentItem is not null
	redef fun is_ok 
	do
		return ok
	end

	init
	do

	end

	#Returns the current item
	redef fun item  do return currentItem.as(not null)

	redef fun next
	do
		if i < nodes.length then
			currentItem = nodes[i]
			i += 1
		else
			ok = false
		end	
	end	
end

#An iterator that uses the Depth First Search Left method for traversal
class TreeIteratorDfsLeft[E,T]
	super TreeIterator[E,T]

	init(tree:BinaryTree[T])
	do
		sourceTree = tree
		tree.walkWithList(false,nodes.as(List[nullable BinaryNode[E]]),false)
		
		currentItem = nodes[0]
		if nodes[0] != null then ok = true
	end
end

#An iterator that uses the Depth First Search Right method for traversal
class TreeIteratorDfsRight[E,T]
	super TreeIterator[E,T]

	init(tree:BinaryTree[T])
	do	
		sourceTree = tree
		tree.walkWithList(true,nodes.as(List[nullable BinaryNode[E]]),false)
		
		currentItem = nodes[0]
		if nodes[0] != null then ok = true
	end
end


#An iterator that uses the Breadth First Search method for traversal
class TreeIteratorBfsLeft[E,T]
	super TreeIterator[E,T]

	init(tree:BinaryTree[T])
	do
		sourceTree = tree
		tree.walkWithList(false,nodes.as(List[nullable BinaryNode[E]]),true)
		
		currentItem = nodes[0]
		if nodes[0] != null then ok = true
	end
end

#An iterator that uses the Breadth First 
class TreeIteratorBfsRight[E,T]
	super TreeIterator[E,T]

	init(tree:BinaryTree[T])
	do
		sourceTree = tree
		tree.walkWithList(true,nodes.as(List[nullable BinaryNode[E]]),true)
		
		currentItem = nodes[0]
		if nodes[0] != null then ok = true
	end
end

class TreeIteratorPostOrder[E,T]
	super TreeIterator[E,T]

	init(tree:BinaryTree[T])
	do
		sourceTree = tree
		tree.walkPostOrder(nodes.as(List[nullable BinaryNode[E]]))

		currentItem = nodes[0]
		if nodes[0] != null then ok = true
	end
end

class TreeIteratorPreOrder[E,T]
	super TreeIterator[E,T]

	init(tree:BinaryTree[T])
	do
		sourceTree = tree
		tree.walkPreOrder(nodes.as(List[nullable BinaryNode[E]]))

		currentItem = nodes[0]
		if nodes[0] != null then ok = true
	end
end
