module redBlackTree

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

	fun iterator:RBIteratorInOrder[RBNode[E,T],E,T]
	do

		return new RBIteratorInOrder[RBNode[E,T],E,T](self)
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

	fun delete(key:E):nullable T
	do
		var n = findKeyNode(key)
		var returnValue = n.value
		if n == null then
			return null
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
		return n.value

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
		if oldNode.parent == null then 
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
	
	private fun deleteCase3(n:nullable RBNode[E,T])
	do
		if not color(n.parent) and not color(n.sibling) and not color(n.sibling.left) and not color(n.sibling.right) then
			n.sibling.isRed = true
			deleteCase1(n.parent)
		else
			deleteCase4(n)
		end
	end

	private fun deleteCase4(n:nullable RBNode[E,T])
	do
		if color(n.parent) and not color(n.sibling) and not color(n.sibling.left) and not color(n.sibling.right) then
			n.sibling.isRed = true
			n.parent.isRed = false
		else
			deleteCase5(n)
		end
	end

	private fun deleteCase5(n:nullable RBNode[E,T])
	do
		if n == n.parent.left and not color(n.sibling) and color(n.sibling.left) and not color(n.sibling.right) then
			n.sibling.isRed = true
			n.sibling.left.isRed = false
			rotateRight(n.sibling)
		else 
			if n == n.parent.right and not color(n.sibling) and color(n.sibling.right) and not color(n.sibling.left) then
				n.sibling.isRed = true
				n.sibling.right.isRed = false
				rotateLeft(n.sibling)
			end
		end
		deleteCase6(n)
	end

	private fun deleteCase6(n:nullable RBNode[E,T])
	do
		n.sibling.isRed = color(n.parent)
		n.parent.isRed = false
		if n == n.parent.left then
			n.sibling.right.isRed = false
			rotateLeft(n.parent)
		else
			n.sibling.left.isRed = false
			rotateRight(n.parent)
		end
	end

	private fun walkWithList(list:List[nullable RBNode[E,T]])
	do
		var node:nullable RBNode[E,T]
		node = rootNode
		var tmpStack = new List[nullable RBNode[E,T]]
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

abstract class RBIterator[E,T:Comparable,T2]
	super Iterator[E]

	private var sourceTree:RBTree[T,T2]
	private var currentItem:nullable E
	private var nodes:List[E] = new List[E]
	private var i:Int = 1
	private var ok:Bool = false
	

	redef fun is_ok
	do
		return ok
	end

	redef fun next
	do

	end

	redef fun item do return currentItem.as(not null)

	init(tree:RBTree[T,T2])
	do
		sourceTree = tree
		#tree.buildList(nodes)
		tree.walkWithList(nodes.as(List[nullable RBNode[T,T2]]))
		currentItem = nodes[0]
		if nodes[0] != null then ok = true
		#nodes.add(sourceTree.rootNode)
	end
end

class RBIteratorInOrder[E,T:Comparable,T2]
	super RBIterator[E,T,T2]

	#Advances the cursor to the next node
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
