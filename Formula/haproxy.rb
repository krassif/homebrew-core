require 'formula'

class Haproxy < Formula
  homepage 'http://haproxy.1wt.eu'
  url 'http://www.haproxy.org/download/1.5/src/haproxy-1.5.0.tar.gz'

  bottle do
    cellar :any
    sha256 "c9978b6fa1153a4b5d2873b2c0f738be53654ba30b133c4d3eb648f025fc54a3" => :sierra
    sha256 "eb2e9f8b44983b54a993f6abae639bb3d3e12f69c7ae81298fc0870bc7feeb02" => :el_capitan
    sha256 "ef89607a0342812850a845ccce1abcf055d08b1566d60aba04475a5098924b03" => :yosemite
  end

  depends_on 'pcre'

  def install
    args = ["TARGET=generic",
            "USE_KQUEUE=1",
            "USE_POLL=1",
            "USE_PCRE=1",
            "USE_OPENSSL=1",
            "USE_ZLIB=1",
            "ADDLIB=-lcrypto",
    ]

    # We build generic since the Makefile.osx doesn't appear to work
    system "make", "CC=#{ENV.cc}", "CFLAGS=-I/usr/local/opt/openssl/include", "LDFLAGS=-L/usr/local/opt/openssl/lib",  *args
    man1.install "doc/haproxy.1"
    bin.install "haproxy"
  end
end
