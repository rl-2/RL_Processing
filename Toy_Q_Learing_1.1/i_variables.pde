int N_STATES = 10;   // the length of the 1 dimensional world
String[] ACTIONS = {"left", "right"};     // available actions
float EPSILON = 0.9;   // greedy police
float ALPHA = 0.1;     // learning rate
float GAMMA = 0.9;    // discount factor
int MAX_EPISODES = 13;   // maximum episodes
int FRESH_TIME = 30;    // fresh time for one move

int step_counter, S;
boolean is_terminated = true;
int episode = 0;
Table q_table;


ArrayList<Float> history = new ArrayList();