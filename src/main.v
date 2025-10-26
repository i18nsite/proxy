module main

import os
import db.redis

fn main() {
	redis_node := os.getenv('R_NODE')
	if redis_node == '' {
		println('R_NODE environment variable not set')
		return
	}

	parts := redis_node.split(':')
	if parts.len != 2 {
		println('Invalid R_NODE format. Expected host:port')
		return
	}
	host := parts[0]
	port := parts[1].int()

	redis_pass := os.getenv('R_PASSWORD')
	redis_resp_str := os.getenv('R_RESP')
	redis_resp := if redis_resp_str != '' { redis_resp_str.int() } else { 2 } // Default to RESP2

	config := redis.Config{
		host:     host
		port:     u16(port)
		password: redis_pass
		version:  redis_resp
	}

	mut r := redis.connect(config) or { panic('failed to connect to redis: ${err}') }

	defer {
		r.close() or {}
	}

	res := r.ping() or { panic('failed to ping redis: ${err}') }

	println('ping redis: ${res}')
}
