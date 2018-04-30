

void drawTargetAt(float theX, float theY) {
  float sw = 20;
  float sh = 20;
  float x = theX - sw;
  float y = theY - sh/2;
  fill(255, 0, 0);
  rect(x, y, sw, sh);
}

void drawAgentAt(float theValue, float theLen, float theY) {
  float sw = 20;
  float sh = 20;
  float x = map(theValue, 0, N_STATES, 0, theLen - sw);
  float y = theY - sh/2;
  fill(122, 122);
  rect(x, y, sw, sh);
}


void drawHistoryAt(float theX, float theY, float theLen) {
  pushStyle();
  stroke(0, 200);
  noFill();
  pushMatrix();
  translate(theX, theY);
  float y = 0;
  beginShape();
  for (Float f : history) {
    vertex(map(f, 0, N_STATES-1, 0, width), y++);
  }
  endShape();
  popMatrix();
  popStyle();
}