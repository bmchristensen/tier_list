class CreatesList
  attr_accessor :name, :list, :champ_string

  def initialize(name: "", champ_string: "")
    @name = name
    @champ_string = champ_string
    @success = false
  end

  def success?
    @success
  end

  def build
    self.list = List.new(name: name)
    list.champions = convert_string_to_champion
    list
  end

  def create
    build
    result = list.save
    @success = result
  end

  def convert_string_to_champion
    champ_string.split("\n").map do |one_champ|
      champ_name, tier = one_champ.split(":")
      Champion.new(name: champ_name, tier: tier)
    end
  end
end
