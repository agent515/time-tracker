abstract class TimerRepository {
  void started();
  void paused();
  void resumed();
  void reset();
  void ticked();
  void close();
}
