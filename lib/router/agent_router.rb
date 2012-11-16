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

  def self.select_agent(business)
    target_agent = -1;
    agent_found = false
    agents_cycle = init_agents
    if agents_cycle != nil
      until agent_found == true do
        next_agent = agents_cycle.pop
        agents_cycle.push(next_agent)
        if Agent.find(next_agent).business.id == business.id
          target_agent = next_agent
          agent_found = true
        end
      end
      target_agent

    else
      #TODO handle this appropriately
      1
    end
  end

end