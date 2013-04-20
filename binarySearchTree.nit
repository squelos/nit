module binarySearchTree

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

	private fun minValue:E
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
	private var currentItem:nullable E
	private var nodes:List[E] = new List[E]
	private var i:Int = 0
	redef fun is_ok
	do
		if currentItem == null then 
			return false
		else 
			return true
		end
	end

	redef fun next
	do

	end

	redef fun item do return currentItem.as(not null) #FIXME sale

	init(tree:BinarySearchTree[T])
	do
		sourceTree = tree
		#tree.buildList(nodes)
		tree.walkWithList(nodes.as(List[nullable BinarySearchNode[T]]))
		#currentItem = nodes[i]
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
		else
			currentItem = null
		end
		#currentItem = sourceTree.walkWithList(nodes).as(E)
	end
end
