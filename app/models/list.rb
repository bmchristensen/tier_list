class List
  attr_accessor :size, :champions

  def initialize
    @champions = []
    @size = 0
  end

  def empty?
    @champions.size.equal? 0
  end

  def size
  	@size = champions.size
  end
end
