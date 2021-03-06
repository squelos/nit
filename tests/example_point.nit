# This file is part of NIT ( http://www.nitlanguage.org ).
#
# Copyright 2004-2008 Jean Privat <jean@pryen.org>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

class Point
private
	var _x: Int	# Abscisse
	var _y: Int	# Ordonnée


	fun x: Int
	do
		return _x
	end
	fun x=(i: Int)
	do
		_x = i
	end

	fun y: Int
	do
		return _y
	end
	fun y=(i: Int)
	do
		_y = i
	end

	# Change la position d'un point
	fun moveto(x: Int, y: Int)
	do
		_x = x
		_y = y
	end

	redef fun to_s: String
	do
		var s = "({_x}:{_y})"
		return s
	end

	redef fun ==(p)
	do
		return not p is null and p isa Point and _x == p.x and _y == p.y
	end


	init
	do
		moveto(0, 0)
	end

	init at(x: Int, y: Int)
	do
		moveto(x, y)
	end

end


var p1 = new Point
var p2 = new Point.at(5, 8)
print(p1)		# (0,0)
print(p2)		# (5,8)
print(p1 == p2)	# false
p1.moveto(5,12)
p2.y = 12
print(p1 == p2)	# true
