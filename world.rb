require "test/unit"

class World
  
  def self.run(*cells)
    arr = Array.new
    
    cells.each do |cell| 
      if getNumberOfNeighbours(cell, *cells) >= 2 && getNumberOfNeighbours(cell, *cells) <= 3
        arr << cell 
      end
    end
    
    return arr
  end
  
  def self.areNeighbours(cell_1, cell_2)
    c1_x = cell_1.x
    c1_y = cell_1.y
    c2_x = cell_2.x
    c2_y = cell_2.y
    
    x_range = cell_1.x-1..cell_1.x+1
    y_range = cell_1.y-1..cell_1.y+1
    
    return true if x_range.include?(cell_2.x) and y_range.include?(cell_2.y) and cell_1 != cell_2
    false
  end
  
  def self.getNumberOfNeighbours(cell, *others)

    count = 0
    others.each do |other_cell|
      count += 1 if areNeighbours(cell, other_cell)
    end
    count
  end
end

class Cell
  attr :x, true
  attr :y, true
  
  def initialize(x, y)
    @x = x
    @y = y
  end

end

class WorldTest < Test::Unit::TestCase
  
  def setup
    @c1 = Cell.new(1,1)
    @c2 = Cell.new(1,0)
    @c3 = Cell.new(0,1)
    @c4 = Cell.new(0,0)
    @c5 = Cell.new(1,2)
    @c_not_neighbour = Cell.new(5,0)
  end
  
  def test_cell_has_a_x_y_location
    assert(@c1.x == 1)
    assert(@c1.y == 1)
  end
  
  def test_world_identifies_neighbours
    
    assert(World.areNeighbours(@c1, @c2))
    assert(!World.areNeighbours(@c1, @c_not_neighbour))
  end
  
  def test_number_of_neighbours_for_a_cell
    assert_equal 2, World.getNumberOfNeighbours(@c1, [@c2, @c3])
  end
  
  def test_world_kills_cell_if_more_than_3_neighbours
    assert(World.run(@c1, @c2, @c3, @c4, @c5).include?(@c1) == false)
  end
  
  def test_world_kills_cell_if_fewer_than_two_neighbours
    assert(World.run(@c1, @c2).include?(@c1) == false)
    assert(World.run(@c1, @c2).include?(@c2) == false)
  end
  
  def test_world_keeps_cell_if_two_neighbours
    assert(World.run(@c1, @c2, @c3).include?(@c1) == true)
  end

  def test_world_keeps_cell_if_three_neighbours
    assert(World.run(@c1, @c2, @c3, @c4).include?(@c1) == true)
  end
  
  def test_world_resurrects_cells_with_three_neighbours
    assert(World.run(@c2, @c3, @c4).)
  end
  
  def teardown
  end
  
end 