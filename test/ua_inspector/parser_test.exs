defmodule UAInspector.ParserTest do
  use ExUnit.Case, async: true

  alias UAInspector.Result

  test "handle incomplete yaml definitions" do
    agent  = "Incomplete YAML entry without model"
    parsed = %Result{ user_agent: agent }

    assert parsed == UAInspector.parse(agent)
  end

  test "parse empty" do
    agent  = ""
    parsed = %Result{ user_agent: agent }

    assert parsed == UAInspector.parse(agent)
  end

  test "parse unknown" do
    agent  = "some unknown user agent"
    parsed = %Result{ user_agent: agent }

    assert parsed == UAInspector.parse(agent)
  end


  test "parse #1" do
    agent  = "Mozilla/5.0 (iPad; CPU OS 7_0_4 like Mac OS X) AppleWebKit/537.51.1 (KHTML, like Gecko) Version/7.0 Mobile/11B554a Safari/9537.53"
    parsed = %Result{
      user_agent: agent,
      client:     %Result.Client{ name: "Mobile Safari", type: "browser", version: "7.0" },
      device:     %Result.Device{ brand: "Apple", model: "iPad", type: "tablet" },
      os:         %Result.OS{ name: "iOS", version: "7_0_4" }
    }

    assert parsed == UAInspector.parse(agent)
  end

  test "parse #2" do
    agent  = "Tiphone T67/1.0 Browser/wap2.0 Sync/SyncClient1.1 Profile/MIDP-2.0 Configuration/CLDC-1.1"
    parsed = %Result{
      user_agent: agent,
      client:     :unknown,
      device:     %Result.Device{ brand: "TiPhone", model: "T67", type: "smartphone" },
      os:         :unknown
    }

    assert parsed == UAInspector.parse(agent)
  end

  test "parse #3" do
    agent  = "Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Trident/5.0; Xbox)"
    parsed = %Result{
      user_agent: agent,
      client:     %Result.Client{ name: "Internet Explorer", type: "browser", version: "9.0" },
      device:     :unknown,
      os:         :unknown
    }

    assert parsed == UAInspector.parse(agent)
  end
end
