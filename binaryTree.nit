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

#Node that has 2 nullable Children
abstract class BinaryNode[E]
	super AbstractNode[E]
	
	private var _leftChild:nullable BinaryChildNode[E]
	private var _rightChild:nullable BinaryChildNode[E]

	private init(elem:E) do
		_element = elem
	end

	
	#Adds a new left child and registers the parent of the child to self
	fun addLeft(child:E)
	do
		_leftChild = new BinaryChildNode[E].withParent(child, self)
		_leftChild.parent = self
	end

	#Adds a right child and registers the parent of the child to Self
	fun addRight(child:E)
	do
		_rightChild = new BinaryChildNode[E].withParent(child, self)
		_leftChild.parent = self
	end
	
	#sets the leftChildNode and sets its parent to self
	private fun leftChild=(left:nullable BinaryChildNode[E])
	do
		_leftChild = left
		left.parent = self
	end
	
	#returns the left child node
	fun leftChild:nullable BinaryChildNode[E]
	do
		return _leftChild
	end
	
	#Sets the rightChild of this node
	#also sets the right child's parent to this node(self)
	private fun rightChild=(right:nullable BinaryChildNode[E])
	do
		_rightChild = right
		right.parent = self
	end

	#Returns the rightChild of this node
	fun rightChild:nullable BinaryChildNode[E]
	do
		return _rightChild
	end
end


#Class for the Child Nodes. This one has 2 children (left and right) and a Parent(BinaryNode[E])
class BinaryChildNode[E]
	super BinaryNode[E]
	var _parent:BinaryNode[E]

	#Creates a new BinaryChildNode with a parent
	private init withParent(elem:E,parentNode:BinaryNode[E])
	do
		init(elem)
		_parent = parentNode
	end

	#creates the left and right node from the values E, and registers them as
	#children
	private init withChildren(elem:E,left:E, right:E, parentNode:BinaryNode[E])
	do
		init(elem)
		addLeft(left)
		addRight(right)
		_parent = parentNode
		
	end

	#initializes with a left child and a parent
	# The parentSide arg is set to Self 
	private init withLeft(elem:E,left:nullable BinaryChildNode[E], parentNode:BinaryNode[E])
	do
		init(elem)
		_leftChild = left
		_leftChild.parent = self
		_parent = parentNode
	end


	private fun parent=(parent:BinaryNode[E])
	do
		_parent = parent
	end

	#returns the parent of this child
	fun parent:BinaryNode[E]
	do
		return _parent
	end
	
	#Returns the depth of the node. 
	#Root depth is 0
	fun depth:Int
	do
		var depth = 0#Root is 0 depth
		
		if depth == 0 and parent isa BinaryRootNode[E] then return 1
		var par = parent.as(BinaryChildNode[E])

		while par isa BinaryChildNode[E]
		do
			depth += 1
			if par.parent isa BinaryChildNode[E] then 
				par = par.parent.as(BinaryChildNode[E])
			end
			
		end
		return depth
	end
end

#has no parent but has 2 children
class BinaryRootNode[E]
	super BinaryNode[E]

	init withElement(elem:E)
	do
		init(elem)
	end
	
end

#Contains multiple nodes, and starts with a root node
class BinaryTree[E]
	#super AbstractTree[E]
	var rootNode:BinaryRootNode[E]
	
	
	private init(root:BinaryRootNode[E])
	do
		rootNode = root
	end

	#Initializes a Tree with a new root constructed from the value
	init withValue(value:E)
	do
		rootNode = new BinaryRootNode[E].withElement(value)
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

	#if true, walks to the right, else walks to the left
	private fun walkDfs(direction:Bool)
	do
		var nodesToWalk:List[nullable BinaryChildNode[E]] = new List[nullable BinaryChildNode[E]]
		if direction then #walk right
			if rootNode.leftChild != null then nodesToWalk.push(rootNode.leftChild)
			if rootNode.rightChild != null  then nodesToWalk.push(rootNode.rightChild)
		else #walks left
			if rootNode.rightChild != null then nodesToWalk.push(rootNode.rightChild)
			if rootNode.leftChild != null then nodesToWalk.push(rootNode.leftChild)
		end
		rootNode.element.output
		#print rootNode.element 
		

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
			print currentNode.element
		end

	end


	private fun walkBfs(direction:Bool)
	do
		var nodes = new List[nullable BinaryChildNode[E]]
		if direction then #walk right
			if rootNode.leftChild !=  null then nodes.push(rootNode.leftChild)
			if rootNode.rightChild !=  null then nodes.push(rootNode.rightChild)
		else#walks left
			if rootNode.rightChild != null then nodes.push(rootNode.rightChild)
			if rootNode.leftChild != null then nodes.push(rootNode.leftChild)
		end

		print rootNode.element

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
			print currentNode.element
		end
	end

	#if true, then BFS, else DFS walk
	private fun walkWithList(direction:Bool, list:List[nullable BinaryNode[E]],bfs:Bool):nullable BinaryNode[E]
	do
		
		var currentNode:nullable BinaryNode[E]
		if list.length > 0 then
		
			if bfs then
				currentNode = list.shift
			else
				currentNode = list.pop
			end
			if direction then #walk right
				if currentNode.leftChild !=  null then 
					list.push(currentNode.leftChild)
				end
				if currentNode.rightChild !=  null then 
					list.push(currentNode.rightChild)
				end
			else #walk left
				if currentNode.rightChild != null then 
					list.push(currentNode.rightChild)
				end
				if currentNode.leftChild != null then 
					list.push(currentNode.leftChild)
				end
			end
			#print currentNode.element
		else
			currentNode = null
		end
		
		return currentNode
	end
end

abstract class TreeIterator[E,T]
	super Iterator[E]
	
	private var sourceTree:BinaryTree[T]
	private var currentItem:E
	private var nodes:List[nullable BinaryNode[T]] = new List[nullable BinaryNode[T]]

	#Returns true if the currentItem is not null
	redef fun is_ok 
	do
		if currentItem != null then
			return true
		else
			return false
		end
	end

	#Returns the current item
	redef fun item  do return currentItem

	redef fun next
	do
		#we advance the cursor		
	end

	init(tree:BinaryTree[T])
	do
		sourceTree = tree
		currentItem = tree.rootNode
		nodes.add(sourceTree.rootNode)
	end
end

#An iterator that uses the Depth First Search Left method for traversal
class TreeIteratorDfsLeft[E,T]
	super TreeIterator[E,T]

	#advances the cursor to the next node
	redef fun next
	do
		currentItem = sourceTree.walkWithList(false,nodes,false).as(E)
		#we call the walking method and
	end
end

#An iterator that uses the Depth First Search Right method for traversal
class TreeIteratorDfsRight[E,T]
	super TreeIterator[E,T]

	#advances the cursor to the next node
	redef fun next
	do
		currentItem = sourceTree.walkWithList(true,nodes,false).as(E)
	end
end


#An iterator that uses the Breadth First Search method for traversal
class TreeIteratorBfsLeft[E,T]
	super TreeIterator[E,T]

	#Advances the cursor to the next node
	redef fun next
	do
		currentItem = sourceTree.walkWithList(false,nodes,true).as(E)
	end
end

#An iterator that uses the Breadth First 
class TreeIteratorBfsRight[E,T]
	super TreeIterator[E,T]

	#advances the cursor to the next node
	redef fun next
	do
		currentItem = sourceTree.walkWithList(true,nodes,true).as(E)
	end
end

