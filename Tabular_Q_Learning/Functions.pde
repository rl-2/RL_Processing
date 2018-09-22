String choose_action(int state, Table q_table) {
  TableRow row = q_table.getRow(state);
  float[] state_actions = new float[q_table.getColumnCount()];
  for (int i=0; i<q_table.getColumnCount(); i++) {
    state_actions[i] = row.getFloat(i);
  }

  if ( (random(1) > EPSILON) || (state_actions[0] == 0 && state_actions[1] == 0) ) {  
    if (random(1) < 0.5) {
      return "left";
    } else {
      return "right";
    }
  } else {
    if (state_actions[0] >= state_actions[1]) {
      return "left";
    } else return "right";
  }
}

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