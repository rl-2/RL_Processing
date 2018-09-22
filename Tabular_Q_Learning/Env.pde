class Grid {

  int FRESH_TIME = 300;    // fresh time for one move
  int agent_size = 40;
  int N_STATES, action_space, screen_width, screen_height;

  // initialize the env 
  Grid(int N_STATES, String[] actions, int screen_width, int screen_height) {
    this.N_STATES = N_STATES;
    this.action_space = actions.length;
    this.screen_width = screen_width;
    this.screen_height = screen_height;
  }

  // randomly choose an action
  String sample_action() {

    int action = floor(random(this.action_space));

    if (action == 0) {
      return "left";
    } else if (action == 1) {
      return "right";
    }

    return null;
  }

  // reset env
  int reset() {
    return 0;
  }

  // step function
  int[] step(int observation, String action) {

    int reward;
    int done = 0;

    if (action.equals("right")) {
      if (observation == this.N_STATES-2) {
        observation = -1; // terminate
        reward = 1;
        done = 1;
      } else {
        observation += 1;
        reward = 0;
      }
    } else {
      reward = 0;
      if (observation == 0) {
        observation = 0;
      } else {
        observation -= 1;
      }
    }

    int[] info = {observation, reward, done};

    return info;
  }

  void render(int S) {
    // target 
    fill(255, 0, 0);
    rect(screen_width - agent_size, (screen_height - agent_size)/2, 
         agent_size, agent_size);

    // agent
    fill(122, 122);
    rect(agent_size*S, (screen_height - agent_size)/2, 
         agent_size, agent_size);

    delay(FRESH_TIME);
  }
}