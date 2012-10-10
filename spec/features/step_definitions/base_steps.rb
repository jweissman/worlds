
module BaseSteps
  step "there is a world" do
    @world = World::Base.new
  end

  step "the world is awesome" do
    @world.should be_awesome
  end
end