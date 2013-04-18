module graph

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

	private fun walkWithList(list:List[nullable BinarySearchNode[E]])
	do
		var node:nullable BinarySearchNode[E]
		node = rootNode.as(nullable BinarySearchNode[E])
		var tmpStack = new List[nullable BinarySearchNode[E]]
		loop
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

	private fun left=(val:nullable BinarySearchChild[E])
	do
		_left = val
		val.parent = self
	end

	fun left:nullable BinarySearchChild[E]
	do
		return _left
	end

	private fun right=(val:nullable BinarySearchChild[E])
	do
		_right = val
		val.parent = self
	end

	fun right:nullable BinarySearchChild[E]
	do
		return _right
	end

	private fun remove(keyValue:E, par:nullable BinarySearchNode[E]):Bool
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

	private fun parent=(val:BinarySearchNode[E])
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

	private var sourceTree:BinarySearchTree[T]
	private var currentItem:E
	private var nodes:List[E] = new List[E]
	private var i:Int = 0
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

#RB Tree Region
class RBTree[E:Comparable, T]
	private  var _rootNode:nullable RBNode[E,T]

	fun rootNode:nullable RBNode[E,T]
	do
		return _rootNode
	end

	private fun rootNode=(node:nullable RBNode[E,T])
	do
		_rootNode = node
	end

	init withImplicitRoot(key:E,val:T)
	do
		_rootNode = new RBNode[E,T](key, val, false)
	end

	fun findKeyNode(key:E):nullable RBNode[E,T]
	do
		#we start at the rootNode 
		var currentNode:nullable RBNode[E,T]  = rootNode
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

	fun insert(key:E, val:T):nullable RBNode[E,T]
	do
		var insertedNode = new RBNode[E,T](key,val, true)
		var n = rootNode
		loop
			var compResult = key <=> n.key
			if compResult == 0 then
				n.value = val
				return insertedNode
			else
				if compResult == -1 then
					if n.left == null then
						n.left = insertedNode
						break
					else
						n = n.left
					end
				else
					if n.right == null then
						n.right = insertedNode
						break
					else
						n = n.right
					end
				end
			end
		end
		insertedNode.parent = n
		insertCase1(insertedNode)
		return insertedNode

	end

	fun delete(key:E)
	do
		var n = findKeyNode(key)
		if n != null then
			return
		end

		if n.left != null and n.right != null then
			var pred = maximumNode(n.left)
			n.key = pred.key
			n.value = pred.value
			n = pred
		end
		var child:nullable RBNode[E,T]
		if n.right == null then 
			child = n.left
		else
			child = n.right
		end

		if not color(n) then
			n.isRed = color(child)
			deleteCase1(n)
		end
		replaceNode(n,child)
		if color(rootNode) then
			rootNode.isRed = false
		end

	end

	private fun insertCase1(n:nullable RBNode[E,T])
	do
		if n.parent == null then
			n.isRed = false
		else
			insertCase2(n)
		end
	end

	private fun insertCase2(n:nullable RBNode[E,T])
	do
		if not color(n.parent) then
			return
		else
			insertCase3(n)
		end
	end

	private fun insertCase3(n:nullable RBNode[E,T])
	do
		if color(n.uncle) then
			n.parent.isRed = false
			n.uncle.isRed = false
			n.grandParent.isRed = true
			insertCase1(n.grandParent)
		else
			insertCase4(n)
		end
	end

	private fun insertCase4(n:nullable RBNode[E,T])
	do
		if n == n.parent.right and n.parent == n.grandParent.left then
			rotateLeft(n.parent)
			n = n.left
		else
			if n == n.parent.left and n.parent == n.grandParent.right then
				rotateRight(n.parent)
				n = n.right
			end
		end
		insertCase5(n)
	end

	private fun insertCase5(n:nullable RBNode[E,T])
	do
		n.parent.isRed = false
		n.grandParent.isRed = true
		if n == n.parent.left and n.parent == n.grandParent.left then
			rotateRight(n.grandParent)
		else
			rotateLeft(n.grandParent)
		end
	end
	
	private fun rotateLeft(node:nullable RBNode[E,T])
	do
		var r = node.right
		replaceNode(node,r)
		node.right = r.left
		if r.left != null then
			r.left.parent = node
		end
		r.left = node
		node.parent = r
	end
	
	private fun rotateRight(node:nullable RBNode[E,T])
	do
		var l = node.left
		replaceNode(node,l)
		node.left = l.right
		if l.right != null then
			l.right.parent = node
		end
		l.right = node
		node.parent = l
	end

	private fun replaceNode(oldNode:nullable RBNode[E,T], newNode:nullable RBNode[E,T])
	do
		if oldNode.parent != null then 
			rootNode = newNode
		else
			if oldNode == oldNode.parent.left then
				oldNode.parent.left = newNode
			else
				oldNode.parent.right = newNode
			end

		end
		if newNode != null then
			newNode.parent = oldNode.parent
		end
	end
	
	private fun color(node:nullable RBNode[E,T]):Bool
	do
		if node == null then
			return false
		else
			return node.isRed
		end
	end

	private fun maximumNode(node:nullable RBNode[E,T]):nullable RBNode[E,T]
	do
		while node.right != null 
		do
			node = node.right
		end
		return node
	end

	private fun deleteCase1(n:nullable RBNode[E,T])
	do
		if n.parent == null then 
			return
		else
			deleteCase2(n)
		end
	end

	private fun deleteCase2(n:nullable RBNode[E,T])
	do
		if color(n.sibling) then
			n.parent.isRed = true
			n.sibling.isRed = false
			if n == n.parent.left then
				rotateLeft(n.parent)
			else
				rotateRight(n.parent)
			end
		end
		deleteCase3(n)
	end
end


class RBNode[E:Comparable, T]
	private var _key:E
	private var _value:T
	private var _left:nullable RBNode[E,T]
	private var _right:nullable RBNode[E,T]
	private var _parent:nullable RBNode[E,T]
	private var _isRed:Bool

	init(k:E, val:T, red:Bool)
	do
		key = k
		value = val
		_isRed = red
	end

	init withParent(k:E,val:T,red:Bool, par:RBNode[E,T])
	do
		init(k,val,red)
		_parent = par
	end

	private fun key=(k:E)
	do
		_key = k
	end

	fun key:E
	do
		return _key
	end

	private fun value=(val:T)
	do
		_value = val
	end

	fun value:T
	do
		return _value
	end

	private fun left=(val:nullable RBNode[E,T])
	do
		_left = val
	end

	fun left:nullable RBNode[E,T]
	do
		return _left
	end

	private fun right=(val:nullable RBNode[E,T])
	do
		_right = val
	end

	fun right:nullable RBNode[E,T]
	do
		return _right
	end

	fun isRed:Bool
	do
		return _isRed
	end

	private fun isRed=(val:Bool)
	do
		_isRed = val
	end

	fun parent:nullable RBNode[E,T]
	do
		return _parent
	end

	private fun parent=(par:nullable RBNode[E,T])
	do
		_parent = par
	end

	fun grandParent:nullable RBNode[E,T]
	do
		if parent != null then
			if parent.parent != null then
				return parent.parent
			end
		end
		return null
	end

	fun sibling:nullable RBNode[E,T]
	do
	
		if parent != null then
			if self == parent.left then
				return parent.right
			else
				return parent.left
			end
		end
		return null
	end

	fun uncle:nullable RBNode[E,T]
	do
		if parent != null then
			if parent.parent != null then
				return parent.sibling
			end
		end
		return null
	end	
end
