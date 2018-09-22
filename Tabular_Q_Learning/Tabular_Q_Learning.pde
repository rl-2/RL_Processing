
// hyper-parameters
float EPSILON = 0.9;   // greedy police
float GAMMA = 0.9;    // discount factor
float ALPHA = 0.1;     // learning rate

int N_STATES = 10;   // the length of the 1 dimensional world
String[] ACTIONS = {"left", "right"};     // available actions
int MAX_EPISODES = 13;   // maximum episodes

Grid env;
Table q_table;
int step_counter, obs;
int episode = 0;

void setup() {
  size(560, 400);
  
  int screen_width = 560;
  int screen_height = 400;
  
  // create a new env, equivalent to gym.make()
  env = new Grid(N_STATES, ACTIONS, screen_width, screen_height);

  // create a q table
  q_table = build_q_table(N_STATES, ACTIONS);
}

boolean done = true;

void draw() {
  
  background(255);
  env.render(obs);

  if (done) {
    obs = env.reset();
    done = false;
    step_counter = 0;
    episode += 1;
  } else if (!done) {
    String action = choose_action(obs, q_table); 
    int[] info = env.step(obs, action);
    int obs_next = info[0];
    int reward = info[1];
    if (info[2] == 0) done = false;
    else if (info[2] == 1) done = true;

    // Q-Learning part 
    float q_predict = q_table.getFloat(obs, action);
    float q_target;

    if (obs_next != -1) {
      TableRow row = q_table.getRow(obs_next);
      float[] state_actions = new float[q_table.getColumnCount()];
      for (int i=0; i<q_table.getColumnCount(); i++) {
        state_actions[i] = row.getFloat(i);
      }
      q_target = reward + GAMMA * max(state_actions);
    } else {
      q_target = reward;
      done = true;
      println("Episode " + episode + ": total_steps= " + step_counter);
    }

    float update_value = q_table.getFloat(obs, action) + ALPHA * (q_target-q_predict);
    q_table.setFloat(obs, action, update_value);
    obs = obs_next;

    step_counter += 1;
  }
  
  if(episode > MAX_EPISODES) exit();
}