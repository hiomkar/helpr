class AgentRouter

  def self.init_agents
    if @all_agents == nil
      agents = Agent.all
      agent_ids = Queue.new
      agents.each { |a| agent_ids.push(a.id)  }
      @all_agents = agent_ids
    end
    return @all_agents
  end

  def self.select_agent
    agents_cycle = init_agents
    if agents_cycle != nil
      next_agent = agents_cycle.pop
      agents_cycle.push(next_agent)
      next_agent
    else
      #TODO handle this appropriately
      1
    end
  end

end