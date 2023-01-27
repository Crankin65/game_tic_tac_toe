class InputPrompt
  def initialize(prompt)
    @prompt = prompt
  end

  def self.ask(prompt)
    new(prompt).ask
  end

  def ask
    puts @prompt

    gets.chomp
  end
end