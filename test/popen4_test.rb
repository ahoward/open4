require 'test_case'

module Open4

class POpen4Test < TestCase
  def test_unknown_command_propagates_exception
    unknown_cmd = 'asdfadsfjlkkk'
    err = assert_raises(Errno::ENOENT, Errno::EINVAL) { popen4 unknown_cmd }
    assert_match /#{unknown_cmd}/, err.to_s if on_mri?
  end

  def test_exit_failure
    code = 43
    cid, _ = popen4 %{ruby -e "exit #{43}"}
    assert_equal code, wait_status(cid)
  end

  def test_exit_success
    cid, _ = popen4 %{ruby -e "exit"}
    assert_equal 0, wait_status(cid)
  end

  def test_passes_child_pid_to_block
    cmd = %{ruby -e "STDOUT.print Process.pid"}
    cid_in_block = nil
    cid_in_fun = nil
    status = popen4(cmd) do |cid, _, stdout, _|
      cid_in_block = cid
      cid_in_fun = stdout.read.to_i
    end
    assert_equal cid_in_fun, cid_in_block
  end

  def test_io_pipes_without_block
    via_msg = 'foo'
    err_msg = 'bar'
    cmd = <<-END
ruby -e "
  STDOUT.write STDIN.read
  STDERR.write '#{err_msg}'
"
    END
    cid, stdin, stdout, stderr = popen4 cmd
    stdin.write via_msg
    stdin.close
    out_actual = stdout.read
    err_actual = stderr.read
    assert_equal via_msg, out_actual
    assert_equal err_msg, err_actual
    assert_equal 0, wait_status(cid)
  end

  def test_io_pipes_with_block
    via_msg = 'foo'
    err_msg = 'bar'
    out_actual, err_actual = nil
    cmd = <<-END
ruby -e "
  STDOUT.write STDIN.read
  STDERR.write '#{err_msg}'
"
    END
    status = popen4(cmd) do |_, stdin, stdout, stderr|
      stdin.write via_msg
      stdin.close
      out_actual = stdout.read
      err_actual = stderr.read
    end
    assert_equal via_msg, out_actual
    assert_equal err_msg, err_actual
    assert_equal 0, status.exitstatus
  end
end

end