class Roomba

  def initialize(matrix)
    @matrix = matrix
    @infinity = 100 #impossible distance, usually a wall or block
    @far_away = 50 #could be connected, but unknown large distance
    @near = 1 #short distance
    @same_spot = 0 #no distance. It's right there.
    @l = matrix.length
    @w = matrix[0].length
  end

  def shortest_path_wg(matrix, init = 0)

    # Distance Setup
    vertex = []
    v = matrix[0].length
    dist = []
    v.times do |i|
      dist << @infinity
    end
    dist[init] = 0

    loop do                         # Need to loop thru all the distances several times until no more distances are recalculated.
      something_changed = false

      v.times do |i|
        vertex << i
      end
      while vertex.length > 0

        u = vertex.shift

        matrix[u].each_with_index do |i,j|

          next if i == 0
          alt =  dist[u] + i
          if alt < dist[j]
            dist[j] = alt
            something_changed = true
          end

        end
      end

      break if  !something_changed
    end

    dist
  end

  def convert_to_wg
    g = Array.new(@l*@w){Array.new(@l*@w,@far_away)}
    vertices = @l * @w
    # Fill up weights for all the WALLS first
    (0...@l).each do |i|
      (0...@w).each do |j|
        if @matrix[i][j] == 'W'
          (0...vertices).each do |k|
            g[i*@l + j][k] = @infinity
            g[k][i*@l + j] = @infinity
          end
        end
      end
    end
    # Then fill up weights for the rest of the spaces
    (0...@l).each do |i|
      (0...@w).each do |j|
        if @matrix[i][j] == 'O' || @matrix[i][j] == 'R'
          (0...vertices).each do |k|
            g[i*@l + j][k] = @near if valid_neighbor(i,j,k) && g[i*@l + j][k] != @infinity
          end
        end
        g[i*@l + j][i*@l + j] = @same_spot
      end
    end
    return g
  end

  def robot_position
    (0...@l).each do |i|
      return i*@l + @matrix[i].index('R') if @matrix[i].index('R')
    end
    return 0
  end

  # this method will return [distance, [x,y]] of furthest point from roomba
  def furthest_point(arr)
    max = 0; index = 0
    (0...arr.length).each do |i|
      if arr[i] != @infinity && arr[i] > max
        max = arr[i]
        index = i
      end
    end
    [arr[index], [index / @l + 1, index % @l + 1]]
  end

  private

  def valid_neighbor(i,j,k)
    north = i - @near
    south = i + @near
    east  = j + @near
    west  = j - @near
    return true if north >= 0 && k == north*@l + j
    return true if south < @l && k == south*@l + j
    return true if east < @w && k == i*@l + east
    return true if west >= 0 && k == i*@l + west
    return false
  end
end

matrix =  [
  ['R', 'O', 'W', 'O'],
  ['O', 'O', 'W', 'O'],
  ['O', 'O', 'W', 'O'],
  ['W', 'O', 'O', 'O']
  ]
r = Roomba.new(matrix)
p r.convert_to_wg
#=> [[0,    1,100, 50,  1, 50,100, 50, 50, 50,100, 50,100, 50, 50, 50],
#    [1,    0,100, 50, 50,  1,100, 50, 50, 50,100, 50,100, 50, 50, 50],
#    [100,100,  0,100,100,100,100,100,100,100,100,100,100,100,100,100],
#    [50,  50,100,  0, 50, 50,100,  1, 50, 50,100, 50,100, 50, 50, 50],
#    [1,   50,100, 50,  0,  1,100, 50,  1, 50,100, 50,100, 50, 50, 50],
#    [50,   1,100, 50,  1,  0,100, 50, 50,  1,100, 50,100, 50, 50, 50],
#    [100,100,100,100,100,100,  0,100,100,100,100,100,100,100,100,100],
#    [50,  50,100,  1, 50, 50,100,  0, 50, 50,100,  1,100, 50, 50, 50],
#    [50,  50,100, 50,  1, 50,100, 50,  0,  1,100, 50,100, 50, 50, 50],
#    [50,  50,100, 50, 50,  1,100, 50,  1,  0,100, 50,100,  1, 50, 50],
#    [100,100,100,100,100,100,100,100,100,100,  0,100,100,100,100,100],
#    [50,  50,100, 50, 50, 50,100,  1, 50, 50,100,  0,100, 50, 50,  1],
#    [100,100,100,100,100,100,100,100,100,100,100,100,  0,100,100,100],
#    [50,  50,100, 50, 50, 50,100, 50, 50,  1,100, 50,100,  0,  1, 50],
#    [50,  50,100, 50, 50, 50,100, 50, 50, 50,100, 50,100,  1,  0,  1],
#    [50,  50,100, 50, 50, 50,100, 50, 50, 50,100,  1,100, 50,  1,  0]]
p r.shortest_path_wg(r.convert_to_wg,r.robot_position)
# => [0, 1, 100, 9, 1, 2, 100, 8, 2, 3, 100, 7, 100, 4, 5, 6]
p r.furthest_point(r.shortest_path_wg(r.convert_to_wg,r.robot_position))
# => [9, [1, 4]]
matrix =  [
  ['O', 'O', 'O', 'O', 'W', 'O', 'O'],
  ['O', 'O', 'O', 'O', 'O', 'O', 'O'],
  ['O', 'O', 'O', 'O', 'W', 'O', 'O'],
  ['O', 'O', 'O', 'O', 'W', 'O', 'O'],
  ['O', 'O', 'O', 'O', 'W', 'O', 'O'],
  ['O', 'O', 'R', 'O', 'W', 'O', 'O'],
  ['W', 'O', 'O', 'O', 'W', 'W', 'W']
  ]
r = Roomba.new(matrix)
p r.shortest_path_wg(r.convert_to_wg,r.robot_position)
# => [7, 6, 5, 6, 100, 8, 9, 6, 5, 4, 5, 6, 7, 8, 5, 4, 3, 4, 100, 8, 9, 4, 3, 2, 3, 100, 9, 10, 3, 2, 1, 2, 100, 10, 11, 2, 1, 0, 1, 100, 11, 12, 100, 2, 1, 2, 100, 100, 100]
p r.furthest_point(r.shortest_path_wg(r.convert_to_wg,r.robot_position))
# => [12, [6, 7]]