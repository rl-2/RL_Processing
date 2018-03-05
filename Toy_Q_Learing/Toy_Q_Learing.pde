// First RL Demo in Processing 
//
// by Jieliang (Rodger) Luo
// March 3th, 2018
// Developed on OpenAI Hachathon 

int N_STATES = 6;   // the length of the 1 dimensional world
String[] ACTIONS = {"left", "right"};     // available actions
float EPSILON = 0.9;   // greedy police
float ALPHA = 0.1;     // learning rate
float GAMMA = 0.9;    // discount factor
int MAX_EPISODES = 13;   // maximum episodes
int FRESH_TIME = 300;    // fresh time for one move

// initialize a table with all zeros 
Table build_q_table(int n_states, String[] actions){
  Table table = new Table();
  
  for(int i=0; i<actions.length; i++){
    table.addColumn(actions[i]);
  }
  
  for(int j=0; j<n_states; j++){
      TableRow newRow = table.addRow();
      for(int i=0; i<table.getColumnCount(); i++){
        newRow.setFloat(actions[i], 0);
      }
    }
  
  return table;
}

String choose_action(int state, Table q_table){
  TableRow row = q_table.getRow(state);
  float[] state_actions = new float[q_table.getColumnCount()];
  for(int i=0; i<q_table.getColumnCount(); i++){
    state_actions[i] = row.getFloat(i);
  }
  
  if( (random(1) > EPSILON) || (state_actions[0] == 0 && state_actions[1] == 0) ){  
    if(random(1) < 0.5){
      return "left";
    }
    else{
      return "right";
    }
  }
  
  else{
    if(state_actions[0] >= state_actions[1]) {
      return "left";
    }
    else return "right";
  }
}

int[] get_env_feedback(int S, String A){
  int S_Next, R;
  if(A.equals("right")){
    if(S == N_STATES-2){
      S_Next = -1; // terminate
      R = 1;
    }
    else{
      S_Next = S + 1;
      R = 0;
    }
  }
  
  else{
    R = 0;
    if(S == 0){
      S_Next = S;
    }
    else{
      S_Next = S - 1;
    }
  }
  
  int[] S_R = {S_Next, R};
  
  return S_R;
}

void update_env(int S, int episode, int step_counter){
  char[] env_list = new char[N_STATES];
  
  for(int i=0; i<env_list.length; i++){
    if(i == env_list.length-1){
      env_list[i] = 'T';
    }
    else{
      env_list[i] = '-';
    }
  }
  
  if(S == -1){
    println("Episode " + episode + ": total_steps= " + step_counter);
    delay(2000);
  }
  else{
    env_list[S] = 'o';
    String env = "";
    for(int i=0; i<env_list.length; i++){
      env += env_list[i];
    }
    println(env);
    delay(FRESH_TIME);
  }
}

Table rl(){
  Table q_table = build_q_table(N_STATES, ACTIONS);
  
  for(int episode=0; episode<MAX_EPISODES; episode++){
    int step_counter = 0;
    int S = 0;
    boolean is_terminated = false;
    update_env(S, episode, step_counter);
    
    while(!is_terminated){
      String A = choose_action(S, q_table);
      int[] S_R = get_env_feedback(S, A);
      int S_Next = S_R[0];
      int R = S_R[1];
      float q_predict = q_table.getFloat(S, A);
      float q_target;
      
      if(S_Next != -1){
        TableRow row = q_table.getRow(S_Next);
        float[] state_actions = new float[q_table.getColumnCount()];
        for(int i=0; i<q_table.getColumnCount(); i++){
          state_actions[i] = row.getFloat(i);
        }
        q_target = R + GAMMA * max(state_actions);
      }
      else{
        q_target = R;
        is_terminated = true;
      }
      
      float update_value = q_table.getFloat(S, A) + ALPHA * (q_target-q_predict);
      q_table.setFloat(S, A, update_value);
      S = S_Next;
      
      update_env(S, episode, step_counter+1);

      step_counter += 1;
    }
  }
  
  return q_table;
}

void setup(){
  //Table table = build_q_table(N_STATES, ACTIONS);
  //saveTable(table, "data/table.csv");
  Table q_table = rl();
  //println("Q Table");
  //println(q_table);
}