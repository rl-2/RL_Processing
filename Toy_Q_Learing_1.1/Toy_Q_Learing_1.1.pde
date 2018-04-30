// First RL Demo in Processing 
//
// by Jieliang (Rodger) Luo
// rodgerluo.com
//
// March 3th, 2018
// Developed on OpenAI Hachathon
//
// Reference: 
// MorvanZhou's RL Example 
// (https://github.com/MorvanZhou/Reinforcement-learning-with-tensorflow/tree/master/contents/1_command_line_reinforcement_learning)
//
// Thanks to Andreas Schlegel for adding the animation part to visualizing the agent's footprints. 

void setup() {
  size(600, 1000);
  initSketch();
}


void draw() {
  background(255);
  
  float val = update();
  history.add(val);

  drawTargetAt(width, 100);
  drawAgentAt(val, width, 100);
  drawHistoryAt(0, 200, width);
}




float update() {

  if (episode > MAX_EPISODES) return -1;

  if (is_terminated) { 
    step_counter = 0;
    S = 0;
    is_terminated = false;
    episode++;
    return update_env(S, episode, step_counter);
  } else {
    String A = choose_action(S, q_table);
    int[] S_R = get_env_feedback(S, A);
    int S_Next = S_R[0];
    int R = S_R[1];
    float q_predict = q_table.getFloat(S, A);
    float q_target;

    if (S_Next != -1) {
      TableRow row = q_table.getRow(S_Next);
      float[] state_actions = new float[q_table.getColumnCount()];
      for (int i=0; i<q_table.getColumnCount(); i++) {
        state_actions[i] = row.getFloat(i);
      }
      q_target = R + GAMMA * max(state_actions);
    } else {
      q_target = R;
      is_terminated = true;
    }

    float update_value = q_table.getFloat(S, A) + ALPHA * (q_target-q_predict);
    q_table.setFloat(S, A, update_value);
    S = S_Next;

    step_counter++;
    float val = update_env(S, episode, step_counter);
    
    if (val == -1) {
      println("Episode " + episode + ": total_steps= " + step_counter);
      val = N_STATES-1;
    }
    
    return val;
  }
}