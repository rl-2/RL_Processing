// initialize a table with all zeros 
Table build_q_table(int n_states, String[] actions) {
  Table table = new Table();

  for (int i=0; i<actions.length; i++) {
    table.addColumn(actions[i]);
  }

  for (int j=0; j<n_states; j++) {
    TableRow newRow = table.addRow();
    for (int i=0; i<table.getColumnCount(); i++) {
      newRow.setFloat(actions[i], 0);
    }
  }

  return table;
}

String choose_action(int state, Table q_table) {

  TableRow row = q_table.getRow(state);
  float[] state_actions = new float[q_table.getColumnCount()];

  for (int i=0; i<q_table.getColumnCount(); i++) {
    state_actions[i] = row.getFloat(i);
  }

  if ( (random(1) > EPSILON) || (state_actions[0] == 0 && state_actions[1] == 0) ) {
    return (random(1) < 0.5) ? "left" : "right";
  } else {
    return (state_actions[0] >= state_actions[1]) ? "left" : "right";
  }
}


int[] get_env_feedback(int S, String A) {
  int S_Next, R;
  if (A.equals("right")) {
    if (S == N_STATES-2) {
      S_Next = -1; // terminate
      R = 1;
    } else {
      S_Next = S + 1;
      R = 0;
    }
  } else {
    R = 0;
    if (S == 0) {
      S_Next = S;
    } else {
      S_Next = S - 1;
    }
  }

  int[] S_R = {S_Next, R};

  return S_R;
}

float update_env(int S, int episode, int step_counter) {
  char[] env_list = new char[N_STATES];

  for (int i=0; i<env_list.length; i++) {
    if (i == env_list.length-1) {
      env_list[i] = 'T';
    } else {
      env_list[i] = '-';
    }
  }
  
  delay(FRESH_TIME);
  
  return S;
  
}