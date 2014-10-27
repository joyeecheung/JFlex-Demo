class Yytoken {
  public int m_index;
  public String m_text;

  Yytoken (int index, String text) {
     m_index = index;
     m_text = text;
  }

  public String toString() {
    return "(Text: "+m_text+ "    index : "+m_index+")\n";
  }
}

