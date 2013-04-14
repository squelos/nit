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
	init(elem:E) do
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
end


class BinaryChildNode[E]
	super BinaryNode[E]
	var _leftChild:nullable BinaryChildNode[E]
	var _rightChild:nullable BinaryChildNode[E]
	var _parent:BinaryNode[E]

	init withParent(elem:E,parentNode:BinaryNode[E], parentSide:nullable BinaryChildNode[E])
	do
		init(elem)
		_parent = parentNode
		parentSide = self
	end

	init withChildren(elem:E,left:nullable BinaryChildNode[E], right:nullable BinaryChildNode[E], parentNode:BinaryNode[E], parentSide:nullable BinaryChildNode[E])
	do
		init(elem)
		_leftChild = left
		left.parent = self
		_rightChild = right
		right.parent = self
		_parent = parentNode
		parentSide = self
	end

	#initializes with a left child and a parent
	# The parentSide arg is set to Self 
	init withLeft(elem:E,left:nullable BinaryChildNode[E], parentNode:BinaryNode[E],parentSide:nullable BinaryChildNode[E])
	do
		init(elem)
		_leftChild = left
		_leftChild.parent = self
		_parent = parentNode
		parentSide = self
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

	var _leftChild:nullable BinaryChildNode[E]
	var _rightChild:nullable BinaryChildNode[E]

	fun leftChild=(left:nullable BinaryChildNode[E])
	do
		_leftChild = left
		left.parent = self
	end
	
	fun leftChild:nullable BinaryChildNode[E]
	do
		return _leftChild
	end

	fun rightChild=(right:nullable BinaryChildNode[E])
	do
		_rightChild = right
		right.parent = self
	end

	fun rightChild:nullable BinaryChildNode[E]
	do
		return _rightChild
	end


end

#Contains multiple nodes, and starts with a root node
class BinaryTree[E]
	var rootNode:BinaryRootNode[E]
	init(root:BinaryRootNode[E])
	do
		rootNode = root
	end

	fun walkDfsLeft
	do
		var nodesToWalk:List[nullable BinaryChildNode[E]] = new List[nullable BinaryChildNode[E]]
		
		if rootNode.rightChild != null then nodesToWalk.push(rootNode.rightChild)
		if rootNode.leftChild != null then nodesToWalk.push(rootNode.leftChild)

		while nodesToWalk.length >0 
		do
			var currentNode = nodesToWalk.pop

		
			if currentNode.rightChild != null then
				nodesToWalk.push(currentNode.rightChild)
			end
			if currentNode.leftChild != null then
				nodesToWalk.push(currentNode.leftChild)
			end
			print currentNode.element
		end

	end
end

class TreeIterator[E]
	super Iterator[E]
	var source:Iterator[E]
	var seen = new HashSet[Object]

	redef fun is_ok do return source.is_ok

	redef fun item do return source.item

	redef fun next
	do
		self.seen.add(self.item.as(Object))
		source.next
		while source.is_ok and self.seen.has(source.item.as(Object)) do
			source.next
		end
	end
end
