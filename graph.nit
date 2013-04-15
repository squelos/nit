module graph

#Can have multiple children 
abstract class AbstractNode[E]
	var parent:nullable E	
end 


abstract class AbstractTree[E]
	var root:E
end

abstract class BinaryNode[E]
	var _element:E
	var _leftChild:nullable BinaryChildNode[E]
	var _rightChild:nullable BinaryChildNode[E]

	private init(elem:E) do
		_element = elem
	end

	fun element:E
	do
		return _element
	end

	fun element=(elem:E)
	do
		_element = elem
	end

	fun addLeft(child:E)
	do
		_leftChild = new BinaryChildNode[E].withParent(child, self)
		child.parent = self
	end

	fun addRight(child:E)
	do
		_rightChild = new BinaryChildNode[E].withParent(child, self)
		child.parent = self
	end
	
	#sets the leftChildNode and sets its parent to self
	fun leftChild=(left:nullable BinaryChildNode[E])
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
	fun rightChild=(right:nullable BinaryChildNode[E])
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


	fun parent=(parent:BinaryNode[E])
	do
		_parent = parent
	end

	fun parent:BinaryNode[E]
	do
		return _parent
	end
end

#has no parent
class BinaryRootNode[E]
	super BinaryNode[E]

	init withElement(elem:E)
	do
		init(elem)
	end
	
end

#Contains multiple nodes, and starts with a root node
class BinaryTree[E]
	var rootNode:BinaryRootNode[E]

	init(root:BinaryRootNode[E])
	do
		rootNode = root
	end

	fun dfsLeftIterator:TreeIterator[BinaryNode[E],E]
	do
		return new TreeIteratorDfsLeft[BinaryNode[E],E](self)
	end

	fun dfsRightIterator:TreeIterator[BinaryNode[E],E]
	do
		return new TreeIteratorDfsRight[BinaryNode[E],E](self)
	end

	fun bfsLeftIterator:TreeIterator[BinaryNode[E],E]
	do
		return new TreeIteratorBfsLeft[BinaryNode[E],E](self)
	end

	fun bfsRightIterator:TreeIterator[BinaryNode[E],E]
	do		
		return new TreeIteratorBfsRight[BinaryNode[E],E](self)
	end

	fun walkDfsLeft
	do
		walkDfs(false)
	end

	fun walkDfsRight
	do
		walkDfs(true)
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
		print rootNode.element 
		

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

	fun walkBfsLeft
	do
		walkBfs(false)
	end

	fun walkBfsRight
	do
		walkBfs(true)
	end

	fun walkBfs(direction:Bool)
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
	private fun walkWithList(direction:Bool, list:List[nullable BinaryChildNode[E]],bfs:Bool):nullable BinaryChildNode[E]
	do
		
		var currentNode:nullable BinaryChildNode[E]
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
			print currentNode.element
		else
			currentNode = null
		end
		
		return currentNode
	end
end

abstract class TreeIterator[E,T]
	super Iterator[E]
	
	var sourceTree:BinaryTree[T]
	var currentItem:E
	var nodes:List[nullable BinaryChildNode[T]] = new List[nullable BinaryChildNode[T]]

	redef fun is_ok 
	do
		if currentItem != null then
			return true
		else
			return false
		end
	end

	redef fun item  do return currentItem

	redef fun next
	do
		#we advance the cursor		
	end

	init(tree:BinaryTree[T])
	do
		sourceTree = tree
		currentItem = tree.rootNode
		nodes.add(sourceTree.rootNode.as(nullable BinaryChildNode[T]))
	end
end

class TreeIteratorDfsLeft[E,T]
	super TreeIterator[E,T]

	redef fun next
	do
		currentItem = sourceTree.walkWithList(false,nodes,false).as(E)
		#we call the walking method and
	end
end

class TreeIteratorDfsRight[E,T]
	super TreeIterator[E,T]

	redef fun next
	do
		currentItem = sourceTree.walkWithList(true,nodes,false).as(E)
	end
end

class TreeIteratorBfsLeft[E,T]
	super TreeIterator[E,T]

	redef fun next
	do
		currentItem = sourceTree.walkWithList(false,nodes,true).as(E)
	end
end

class TreeIteratorBfsRight[E,T]
	super TreeIterator[E,T]

	redef fun next
	do
		currentItem = sourceTree.walkWithList(true,nodes,true).as(E)
	end
end

