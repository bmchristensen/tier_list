class List
  attr_accessor :size, :champions

  def initialize
    @champions = []
    @size = 0
  end

  def empty?
    @size.equal? 0
  end
end
