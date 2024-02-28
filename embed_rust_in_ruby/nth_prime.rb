require 'ffi'
require 'benchmark'

module EmbeddedRust
  extend FFI::Library
  ffi_lib 'target/release/libnth_prime.so'
  attach_function :nth_prime, [:int], :int
end

module StandardRuby
  def self.nth_prime(n)
    i = 0
    count = 0
    while count <= n
      i += 1
      count += 1 if self.is_prime?(i)
    end
    return i
  end

  def self.is_prime?(num)
    return true if num == 1
    i = 2
    while i < num
      return false if num % i == 0
      i += 1
    end
    true
  end
end

Benchmark.bm(10) do |x|
  number = 5_000
  puts "Embedded Rust at #{number}"
  x.report { EmbeddedRust.nth_prime(number) }
  puts "\n"

  puts "Standard Ruby at #{number}"
  x.report { StandardRuby.nth_prime(number) }
  puts "\n"

  number = 10_000
  puts "Embedded Rust at #{number}"
  x.report { EmbeddedRust.nth_prime(number) }
  puts "\n"

  puts "Standard Ruby at #{number}"
  x.report { StandardRuby.nth_prime(number) }
  puts "\n"
end
