module graph

#Can have multiple children 
abstract class AbstractNode[E]
	var _element:E

	fun element:E
	do
		return _element
	end

	fun element=(elem:E)
	do
		_element = elem
	end

	init(elem:E)do
		_element = elem
	end

end 


abstract class AbstractTree[E]
	var rootNode:AbstractNode[E]
end

abstract class BinaryNode[E]
	super AbstractNode[E]
	var _leftChild:nullable BinaryChildNode[E]
	var _rightChild:nullable BinaryChildNode[E]

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
	#super AbstractTree[E]
	var rootNode:BinaryRootNode[E]

	init(root:BinaryRootNode[E])
	do
		rootNode = root
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
	
	var sourceTree:BinaryTree[T]
	var currentItem:E
	
	var nodes:List[nullable BinaryNode[T]] = new List[nullable BinaryNode[T]]

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

class TreeIteratorDfsLeft[E,T]
	super TreeIterator[E,T]

	#advances the cursor to the next node
	redef fun next
	do
		currentItem = sourceTree.walkWithList(false,nodes,false).as(E)
		#we call the walking method and
	end
end

class TreeIteratorDfsRight[E,T]
	super TreeIterator[E,T]

	#advances the cursor to the next node
	redef fun next
	do
		currentItem = sourceTree.walkWithList(true,nodes,false).as(E)
	end
end

class TreeIteratorBfsLeft[E,T]
	super TreeIterator[E,T]

	#Advances the cursor to the next node
	redef fun next
	do
		currentItem = sourceTree.walkWithList(false,nodes,true).as(E)
	end
end

class TreeIteratorBfsRight[E,T]
	super TreeIterator[E,T]

	#advances the cursor to the next node
	redef fun next
	do
		currentItem = sourceTree.walkWithList(true,nodes,true).as(E)
	end
end

#Binary Search Tree Region Region

class BinarySearchTree[E:Comparable]
	var rootNode:BinarySearchNode[E]

	init withImplicitRoot(val:E)
	do
		rootNode = new BinarySearchRoot[E](val)
	end

	fun findKeyNode(key:E):nullable BinarySearchNode[E]
	do
		#we start at the rootNode 
		var currentNode:nullable BinarySearchNode[E]  = rootNode
		while currentNode!= null
		do
			if currentNode.key == key then
				return currentNode
			else
				if key < currentNode.key then
					currentNode = currentNode.left
				else
					currentNode = currentNode.right
				end
			end
		end
		currentNode = null
		return currentNode
	end

	fun iterator:BstIteratorInOrder[BinarySearchNode[E],E]
	do
		return new BstIteratorInOrder[BinarySearchNode[E],E](self)
	end

	fun insert(key:E):BinarySearchNode[E]
	do
		return insertHelper(rootNode, key)
	end

	private fun insertHelper(node:BinarySearchNode[E], key:E):BinarySearchNode[E]
	do
		var result = findKeyNode(key)
		if result == null then
			var inserted:BinarySearchNode[E]
			if key == node.key then return node
			if key < node.key then
				if node.left == null then
					node.left = new BinarySearchChild[E].withParent(key, node)
					inserted = node.left.as(not null)
				else
					inserted = insertHelper(node.left.as(not null), key)
				end
			else
				if node.right == null then
					node.right = new BinarySearchChild[E].withParent(key,node)
					inserted = node.right.as(not null)
				
				else
					inserted = insertHelper(node.right.as(not null), key)
				end
			end
			return inserted
		else
			return result
		end
		
	end

	fun delete(key:E):Bool
	do
		if rootNode.key == key then
			var auxRoot = new BinarySearchRoot[E](0)
			auxRoot.left = rootNode.as(nullable BinarySearchChild[E])
			var result = rootNode.remove(key, auxRoot)
			rootNode = auxRoot.left.as(not null)
			return result
		else
			return rootNode.remove(key, null)
		end
	end

	fun walkWithList(list:List[nullable BinarySearchNode[E]])
	do
		var node:nullable BinarySearchNode[E]
		node = rootNode.as(nullable BinarySearchNode[E])
		var tmpStack = new List[nullable BinarySearchNode[E]]
		while true
		do
			if node != null then
				tmpStack.push(node)
				node = node.left
			else
				if tmpStack.length == 0 then return
				node = tmpStack.pop	
				list.push(node)
				node = node.right
			end
		end
	end


end

abstract class BinarySearchNode[E:Comparable]
	var key:E
	private var _left:nullable BinarySearchChild[E]
	private var _right:nullable BinarySearchChild[E]

	init(keyValue:E)
	do
		key = keyValue
	end

	fun left=(val:nullable BinarySearchChild[E])
	do
		_left = val
		val.parent = self
	end

	fun left:nullable BinarySearchChild[E]
	do
		return _left
	end

	fun right=(val:nullable BinarySearchChild[E])
	do
		_right = val
		val.parent = self
	end

	fun right:nullable BinarySearchChild[E]
	do
		return _right
	end

	fun remove(keyValue:E, par:nullable BinarySearchNode[E]):Bool
	do

		if key < keyValue then
			if left != null then
				return left.remove(keyValue, self)
			else
				return false
			end
		else
			if keyValue > key then
				if right != null then
					return right.remove(keyValue, self)
				else
					return false
				end
			else
				if left != null and right != null then
					key = right.minValue
					right.remove(key, self)
				else
					if par.left == self then
						if left != null then
							par.left = left
						else
							par.left = right
						end
					else
						if par.right == self then
							if  left != null then
								par.right = left
							else
								par.right = right
							end
						end
					end

				end
				return true
			end		
		end
	end

	fun minValue:E
	do
		if left != null then
			return left.key
		else
			return left.minValue
		end

	end

end

class BinarySearchRoot[E:Comparable]
	super BinarySearchNode[E]
	

	
end

class BinarySearchChild[E:Comparable]
	super BinarySearchNode[E]
	private var _parent:BinarySearchNode[E]

	fun parent:BinarySearchNode[E]
	do
		return _parent
	end

	fun parent=(val:BinarySearchNode[E])
	do
		_parent = val
	end

	init withParent(val:E, par:BinarySearchNode[E])
	do
		init(val)
		#key = val
		_parent = par
	end

end

abstract class BstIterator[E,T:Comparable]
	super Iterator[E]

	var sourceTree:BinarySearchTree[T]
	var currentItem:E
	var nodes:List[E] = new List[E]
	var i:Int = 0
	redef fun is_ok
	do
		if i == nodes.length - 1 then 
			return false
		else 
			return true
		end
	end

	redef fun next
	do

	end

	redef fun item do return currentItem

	init(tree:BinarySearchTree[T])
	do
		sourceTree = tree
		#tree.buildList(nodes)
		tree.walkWithList(nodes.as(List[nullable BinarySearchNode[T]]))
		currentItem = nodes[i]
		#nodes.add(sourceTree.rootNode)
	end


end

class BstIteratorInOrder[E,T:Comparable]
	super BstIterator[E,T]

	redef fun next 
	do
		#currentItem = nodes[i].as(E)
		if nodes[i] != null then
			currentItem = nodes[i]
			i += 1
		end
		#currentItem = sourceTree.walkWithList(nodes).as(E)
	end
end

